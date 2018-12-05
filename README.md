# CXMVVMTableViewDemo
MVVM 设计模式在 TableView 中的实践应用

效果如下图：
 
![](https://github.com/sunrisechen007/CXMVVMTableViewDemo/blob/master/mvvm_list_demo.gif)


核心代码： 

### 一、 `Controller` 层： 处理 ViewModel 和 View

```javascript
/**
 下拉刷新
 */
- (void)tableViewDidTriggerHeaderRefresh {
    MJWeakSelf
    [self.viewModel requestDataWithPage:1 planId:self.planId success:^(NSArray *datas) {
        [weakSelf refreshDidFinish];
        weakSelf.viewModel.currentPage = 1;
    } failure:^(NSString *tip) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:tip];
        });
        [weakSelf refreshDidFinish];
    }];
}
```


### 二、 `ViewModel` 层:  处理网络请求、数据展示等逻辑,返回值通过 block 回调到 Controller 层

```python
- (void)requestDataWithPage:(NSInteger)page
                     planId:(NSString *)planId
                    success:(void(^)(NSArray *))success
                    failure:(void(^)(NSString *))failure {
    NSDictionary *dictPara = @{
              @"userId": @([UserInfo shareInstance].userId),
              @"page.pageSize": @(10),
              @"page.currentPage": @(page),
              @"planId": planId };
    MJWeakSelf
    [HttpRequest requestWithUrl:[HTTPInterface cx_planSign] withParamters:dictPara isPost:YES success:^(id responseData) {
        if ([responseData[@"success"] boolValue]) {
            if ([responseData[@"entity"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *tempDict = responseData[@"entity"];
                if ([tempDict isKindOfClass:[NSDictionary class]]) {
                    // 1. 页码
                    if ([[tempDict allKeys] containsObject:@"page"]) {
                        if ([[tempDict[@"page"] allKeys] containsObject:@"totalPageSize"]) {
                            weakSelf.totoalPageSize = [tempDict[@"page"][@"totalPageSize"] intValue];
                        }
                    }
                    if (page < weakSelf.totoalPageSize) {
                        self.showMJFooterNomoreData = NO;
                    } else {
                        self.showMJFooterNomoreData = YES;
                    }
                    // 2. 数据源
                    if ([[tempDict allKeys] containsObject:@"signcheckList"]) {
                        if (page == 1) { // 下拉刷新
                            if (weakSelf.totoalPageSize <= 1) { //
                                weakSelf.showMJFooter = NO;
                            } else {
                                weakSelf.showMJFooter = YES;
                            }
                            [weakSelf.dataArray removeAllObjects];
                        }
                        NSArray *signcheckList = tempDict[@"signcheckList"];
                        for (NSDictionary *dict in signcheckList) {
                            CXSignRecordCellViewModel *viewModel = [self getViewModelWithDict:dict];
                            [weakSelf.dataArray addObject:viewModel];
                        }
                    } else {
                        [weakSelf.dataArray removeAllObjects];
                    }
                    success(weakSelf.dataArray);
                }
            }
        } else {
            NSString *erroTip = [NSString stringWithFormat:@"%@",responseData[@"message"]];
            failure(erroTip);
        }
    } failure:^(NSError *error) {
        failure(kNetworkErrorTip);
    }];
}
```
 
 
### 三、 `Model` 层: 负责简单的数据模型创建
 
 ```python
@interface CXSignRecordModel : NSObject
@property (nonatomic, copy) NSString *checkinTime;
@property (nonatomic, copy) NSString *checkoutTime;
@property (nonatomic, copy) NSString *checkinStatus;
@property (nonatomic, copy) NSString *checkoutStatus;
@end
 ```
 
 
### 四、 `View` 层: 负责对需要使用的 view 进行封装
 
 ```python
@class CXSignRecordCellViewModel;

@interface CXSignRecordTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
/**
 数据源
 */
@property (nonatomic, strong) NSArray <CXSignRecordCellViewModel*> *dataArray;

/**
 初始化
 */
+ (instancetype)loadRecordListViewWithFrame:(CGRect)frame;

@end
 ```
 

 