//
//  CXSignRecordHeadView.m
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import "CXSignRecordHeadView.h"

@implementation CXSignRecordHeadView

+ (instancetype)headerView {
    CXSignRecordHeadView *header = [[NSBundle mainBundle] loadNibNamed:@"CXSignRecordHeadView" owner:nil options:nil].firstObject;
    return header;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (CGFloat)viewHeight {
    return 35.f;
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}


@end
