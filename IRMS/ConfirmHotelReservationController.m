//
//  ConfirmHotelReservationController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "ConfirmHotelReservationController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "CommonUtil.h"
#import "CustomCell.h"
#import "SBJsonParser.h"

@interface ConfirmHotelReservationController ()

@property NSMutableArray *roomTypeArray;
@property NSMutableArray *numLeftArray;
@property NSMutableArray *priceHArray;
@property NSMutableArray *priceLArray;
@property NSMutableArray *roomTypeIdsArray;
@property NSMutableArray *tableCells;
@property UIColor *mainColor;
@property UIColor *darkColor;

@property (strong, nonatomic) NSMutableDictionary *params;

@end

@implementation ConfirmHotelReservationController

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
    NSLog(@"Entering confirmHotelReservation");

    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    
    self.roomsTable.delegate = self;
    self.roomsTable.dataSource = self;
    self.roomsTable.backgroundColor = self.mainColor;    
    
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    self.myTopView.backgroundColor = self.darkColor;
    self.myTopLabel.text = [NSString stringWithFormat:@"%@ %@", @"Rooms Available in", storeData.selectedHotelName];
    
    self.roomTypeArray = [NSMutableArray array];
    self.numLeftArray = [NSMutableArray array];
    self.priceHArray = [NSMutableArray array];
    self.priceLArray = [NSMutableArray array];
    self.roomTypeIdsArray = [NSMutableArray array];
    self.tableCells = [NSMutableArray array];
    
    [self startHttpRequest];        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.roomTypeArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"CustomCell";

    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        

        cell.roomType.text = [self.roomTypeArray objectAtIndex:indexPath.row];
        
        cell.numLeft.text = [self.numLeftArray objectAtIndex:indexPath.row];
        cell.quantity.placeholder = @"0";
        cell.quantity.delegate = self;
        [cell.quantity setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [self.roomTypeArray objectAtIndex:indexPath.row]];
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(2, 2, 100, 75)];
        myImageView.image = [UIImage imageNamed:imageName];
        [cell addSubview:myImageView];        
        
        NSLog(@"add cell to tablecells %i", indexPath.row);
        [self.tableCells insertObject:cell atIndex:indexPath.row];
        
    }

    
    return cell;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)startHttpRequest{
    NSLog(@"Loading ");
    NSURL *baseUrl = [NSURL URLWithString:@"http://192.168.0.105:8080/IRMSExternal/webresources/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];

    CommonUtil *storeData = [CommonUtil getSharedInstance];
    self.params = (NSMutableDictionary *) storeData.params;
    NSLog(@"%@",self.params);

    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];

    [httpClient postPath:@"accom/searchAvailableRooms" parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];        
        SBJsonParser *parser = [[SBJsonParser alloc] init];        
        NSArray *data = [parser objectWithString:responseStr];
        //prepare data
        for(NSDictionary *dict in data){
            
            
            NSString *type = [dict valueForKey:@"type"];
            
            [self.roomTypeArray addObject:type];
            
            NSNumber *totalNum = [dict valueForKey:@"totalNum"];
            NSString *totalNumString = [totalNum stringValue];
            totalNumString = [NSString stringWithFormat:@"%@ %@", totalNumString, @"left"];
            [self.numLeftArray addObject:totalNumString];
            
            NSNumber *priceHigh = [dict valueForKey:@"price_h"];
            NSString *priceHighString = [priceHigh stringValue];
            [self.priceHArray addObject:priceHighString];
            
            NSNumber *priceLow = [dict valueForKey:@"price_l"];
            NSString *priceLowString = [priceLow stringValue];
            [self.priceLArray addObject:priceLowString];
            
            NSNumber *roomTypeId = [dict valueForKey:@"roomtypeId"];
            NSString *roomTypeIdString = [roomTypeId stringValue];
            [self.roomTypeIdsArray addObject:roomTypeIdString];
        }
        

        [self.roomsTable reloadData];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];

    
    [self.roomsTable reloadData];
}


- (IBAction)backToListHotel:(id)sender {
    [self performSegueWithIdentifier:@"ConfirmToAllHotels" sender:self];
}

- (IBAction)reserveRooms:(id)sender {
    
    NSLog(@"enter reserverooms");
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    
    NSMutableArray *reservationParams = [[NSMutableArray alloc] init];
    
    for(CustomCell *cell in self.tableCells){
        if([cell.quantity.text length] != 0){
            NSLog(@"quantity caught by cell %@", cell.quantity.text);            
            NSLog(@"room type id selected is %@", [self.roomTypeIdsArray objectAtIndex:[self.tableCells indexOfObject:cell]]);
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:self.params];
            
            [temp setObject:[self.roomTypeIdsArray objectAtIndex:[self.tableCells indexOfObject:cell]] forKey:@"roomTypeId"];
            [temp setObject:cell.quantity.text forKey:@"roomQuantity"];
            [reservationParams addObject:temp];
        }
    }
    
    NSLog(@"size of final params %i", reservationParams.count);
    
    [storeData setReservationParams:reservationParams];
    
    if(!storeData.loginYet){
        NSLog(@"go to sign up");
        [storeData setSignUpWithOrders:true];
        [self performSegueWithIdentifier:@"confirmedToSignUp" sender:self];
    }else{
        NSLog(@"go to reservation");
        [self performSegueWithIdentifier:@"confirmToReserved" sender:self];
    }
}



@end
