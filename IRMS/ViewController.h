//
//  ViewController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "LeftMenuViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *irMainScroll;
@property (weak, nonatomic) IBOutlet UIView *irTopView;
@property (weak, nonatomic) IBOutlet UILabel *irTopViewLabel;

@end
