//
//  AttractionViewController.h
//  IRMS
//
//  Created by Yifeng Hou on 13-11-13.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttractionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *mytable;


@end
