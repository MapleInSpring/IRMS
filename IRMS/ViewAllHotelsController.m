//
//  ViewAllHotelsController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "ViewAllHotelsController.h"
#import "AFJSONRequestOperation.h"
#import "CommonUtil.h"
#import "CustomCell.h"

@interface ViewAllHotelsController ()

@property NSMutableArray *addressArray;
@property NSMutableArray *descriptionArray;
@property NSMutableArray *nameArray;
@property UIColor *mainColor;
@property UIColor *darkColor;

@end

@implementation ViewAllHotelsController

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
    
    [self startHttpRequest];
    
    self.hotelTable.delegate = self;
    self.hotelTable.dataSource = self;
    self.hotelTable.backgroundColor = self.mainColor;
    self.hotelTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTopView.backgroundColor = self.darkColor;
    self.view.backgroundColor = self.mainColor;
	// Do any additional setup after loading the view.

    self.nameArray = [NSMutableArray array]; 
    self.addressArray = [NSMutableArray array];
    self.descriptionArray = [NSMutableArray array];
    
//    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.menuBtn.frame = CGRectMake(8, 10, 50, 40);
//    [self.menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
//    [self.menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.menuBtn];
    //[self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"number of rows %i", self.nameArray.count);
    
    return self.nameArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *simpleTableIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        cell.roomType.text = [self.nameArray objectAtIndex:indexPath.row];
        [cell.quantity setHidden:true];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [self.nameArray objectAtIndex:indexPath.row]];
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(2, 2, 100, 75)];
        myImageView.image = [UIImage imageNamed:imageName];
        [cell addSubview:myImageView];
    }
        
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *tempCell = (CustomCell *) [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"%@",tempCell.textLabel.text);
    
    CommonUtil *storeData = [CommonUtil getSharedInstance];
    [storeData setSelectedHotelName:tempCell.roomType.text];
    
    [self performSegueWithIdentifier:@"ReserveHotel" sender:self];
}

-(void)startHttpRequest{
    
    NSLog(@"I am loading");
    NSString *baseUrlString = @"http://192.168.0.105:8080/IRMSExternal/webresources/%@";
    
    NSString *requestUrlString = [NSString stringWithFormat:baseUrlString,@"accom/getHotelInfor"];
    
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:requestUrl];
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSLog(@"%@",JSON);
                                                                                            
                                                                                            for(NSDictionary *dict in JSON){
                                                                                                
                                                                                                
                                                                                                NSString *address = [dict valueForKey:@"address"];
                                                                                                
                                                                                                [self.addressArray addObject:address];
                                                                                                
                                                                                                NSString *description = [dict valueForKey:@"description"];
                                                                                                
                                                                                                [self.descriptionArray addObject:description];
                                                                                                
                                                                                                NSString *name = [dict valueForKey:@"name"];
                                                                                                
                                                                                                [self.nameArray addObject:name];
                                                                                                
                                                                                            }
                                                                                            
                                                                                            [self.hotelTable reloadData];
                                                                                            NSLog(@"finish reloading table");
                                                                                            
                                                                                            
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                                                                                            NSLog(@"failure %@", error);
                                                                                        }];
    
    [operation start];
    
    
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

@end
