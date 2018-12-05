//
//  CXSignRecordTableView.h
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import <UIKit/UIKit.h>
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
