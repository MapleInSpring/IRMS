//
//  ConfirmHotelReservationController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol modalVCDismissed

-(void)didDismissModalVC;

@end

@interface ConfirmHotelReservationController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *roomsTable;
@property (weak) id<modalVCDismissed>myDelagate;
//- (IBAction)dismissButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backToHotelList;
@property (weak, nonatomic) IBOutlet UIView *myTopView;
@property (weak, nonatomic) IBOutlet UILabel *myTopLabel;

@end
