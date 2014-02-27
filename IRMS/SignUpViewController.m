//
//  SignUpViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-13.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "SignUpViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SBJsonParser.h"
#import "CommonUtil.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *birth;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *nation;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UITextField *postal;

@property UIColor *mainColor;
@property UIColor *darkColor;


@end

@implementation SignUpViewController

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
    self.titleTextField.delegate = self;
    self.name.delegate = self;
    self.email.delegate = self;
    self.birth.delegate = self;
    self.phone.delegate = self;
    self.nation.delegate = self;
    self.address.delegate = self;
    self.country.delegate = self;
    self.postal.delegate = self;
    
    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    
    self.topView.backgroundColor = self.darkColor;
    self.mainView.backgroundColor = self.mainColor;
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
    const int movementDistance = 80; // tweak as needed
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

- (void)startHttpRequest:(NSDictionary *)cusInfo{
    NSLog(@"Loading ");
    NSURL *baseUrl = [NSURL URLWithString:@"http://192.168.0.105:8080/IRMSExternal/webresources/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:@"accom/signupCustomer" parameters:cusInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        NSLog(@"success %@", responseStr);
        CommonUtil *storeData = [CommonUtil getSharedInstance];
        [storeData setLoginYet:true];
        [storeData setCustomerProfile:cusInfo];
        [self performSegueWithIdentifier:@"signUpToSuccess" sender:self];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];

}

- (IBAction)signUpCustomer:(id)sender {
    NSLog(@"title read %@", self.titleTextField.text);
    NSMutableDictionary *cusInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.titleTextField.text, @"title", self.name.text, @"name", self.email.text, @"email", self.birth.text, @"dateOfBirth", self.phone.text, @"phoneNum", self.nation.text, @"nation", self.address.text, @"address", self.country.text, @"country", self.postal.text, @"postalCode", nil];
    
    NSLog(@"%@", cusInfo);
    [self startHttpRequest:cusInfo];
    
    //[self performSegueWithIdentifier:@"signUpToReserved" sender:self];
}


@end
