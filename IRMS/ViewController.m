//
//  ViewController.m
//  IRMS
//
//  Created by Yifeng Hou on 13-10-16.
//  Copyright (c) 2013年 IT05. All rights reserved.
//

#import "ViewController.h"
#import "ImageWithTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property UIColor *mainColor;
@property UIColor *darkColor;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changed) name:UITextFieldTextDidChangeNotification object:self.myTextField];
    
    self.irMainScroll.backgroundColor = [UIColor blackColor];
    // add sliding view
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.backgroundColor = self.mainColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[LeftMenuViewController class]]) {        
        LeftMenuViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];                
        self.slidingViewController.underLeftViewController  = vc;        
    }
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuBtn.frame = CGRectMake(8, 10, 50, 40);
    [self.menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [self.menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];    
    [self.view addSubview:self.menuBtn];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    
    // initiate ui scroll view
    self.irMainScroll.scrollEnabled = true;
    self.irMainScroll.pagingEnabled = true;
    
    //ImageWithTextView *image = [[ImageWithTextView alloc] init];        
    //UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWithText1.myImage.bounds.size.width, imageWithText1.myImage.bounds.size.height)];
    //assert(self.irMainScroll != nil);    
    //NSLog(@"%lf %lf", self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);    
    //UILabel *labelView1 = [[UILabel alloc] initWithFrame:CGRectMake(0, imageWithText1.myImage.bounds.size.height, imageWithText1.myLabel.bounds.size.width, imageWithText1.myLabel.bounds.size.height)];    
    //imageWithText1.myImage = imgView1;
    //imageWithText1.myLabel = labelView1;    
    //assert([UIImage imageNamed:@"fl1.jpg"] != nil);
    
    
    
//    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height)];
//    
//    [imgView2 setImage:[UIImage imageNamed:@"Restaurants.jpg"]];
//    
//    
//    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height)];
//    
//    [imgView3 setImage:[UIImage imageNamed:@"Attractions.jpg"]];
//    
//    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(3*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height)];
//    
//    [imgView4 setImage:[UIImage imageNamed:@"ShoppingMall.jpg"]];
//    
//    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(4*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height)];
//    
//    [imgView5 setImage:[UIImage imageNamed:@"Entertainment.jpg"]];
    UIColor* mainColor = [UIColor colorWithRed:167.0/255 green:206.0/255 blue:241.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:90.0/255 green:123.0/255 blue:154.0/255 alpha:1.0f];

    NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:@"ImageWithText" owner:self options:nil];
    ImageWithTextView *imageWithText1 = [nib1 objectAtIndex:0];
    imageWithText1.frame = CGRectMake(0, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);
    [imageWithText1.myImage setImage:[UIImage imageNamed:@"Accommodation.jpg"]];
    [imageWithText1.myLabel setText:@"Accommodation"];
    [imageWithText1.myLabel setBackgroundColor:mainColor];
    [imageWithText1.myText setBackgroundColor:darkColor];
    [imageWithText1.myText setText:@"Singleton Hotel resides on a small hill, overlooking Siloso Beach. It comes with various amenities for full family fun"];
    
    NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"ImageWithText" owner:self options:nil];
    ImageWithTextView *imageWithText2 = [nib2 objectAtIndex:0];
    imageWithText2.frame = CGRectMake(self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);
    [imageWithText2.myImage setImage:[UIImage imageNamed:@"ShoppingMall.jpg"]];
    [imageWithText2.myLabel setText:@"ShoppingMall"];
    [imageWithText2.myLabel setBackgroundColor:mainColor];
    [imageWithText2.myText setBackgroundColor:darkColor];
    [imageWithText2.myText setText:@"Luxury Fashion brings together some of the world's most desirable and exclusive luxury brands in a distinctive and exceptionally stylish environment."];
    
    NSArray *nib3 = [[NSBundle mainBundle] loadNibNamed:@"ImageWithText" owner:self options:nil];
    ImageWithTextView *imageWithText3 = [nib3 objectAtIndex:0];
    imageWithText3.frame = CGRectMake(2*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);
    [imageWithText3.myImage setImage:[UIImage imageNamed:@"Restaurants.jpg"]];
    [imageWithText3.myLabel setText:@"Restaurants"];
    [imageWithText3.myLabel setBackgroundColor:mainColor];
    [imageWithText3.myText setBackgroundColor:darkColor];
    [imageWithText3.myText setText:@"Coral Island Resort has all kinds of cuisines from all around the world, including Japanese sushi, Chinese fried rice and so on. Your family will have a great meal here."];
    
    NSArray *nib4 = [[NSBundle mainBundle] loadNibNamed:@"ImageWithText" owner:self options:nil];
    ImageWithTextView *imageWithText4 = [nib4 objectAtIndex:0];
    imageWithText4.frame = CGRectMake(3*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);
    [imageWithText4.myImage setImage:[UIImage imageNamed:@"Attractions.jpg"]];
    [imageWithText4.myLabel setText:@"Attractions"];
    [imageWithText4.myLabel setBackgroundColor:mainColor];
    [imageWithText4.myText setBackgroundColor:darkColor];
    [imageWithText4.myText setText:@"If you want to have fun, Coral Island Resort is the place to go. Here we have all kinds of attractions. Your family will have a great time here"];
    
    NSArray *nib5 = [[NSBundle mainBundle] loadNibNamed:@"ImageWithText" owner:self options:nil];
    ImageWithTextView *imageWithText5 = [nib5 objectAtIndex:0];
    imageWithText5.frame = CGRectMake(4*self.irMainScroll.bounds.size.width, 0, self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height);
    [imageWithText5.myImage setImage:[UIImage imageNamed:@"Entertainment.jpg"]];
    [imageWithText5.myLabel setText:@"Entertainment"];
    [imageWithText5.myLabel setBackgroundColor:mainColor];
    [imageWithText5.myText setBackgroundColor:darkColor];
    [imageWithText5.myText setText:@"Enjoy all the entertainments in resort. There must be a show for your taste."];
    
    [self.irMainScroll addSubview:imageWithText1];
    
    NSLog(@"starting point %lf %lf", imageWithText1.myLabel.frame.origin.x, imageWithText1.myLabel.frame.origin.y);
    [self.irMainScroll addSubview:imageWithText2];
    [self.irMainScroll addSubview:imageWithText3];
    [self.irMainScroll addSubview:imageWithText4];
    [self.irMainScroll addSubview:imageWithText5];
    
    [self.irMainScroll setContentSize:CGSizeMake(5*self.irMainScroll.bounds.size.width, self.irMainScroll.bounds.size.height)];
    
    
   // NSLog(@"xixi %lf %lf", self.irMainScroll.frame.size.width, self.irMainScroll.frame.size.height);
    [self.irTopView setBackgroundColor:mainColor];
    [self.irTopViewLabel setText:@"CIR Home Page"];
    
    
    
}

-(void)changed{
    NSLog(@"changed!");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //[self performSegueWithIdentifier:ReserveHotel sender:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}

- (void)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
    

}

@end
