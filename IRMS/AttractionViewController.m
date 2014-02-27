//
//  AttractionViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-11-13.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "AttractionViewController.h"
#import "CustomCell.h"

@interface AttractionViewController ()
@property UIColor *mainColor;
@property UIColor *darkColor;
@property NSArray *shopName;
@property NSArray *shopDescription;
@end

@implementation AttractionViewController

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
    self.shopName = [NSArray arrayWithObjects:@"Elephant_Parade", @"Beach_Fun", @"Cartoon_Parade", @"Boating", @"Dolphin_Show", @"Castle_Tour", @"Night_Bar", nil];
//    self.shopDescription = [NSArray arrayWithObjects:@"#B1-141",@"#B2-43", @"#01-19/20", @"#02-28/29/30", @"#01-13", @"01-18", @"#03-02", nil];
    
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
//        cell.numLeft.text = [NSString stringWithFormat:@"At %@", [self.shopDescription objectAtIndex:indexPath.row]];
//        cell.numLeft.textColor = cell.roomType.textColor;
        [cell.quantity setHidden:true];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [self.shopName objectAtIndex:indexPath.row]];
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame: CGRectMake(2, 2, 100, 75)];
        myImageView.image = [UIImage imageNamed:imageName];
        [cell addSubview:myImageView];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

@end
