//
//  CXSignRecordViewModel.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import "CXSignRecordViewModel.h"
#import "CXSignRecordCellViewModel.h"

@interface CXSignRecordViewModel ()
/*! 总页数 */
@property (nonatomic, assign) NSInteger totoalPageSize;

@end

@implementation CXSignRecordViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.currentPage = 1;
        self.totoalPageSize = 1;
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

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

- (CXSignRecordCellViewModel *)getViewModelWithDict:(NSDictionary *)dict {
    CXSignRecordModel *model = [CXSignRecordModel modelWithDictionary:dict];
    CXSignRecordCellViewModel *viewModel = [[CXSignRecordCellViewModel alloc] initWithModel:model];
    return viewModel;
}

@end
