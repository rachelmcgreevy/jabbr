//
//  ViewController.m
//  jabbr
//
//  Created by Rachel McGreevy on 10/01/2017.
//  Copyright © 2017 Rachel McGreevy. All rights reserved.
//

#import "ViewController.h"
#import "CreateProfileController.h"


@interface ViewController ()

@property (strong, atomic) UITextField *email;
@property (strong, atomic) UITextField *password;
@property CGFloat screenWidth;
@property CGFloat screenHeight;


@end

@implementation ViewController

-(void) loadView{
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _screenWidth = screenRect.size.width;
    _screenHeight = screenRect.size.height;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight)];
    view.backgroundColor = [UIColor colorWithRed:176/255.0f green:84/255.0f blue:229/255.0f alpha:1.0f];
    self.view = view;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, _screenWidth, _screenHeight-statusBarHeight)];
    [self.view addSubview:mainView];
    
    [self createVCTitle:mainView];
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(0, _screenHeight/3, _screenWidth,_screenHeight/3)];
    [mainView addSubview:detailsView];
    
    [self createVCLoginDetails:detailsView];
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

- (void)createVCTitle:(UIView *)mainView {
    
    UIImageView *title = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 3*(_screenWidth/4), 200)];
    title.contentMode = UIViewContentModeScaleAspectFit;
    title.image = [UIImage imageNamed:@"Graphics/jabbr.png"];
    [mainView addSubview:title];
    title.center = CGPointMake(_screenWidth/2, 100);
}

- (void)createVCLoginDetails:(UIView *)detailsView {
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,20)];
    emailIcon.contentMode = UIViewContentModeScaleAspectFit;
    emailIcon.image = [UIImage imageNamed:@"Graphics/emailIcon.png"];
    _email = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, _screenWidth/1.2, 20)];
    _email.textColor = [UIColor colorWithWhite:255/225.0f alpha:1.f];
    _email.backgroundColor=[UIColor clearColor];
    _email.leftViewMode = UITextFieldViewModeAlways;
    _email.leftView = emailIcon;
    _email.placeholder = @"example@me.com";
    [detailsView addSubview:_email];
    
    UIImageView *passwordLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,20)];
    passwordLabel.contentMode = UIViewContentModeScaleAspectFit;
    passwordLabel.image = [UIImage imageNamed:@"Graphics/passwordIcon.png"];
    _password = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, _screenWidth/1.2, 20)];
    _password.textColor = [UIColor colorWithWhite:255/225.0f alpha:1.f];
    _password.backgroundColor=[UIColor clearColor];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = passwordLabel;
    _password.placeholder = @"password123";
    _password.secureTextEntry = YES;
    [detailsView addSubview:_password];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [detailsView addSubview:loginButton];
    loginButton.center = CGPointMake(_screenWidth/2, 200);
    
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginButtonClicked:(UIButton*)sender {
    
    NSLog(@"User clicked the login button");
    NSString *userEmail = _email.text;
    NSString *userPassword = _password.text;
    NSLog(@"user entered email: %@", userEmail);
    NSLog(@"user entered password: %@", userPassword);
    //TODO: add in email / password verification
    //TODO: add in condition to execute only if new profile being created.
    CreateProfileController *controller = [[CreateProfileController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    //TODO: add in condition to execute adding 
}

@end
