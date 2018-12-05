//
//  CXSignRecordViewModel.h
//  268EDU_Demo
//
//  Created by Xu Chen on 2018/11/23.
//  Copyright © 2018 edu268. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXSignRecordCellViewModel;

@interface CXSignRecordViewModel : NSObject
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL showMJFooter;
@property (nonatomic, assign) BOOL showMJFooterNomoreData;
@property (nonatomic, strong) NSMutableArray <CXSignRecordCellViewModel*> *dataArray;

- (void)requestDataWithPage:(NSInteger)page
                     planId:(NSString *)planId
                    success:(void(^)(NSArray *))success
                    failure:(void(^)(NSString *))failure;
@end

