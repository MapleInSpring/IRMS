//
//  HotDealsViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-14.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "HotDealsViewController.h"
#import "CustomCell.h"

@interface HotDealsViewController ()
@property UIColor *mainColor;
@property UIColor *darkColor;
@property NSArray *shopName;
@property NSArray *shopDescription;
@end

@implementation HotDealsViewController

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
    
    self.topView.backgroundColor = self.darkColor;
    self.view.backgroundColor = self.mainColor;
    
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
    self.mytable.backgroundColor = self.mainColor;
    self.view.backgroundColor = self.mainColor;
    self.shopName = [NSArray arrayWithObjects:@"Royal Foot Massage", @"Beach Resort Stay", @"Japanese Cuisine", @"Glass Tea Set", @"Selena Georgette Blouse", @"Titanium Necklace", @"Andersen's Ice Cream", nil];
    self.shopDescription = [NSArray arrayWithObjects:@"$68 (Worth $168)",@"$789 (Worth $999)", @"$50 (Worth $90)", @"$24.8 (Worth $69.9)", @"$450 (Worth $600)", @"$200 (Worth $500)", @"$15 (Worth $30)", nil];
    
    [self.mytable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"number of rows %i", self.shopName.count);
    
    return self.shopName.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        cell.roomType.text = [self.shopName objectAtIndex:indexPath.row];
        cell.numLeft.text = [self.shopDescription objectAtIndex:indexPath.row];
        [cell.quantity setHidden:true];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [self.shopName objectAtIndex:indexPath.row]];
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(2, 2, 100, 75)];
        myImageView.image = [UIImage imageNamed:imageName];
        [cell addSubview:myImageView];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

@end
