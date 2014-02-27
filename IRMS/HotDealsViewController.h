//
//  HotDealsViewController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-11-14.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotDealsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end
