//
//  CreateProfileController.m
//  jabbr
//
//  Created by Rachel McGreevy on 29/10/2016.
//  Copyright © 2016 Rachel McGreevy. All rights reserved.
//
#import "CreateProfileController.h"

@interface CreateProfileController ()

@property (strong, atomic) UITextField *email;
@property (strong, atomic) UITextField *password;

@end

@implementation CreateProfileController

-(void) loadView{
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    view.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.view = view;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, screenWidth, screenHeight-statusBarHeight)];
    [self.view addSubview:mainView];
    
    UIImageView *title = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
    title.contentMode = UIViewContentModeScaleAspectFit;
    [mainView addSubview:title];
    title.image = [UIImage imageNamed:@"Graphics/jabbr.png"];
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight/3, screenWidth,screenHeight/3)];
    [mainView addSubview:detailsView];
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
