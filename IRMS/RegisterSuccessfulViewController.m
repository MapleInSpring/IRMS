//
//  RegisterSuccessfulViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-14.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "RegisterSuccessfulViewController.h"
#import "CommonUtil.h"

@interface RegisterSuccessfulViewController ()
@property UIColor *mainColor;
@property UIColor *darkColor;
@end

@implementation RegisterSuccessfulViewController

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
    self.congratsView.image = [UIImage imageNamed:@"congrats.jpg"];
    self.view.backgroundColor = self.mainColor;
    self.successMessage.backgroundColor = self.mainColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)continueWithOrders:(id)sender {
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    if(storeData.signUpWithOrders)
        [self performSegueWithIdentifier:@"registerSucessToReserved" sender:self];
    else
        [self performSegueWithIdentifier:@"registerSuccessToHomePage" sender:self];
    
}

@end
