//
//  CXSignRecordCellViewModel.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import "CXSignRecordCellViewModel.h"

@interface CXSignRecordCellViewModel ()
/*! 数据模型 - 外部只可读取，不能修改*/
@property (nonatomic, strong, readwrite) CXSignRecordModel *dataModel;
@property (nonatomic, assign, readwrite) CGFloat cellHeight;

@end

@implementation CXSignRecordCellViewModel

- (instancetype)initWithModel:(CXSignRecordModel *)model {
    if (self = [super init]) {
        [self initData:model];
    }
    return self;
}

- (void)initData:(CXSignRecordModel *)model {
    self.dataModel = model;
    
    // 行高
    self.cellHeight = 30.f;

    /**
     签到时间
     
     1.如果signcheck.checkinTime有值，显示时间，时间后面括号中判断signcheck.checkinStatus==1显示正常两个字
     2.如果signcheck.checkinTime为空，判断signcheck.checkinStatus，signcheck.checkinStatus=3显示未签到，signcheck.checkinStatus=5显示“--”
     */
    if (kStringIsEmpty(model.checkinTime)) {
        if ([model.checkinStatus integerValue] == 3) {
            self.checkinTimeAttributeString = [self attributedStringWithText:@"(未签到)"];
        } else {
            self.checkinTimeAttributeString = [self attributedStringWithText:@"--"];
        }
    } else {
        if ([model.checkinStatus integerValue] == 1) {
            self.checkinTimeAttributeString = [self formatTimeAttributeString:model.checkinTime];
            self.cellHeight = 55.f;
        } else {
            self.checkinTimeAttributeString = [self attributedStringWithText:@"--"];
        }
    }

    /**
     签退时间
     
     1.如果signcheck.checkoutTime有值，显示时间，时间后面括号中判断signcheck.checkoutStatus==1显示正常
     2.signcheck.checkoutTime为空，判断signcheck.checkoutStatus == 3未签到，signcheck.checkoutStatus == 5显示“--”
     */
    if (kStringIsEmpty(model.checkoutTime)) {
        if ([model.checkoutStatus integerValue] == 3) {
            self.checkoutTimeAttributeString = [self attributedStringWithText:@"(未签退)"];
        } else {
            self.checkoutTimeAttributeString = [self attributedStringWithText:@"--"];
        }
    } else {
        if ([model.checkoutStatus integerValue] == 1) {
            self.checkoutTimeAttributeString = [self formatTimeAttributeString:model.checkoutTime];
            self.cellHeight = 55.f;
        } else {
            self.checkoutTimeAttributeString = [self attributedStringWithText:@"--"];
        }
    }
    
    /**
     出勤状态
     
     五种状态
     第一种：signcheck.checkinStatus==1&&signcheck.checkoutStatus==1 正常
     第二种：sigcheck.checkinStatus==3&&signcheck.checkoutStatus==1  迟到
     第三种：signcheck.checkinStatus==1&&signcheck.checkoutStatus==3 早退
     第四种：signcheck.checkinStatus==3&&signcheck.checkoutStatus==3 未出勤
     第五种：为空或者用--代表
     */
    if ([model.checkinStatus integerValue] == 1) {
        if ([model.checkoutStatus integerValue] == 1) {
            self.signStatusAttributeString =  [self attributedStringWithText:@"正常"];
        } else if ([model.checkoutStatus integerValue] == 3) {
            self.signStatusAttributeString =  [self attributedStringWithText:@"早退"];
        } else {
            self.signStatusAttributeString = [self attributedStringWithText:@"--"];
        }
    } else  if ([model.checkinStatus integerValue] == 3) {
        if ([model.checkoutStatus integerValue] == 1) {
            self.signStatusAttributeString =  [self attributedStringWithText:@"迟到"];
        } else if ([model.checkoutStatus integerValue] == 3) {
            self.signStatusAttributeString =  [self attributedStringWithText:@"未出勤"];
        } else {
            self.signStatusAttributeString = [self attributedStringWithText:@"--"];
        }
    } else {
        self.signStatusAttributeString = [self attributedStringWithText:@"--"];
    }
    
}


/**
 红色文字
 */
- (NSMutableAttributedString *)attributedStringWithText:(NSString *)text {
    NSMutableAttributedString *multStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange textRange = NSMakeRange(0, text.length);
    if ([text isEqualToString:@"(未签到)"] || [text isEqualToString:@"(未签退)"]) {
        [multStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:217/255.0 green:28/255.0 blue:20/255.0 alpha:1] range:textRange];
    } else {
        [multStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] range:textRange];
    }
    [multStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:textRange];
    return multStr;
}

/*
  "2018-02-01 08:00:00" 字符串
 - 转换为 正常\n13:39\n2018.1.12 这种格式的字符串
 */
- (NSMutableAttributedString *)formatTimeAttributeString:(NSString *)text {
    // 解析时间字符串
    // 1. 字符串 转 时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //格式转换，格式必须与时间字符串保持一致, 否则将得不到时间
    NSDate *nowtimeStr = [formatter dateFromString:text];
    
    // 2. 时间 转 字符串
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm"];
    NSString *confromTimespStr = [formatter stringFromDate:nowtimeStr];
    NSLog(@"转换后的时间字符串 - %@", confromTimespStr);
    
    // 3. 拼接成特定样式的字符串
    NSArray *tmpArr = [confromTimespStr componentsSeparatedByString:@" "];
//    正常\n13:39\n2018.1.12
    NSString *formatedString = [NSString stringWithFormat:@"正常\n%@\n%@",tmpArr.lastObject,tmpArr.firstObject];
    
    NSMutableAttributedString *multStr = [[NSMutableAttributedString alloc] initWithString:formatedString];
    
    NSRange textRange = NSMakeRange(0, formatedString.length);
    NSRange minuteRange = NSMakeRange(3, 5);
    NSRange yearRange = NSMakeRange(9, formatedString.length - 9);

    // 所有文字颜色、字体
    [multStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:textRange];
    [multStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] range:textRange];

    // “正常”文字颜色
    [multStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:20/255.0 green:185/255.0 blue:80/255.0 alpha:1] range:NSMakeRange(0, 2)];
    
    // “13:39” 分钟文字字体
    [multStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9.f] range:minuteRange];
    
    // "2018.1.12" 年份文字颜色、字体
    [multStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1] range:yearRange];
    [multStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9.f] range:yearRange];

    return multStr;
}

@end
