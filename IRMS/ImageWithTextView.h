//
//  ImageWithTextView.h
//  IRMS
//
//  Created by Yifeng Hou on 13-10-22.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWithTextView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UITextView *myText;
@property (weak, nonatomic) IBOutlet UIView *myMainView;

@end
