//
//  AfterLoginViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-13.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "AfterLoginViewController.h"
#import "CommonUtil.h"

@interface AfterLoginViewController ()
@property UIColor *mainColor;
@property UIColor *darkColor;
@end

@implementation AfterLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    self.topView.image = [UIImage imageNamed:@"welcomeImage.jpg"];
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    self.nameLabel.text = [storeData.customerProfile valueForKey:@"name"];
    self.view.backgroundColor = self.mainColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
