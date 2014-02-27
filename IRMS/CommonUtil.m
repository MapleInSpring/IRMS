//
//  CommonUtil.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

static CommonUtil *sharedInstance;

-(id)init{
    if((self =  [super init])){
        self.loginYet = false;
        self.signUpWithOrders = false;
    }
    
    return self;
}

+(CommonUtil*)getSharedInstance{
    
    
    if(!sharedInstance){
        sharedInstance = [[CommonUtil alloc] init];
        
    }
    
    return  sharedInstance;
}
@end
