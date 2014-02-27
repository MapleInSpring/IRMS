//
//  LoginViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-22.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonUtil.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SBJsonParser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    if(storeData.loginYet)
        [self performSegueWithIdentifier:@"loginToAfterLogin" sender:self];
    
    //set up basic ui
    UIColor* mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
        
    self.view.backgroundColor = mainColor;
    
    self.usernameField.backgroundColor = [UIColor whiteColor];
    //self.usernameField.placeholder = @"Email Address";
    self.usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    self.usernameField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.usernameField.layer.borderWidth = 1.0f;
    self.usernameField.delegate = self;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 20)];
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = leftView;
    
    self.passwordField.backgroundColor = [UIColor whiteColor];
    //self.passwordField.placeholder = @"Password";
    self.passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    self.passwordField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.passwordField.layer.borderWidth = 1.0f;
    self.passwordField.delegate = self;
    
    UIView* leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 20)];
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = leftView2;
    
    self.loginButton.backgroundColor = darkColor;
    self.loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    self.forgotButton.backgroundColor = [UIColor clearColor];
    self.forgotButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    [self.forgotButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.forgotButton setTitleColor:darkColor forState:UIControlStateNormal];
    [self.forgotButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    self.titleLabel.textColor =  [UIColor whiteColor];
    self.titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    self.titleLabel.text = @"GOOD TO SEE YOU";
    
    self.infoLabel.textColor =  [UIColor darkGrayColor];
    self.infoLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    self.infoLabel.text = @"Welcome back, please login below";
    
    self.infoView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    
    self.headerImageView.image = [UIImage imageNamed:@"swim.jpg"];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    
	// Do any additional setup after loading the view.
    // Add menu Button
//    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.menuBtn.frame = CGRectMake(8, 10, 50, 40);
//    [self.menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
//    [self.menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];    
//    [self.view addSubview:self.menuBtn];
//    
//    //set gesture recognizer
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];

    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)revealMenu:(id)sender
//{
//    [self.slidingViewController anchorTopViewTo:ECRight];
//}

- (IBAction)signUpClicked:(id)sender {
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    [storeData setSignUpWithOrders:false];
    [self performSegueWithIdentifier:@"loginToSignUp" sender:self];
}

- (void)startHttpRequest:(NSDictionary *) params{
    NSLog(@"Loading ");
    NSURL *baseUrl = [NSURL URLWithString:@"http://192.168.0.105:8080/IRMSExternal/webresources/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
            
        [httpClient postPath:@"accom/checkLogin" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseStr);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *data = [parser objectWithString:responseStr];
            NSString *response = [data valueForKey:@"name"];
            if([response isEqualToString:@"password account not match"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: response message:response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                NSMutableDictionary *cusInfo = [[NSMutableDictionary alloc] init];
                [cusInfo setObject:[data valueForKey:@"title"] forKey:@"title"];
                [cusInfo setObject:[data valueForKey:@"name"] forKey:@"name"];
                [cusInfo setObject:[data valueForKey:@"email"] forKey:@"email"];
                [cusInfo setObject:[data valueForKey:@"dateOfBirth"] forKey:@"dateOfBirth"];
                [cusInfo setObject:[data valueForKey:@"phoneNum"] forKey:@"phoneNum"];
                [cusInfo setObject:[data valueForKey:@"nation"] forKey:@"nation"];
                [cusInfo setObject:[data valueForKey:@"address"] forKey:@"address"];
                [cusInfo setObject:[data valueForKey:@"country"] forKey:@"country"];
                [cusInfo setObject:[data valueForKey:@"postalCode"] forKey:@"postalCode"];
                NSLog(@"customer info %@",cusInfo);
                CommonUtil *storeData = [CommonUtil getSharedInstance];
                [storeData setCustomerProfile:cusInfo];
                [storeData setLoginYet:true];
                [self performSegueWithIdentifier:@"loginToAfterLogin" sender:self];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
}


- (IBAction)performLogin:(id)sender {
    NSLog(@"user id is %@", self.usernameField.text);
    NSLog(@"user password %@", self.passwordField.text);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text, @"memberId", self.passwordField.text, @"password", nil];
    NSLog(@"%@", params);
    [self startHttpRequest:params];
}


@end
