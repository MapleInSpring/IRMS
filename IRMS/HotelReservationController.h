//
//  HotelReservationController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmHotelReservationController.h"

@interface HotelReservationController : UIViewController<modalVCDismissed, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *myTopView;
@property (weak, nonatomic) IBOutlet UILabel *myTopLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *myCriteriaView;
@property (weak, nonatomic) IBOutlet UIView *hotelInformationView;

@end
