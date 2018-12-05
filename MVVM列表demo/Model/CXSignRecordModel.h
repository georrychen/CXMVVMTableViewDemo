//
//  CXSignRecordModel.h
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXSignRecordModel : NSObject

//checkinTime    "2018-02-22 10:42:42"
/**
 签到时间
 
 1.如果signcheck.checkinTime有值，显示时间，时间后面括号中判断signcheck.checkinStatus==1显示正常两个字
 2.如果signcheck.checkinTime为空，判断signcheck.checkinStatus，signcheck.checkinStatus=3显示未签到，signcheck.checkinStatus=5显示“--”
 */
@property (nonatomic, copy) NSString *checkinTime;

//checkoutTime    "2018-02-22 13:07:06"
/**
 签退时间
 
 1.如果signcheck.checkoutTime有值，显示时间，时间后面括号中判断signcheck.checkoutStatus==1显示正常
 2.signcheck.checkoutTime为空，判断signcheck.checkoutStatus == 3未签到，signcheck.checkoutStatus == 5显示“--”
 */
@property (nonatomic, copy) NSString *checkoutTime;

/**
 出勤状态
 
 五种状态
 第一种：signcheck.checkinStatus==1&&signcheck.checkoutStatus==1 正常
 第二种：sigcheck.checkinStatus==3&&signcheck.checkoutStatus==1  迟到
 第三种：signcheck.checkinStatus==1&&signcheck.checkoutStatus==3 早退
 第四种：signcheck.checkinStatus==3&&signcheck.checkoutStatus==3 未出勤
 第五种：为空或者用--代表
 */
@property (nonatomic, copy) NSString *checkinStatus;
@property (nonatomic, copy) NSString *checkoutStatus;

//id    464
@property (nonatomic, copy) NSString *ID;
//planId    1117
@property (nonatomic, copy) NSString *planId;
//name    "培训经营体培训补签"
@property (nonatomic, copy) NSString *name;


// MARK: - 未使用到
//beginTimeStart    "2018-02-22 10:30:00"
//beginTimeEnd    "2018-02-22 11:00:00"
//finishTimeStart    "2018-02-22 12:30:00"
//finishTimeEnd    "2018-02-22 13:20:00"
//checkInNum    0
//checkOutNum    0
//checkTotal    0
//carryOut    0
//absenteeism    0

@end

NS_ASSUME_NONNULL_END
