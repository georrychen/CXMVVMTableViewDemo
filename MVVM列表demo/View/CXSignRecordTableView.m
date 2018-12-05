//
//  CXSignRecordTableView.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import "CXSignRecordTableView.h"
#import "CXSignRecordTableViewCell.h"
#import "CXSignRecordCellViewModel.h"
#import "CXSignRecordHeadView.h"

@implementation CXSignRecordTableView

+ (instancetype)loadRecordListViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = UIColor.whiteColor;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [UIView new];
        
        [self registerNib:[UINib nibWithNibName:@"CXSignRecordTableViewCell" bundle:nil] forCellReuseIdentifier:[CXSignRecordTableViewCell identifier]];
        [self registerNib:[UINib nibWithNibName:@"CXSignRecordHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:[CXSignRecordHeadView identifier]];
    }
    return self;
}

- (void)setDataArray:(NSArray<CXSignRecordCellViewModel *> *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

// MARK: - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXSignRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CXSignRecordTableViewCell identifier]];
    CXSignRecordCellViewModel *viewModel = self.dataArray[indexPath.row];
    [cell bindViewModel:viewModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXSignRecordCellViewModel *viewModel = self.dataArray[indexPath.row];
    return viewModel.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CXSignRecordHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CXSignRecordHeadView identifier]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [CXSignRecordHeadView viewHeight];
}

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    CXSignRecordHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CXSignRecordHeadView identifier]];
//    [headerView.backgroundView setBackgroundColor:[UIColor lightGrayColor]];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
}




@end



