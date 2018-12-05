//
//  CXSignRecordCellViewModel.h
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXSignRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXSignRecordCellViewModel : NSObject
/*! 行高 - 只读*/
@property (nonatomic, assign,readonly) CGFloat cellHeight;
/*! 数据模型 - 外部只可读取，不能修改*/
@property (nonatomic, strong, readonly) CXSignRecordModel *dataModel;
/*! 签到时间 */
@property (nonatomic, strong) NSAttributedString *checkinTimeAttributeString;
/*! 签退时间 */
@property (nonatomic, strong) NSAttributedString *checkoutTimeAttributeString;
/*! 出勤状态 */
@property (nonatomic, strong) NSAttributedString *signStatusAttributeString;

- (instancetype)initWithModel:(CXSignRecordModel *)model;

@end

NS_ASSUME_NONNULL_END
