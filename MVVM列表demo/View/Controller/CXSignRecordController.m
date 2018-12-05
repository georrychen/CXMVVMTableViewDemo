//
//  CXSignRecordController.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//  内训线下培训签到记录

#import "CXSignRecordController.h"
#import "CXSignRecordTableView.h"
#import "CXSignRecordViewModel.h"

@interface CXSignRecordController ()
@property (nonatomic, strong) CXSignRecordTableView *recordTableView;
@property (nonatomic, strong) CXSignRecordViewModel *viewModel;

@end

@implementation CXSignRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到记录";
    
    [self setupUI];
}

- (void)setupUI {
    // 添加刷新控件
    ChXRefreshGifHeader *mjHeader = [ChXRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerHeaderRefresh)];
    self.recordTableView.mj_header = mjHeader;
    [mjHeader beginRefreshing];
    
    ChXRefreshBackNormalFooter *mjFooter = [ChXRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerFooterRefresh)];
    self.recordTableView.mj_footer = mjFooter;
    self.recordTableView.mj_footer.hidden = YES;
    
    [self.view addSubview:self.recordTableView];
}

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

/**
 上拉事件
 */
- (void)tableViewDidTriggerFooterRefresh{
    MJWeakSelf
    [self.viewModel requestDataWithPage:(self.viewModel.currentPage + 1) planId:self.planId success:^(NSArray *datas) {
        [weakSelf refreshDidFinish];
        weakSelf.viewModel.currentPage += 1;
    } failure:^(NSString *tip) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:tip];
        });
        [weakSelf refreshDidFinish];
    }];
}

/**
 刷新结束, 重置mjfooter状态
 */
- (void)refreshDidFinish {
    [self.recordTableView.mj_header endRefreshing];
    [self.recordTableView.mj_footer endRefreshing];
    
    self.recordTableView.mj_footer.hidden = !self.viewModel.showMJFooter;
    if (self.viewModel.showMJFooterNomoreData) {
        [self.recordTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.recordTableView.mj_footer resetNoMoreData];
    }
    
    self.recordTableView.dataArray = self.viewModel.dataArray;
}

// MARK: - Lazyload

- (CXSignRecordTableView *)recordTableView {
    if (!_recordTableView) {
        _recordTableView = [CXSignRecordTableView loadRecordListViewWithFrame:self.view.bounds];
    }
    return _recordTableView;
}

- (CXSignRecordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CXSignRecordViewModel alloc] init];
    }
    return _viewModel;
}

@end
