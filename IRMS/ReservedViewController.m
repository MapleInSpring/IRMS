//
//  ReservedViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-9.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "ReservedViewController.h"
#import "CommonUtil.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SBJsonParser.h"

@interface ReservedViewController ()
@property NSMutableDictionary *params;
@property NSMutableArray *reservationNumber;
@property UIColor *mainColor;
@property UIColor *darkColor;
@end

@implementation ReservedViewController

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
    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    self.middleLabel.backgroundColor = self.darkColor;
    self.middleText.backgroundColor = self.mainColor;
    self.view.backgroundColor = self.mainColor;
	// Do any additional setup after loading the view.
    self.reservationNum.dataSource = self;
    self.reservationNum.delegate = self;
    [self startHttpRequest];
    self.view.backgroundColor = self.mainColor;
    self.reservationNumber = [NSMutableArray array];
    self.topImage.image = [UIImage imageNamed:@"register.jpg"];
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    NSDictionary *cusInfo = storeData.customerProfile;
    NSString *cusName = [cusInfo objectForKey:@"name"];
    self.middleLabel.backgroundColor = self.darkColor;
    self.middleLabel.text = [NSString stringWithFormat:@"Dear %@", cusName];
    self.reservationNum.backgroundColor = self.mainColor;
}

-(void) startHttpRequest{
    NSLog(@"Loading ");
    NSURL *baseUrl = [NSURL URLWithString:@"http://192.168.0.105:8080/IRMSExternal/webresources/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    
    CommonUtil *storeData = [CommonUtil getSharedInstance];
//    self.params = storeData.params;
//    NSLog(@"%@",self.params);
    NSMutableArray *reservationParams = storeData.reservationParams;
    NSLog(@"%@", reservationParams);
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    for(NSDictionary *param in reservationParams){
    
        [httpClient postPath:@"accom/createReservation" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseStr);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *data = [parser objectWithString:responseStr];


            NSLog(@"%@",[data valueForKey:@"reservationNum"]);
            NSLog(@"%@", [data valueForKey:@"type"]);
            NSNumber *rese = [data valueForKey:@"reservationNum"];
            
            [self.reservationNumber addObject:[rese stringValue]];
            [self.reservationNum reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"number of rows %i", self.reservationNumber.count);
    
    return self.reservationNumber.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
                                        
    }
    NSString *content = [NSString stringWithFormat:@"Reservation Number for Selection %i : %@", (indexPath.row+1), [self.reservationNumber objectAtIndex:indexPath.row]];
    cell.textLabel.text = content;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToAllHotels:(id)sender {
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    [storeData setSignUpWithOrders:false];
    [self performSegueWithIdentifier:@"reservedToAllHotels" sender:self];
}



@end
