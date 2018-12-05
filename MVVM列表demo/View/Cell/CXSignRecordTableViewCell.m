//
//  CXSignRecordTableViewCell.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import "CXSignRecordTableViewCell.h"

@interface CXSignRecordTableViewCell()
/**
 阶段名称
 */
@property (weak, nonatomic) IBOutlet UILabel *stageNameLabel;
/**
 签到时间
 */
@property (weak, nonatomic) IBOutlet UILabel *checkInTimeLabel;
/**
 签退时间
 */
@property (weak, nonatomic) IBOutlet UILabel *signoutTimeLabel;
/**
 出勤状态
 */
@property (weak, nonatomic) IBOutlet UILabel *attendanceStatusLabel;

@end

@implementation CXSignRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // cell 选中颜色
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:247.0/255.0 blue:249.0/255.0 alpha:1];
    self.selectedBackgroundView = bgView;
    
//    self.checkInTimeLabel.text = @"正常\n13:39\n2018.1.12";
//    self.signoutTimeLabel.text = @"正常\n13:41\n2018.1.12";
}

- (void)bindViewModel:(CXSignRecordCellViewModel *)viewModel {
    self.stageNameLabel.text = viewModel.dataModel.name;
    self.checkInTimeLabel.attributedText = viewModel.checkinTimeAttributeString;
    self.signoutTimeLabel.attributedText = viewModel.checkoutTimeAttributeString;
    self.attendanceStatusLabel.attributedText = viewModel.signStatusAttributeString;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}


@end
