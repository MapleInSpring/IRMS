//
//  CommonUtil.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

@property NSString *passedString;
@property NSString *selectedHotelName;
@property (strong, nonatomic) NSMutableDictionary *params;
@property Boolean loginYet;
@property Boolean signUpWithOrders;
@property NSMutableArray *reservationParams;
@property NSDictionary *customerProfile;
@property NSString *customerId;

+(CommonUtil*)getSharedInstance;

@end
