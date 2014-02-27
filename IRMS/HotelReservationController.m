//
//  HotelReservationController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "HotelReservationController.h"
#import "AFHTTPClient.h"
#import "CommonUtil.h"
#import "AFJSONRequestOperation.h"


@interface HotelReservationController ()
@property (weak, nonatomic) IBOutlet UILabel *ConfirmedHotelLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberOfGuestsPerRoom;
@property (weak, nonatomic) IBOutlet UITextField *numberOfRooms;
@property (weak, nonatomic) IBOutlet UIButton *confirmReservation;
@property (weak, nonatomic) IBOutlet UITextField *checkinDate;
@property (weak, nonatomic) IBOutlet UITextField *checkoutDate;

@property UIColor *mainColor;
@property UIColor *darkColor;

//@property (weak, nonatomic) NSString *checkInputResponse;

@end

@implementation HotelReservationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"initialize scroll view");
    self.myScrollView.scrollEnabled = true;
    [self.myScrollView setContentSize:CGSizeMake(320, 1000)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];


    self.myCriteriaView.backgroundColor = self.mainColor;
    
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    NSLog(@"%@",storeData.selectedHotelName);
    
    
    self.myTopView.backgroundColor = self.darkColor;
    self.myTopLabel.text = storeData.selectedHotelName;
    self.numberOfRooms.delegate = self;
    self.numberOfGuestsPerRoom.delegate = self;
    self.checkinDate.delegate = self;
    self.checkoutDate.delegate = self;
    //self.ConfirmedHotelLabel.text = storeData.selectedHotelName;
    [self.confirmReservation addTarget:self action:@selector(getTextValue:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", storeData.selectedHotelName];
    
    self.hotelInformationView.backgroundColor = self.mainColor;
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(2, 2, 200, 150)];
    myImageView.image = [UIImage imageNamed:imageName];
    [self.hotelInformationView addSubview:myImageView];
    
    UITextView *hotelInfor = [[UITextView alloc] initWithFrame:CGRectMake(210, 2, 100, 190)];
    //UILabel *hotelInfo = [[UILabel alloc]initWithFrame:CGRectMake(210, 2, 100, 190)];
    NSString *content = [NSString stringWithFormat:@"%@ is nested on a beautiful hillside comes with comprehensive five star hotel facilities", storeData.selectedHotelName];
    hotelInfor.text = content;
    //hotelInfo.text = content;
    hotelInfor.backgroundColor = self.mainColor;
    [self.hotelInformationView addSubview:hotelInfor];
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
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//-(void)startHttpRequest{
//    NSLog(@"Loading ");
//    NSURL *baseUrl = [NSURL URLWithString:@"http://172.28.178.53:8080/IRMSExternal/webresources/"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
//    
//    
//    
//    
//    [httpClient setParameterEncoding:AFJSONParameterEncoding];
//    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    
//    [httpClient postPath:@"accom/receiveReservation" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"Request Successful, response '%@'", responseStr);
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
//    }];
//    
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//        
//    if([segue.identifier isEqualToString:@"present_CHR"]){
//        ConfirmHotelReservationController *vc = [segue destinationViewController];
//        vc.myDelagate = self;
//    }
//    
//}

-(NSString *) checkInputValid{
    
    NSLog(@"Enter checkInputValid");
    
    if(([self.checkinDate.text length] == 0) || ([self.checkoutDate.text length] == 0) || ([self.numberOfGuestsPerRoom.text length] == 0) || ([self.numberOfRooms.text length] == 0)){

        return @"NullInput";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MM/dd/yyy"];
    NSDate *checkinDay = [dateFormatter dateFromString:self.checkinDate.text];
    NSDate *checkoutDay = [dateFormatter dateFromString:self.checkoutDate.text];
    if((checkinDay == nil)||(checkoutDay == nil))
        return @"DateFormatError";    
    
    return @"InputValid";
    
}

-(void)getTextValue:(id)sender {
    
    NSString *response = [self checkInputValid];
    
    if([response isEqualToString:@"InputValid"]){
        
        //[self startHttpRequest];
        
        CommonUtil *storeData = [CommonUtil getSharedInstance];
        
        NSLog(@"checkin Date is %@", self.checkinDate.text);
        NSMutableDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:storeData.selectedHotelName,@"hotelName",self.checkinDate.text,@"checkinDate",self.checkoutDate.text,@"checkoutDate",self.numberOfGuestsPerRoom.text, @"numOfGuestPerRoom", self.numberOfRooms.text, @"numOfRooms", nil];
        NSLog(@"checkin Date is %@", self.checkinDate.text);        
        [storeData setParams:params];
        
        [self performSegueWithIdentifier:@"present_CHR" sender:self];
        
    }else if([response isEqualToString:@"DateFormatError"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: response message:@"Please input date according to format" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([response isEqualToString:@"NullInput"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: response message:@"Input cannot be null" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
    }
}

-(void)didDismissModalVC{
    
    [self performSegueWithIdentifier:@"segue_to_VAHC" sender:self];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
