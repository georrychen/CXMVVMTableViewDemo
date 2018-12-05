//
//  CXSignRecordTableViewCell.h
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSignRecordCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXSignRecordTableViewCell : UITableViewCell

/**
 绑定数据模型
 */
- (void)bindViewModel:(CXSignRecordCellViewModel *)viewModel;

/**
 标识
 */
+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
