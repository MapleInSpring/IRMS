//
//  ViewAllHotelsController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface ViewAllHotelsController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *hotelTable;
@property (strong, nonatomic) UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIView *myTopView;

@end
