//
//  ReservedViewController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-11-9.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservedViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UITableView *reservationNum;
@property (weak, nonatomic) IBOutlet UILabel *middleText;

@end
