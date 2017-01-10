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


@end

@implementation ViewController

-(void) loadView{
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    view.backgroundColor = [UIColor colorWithRed:176/255.0f green:84/255.0f blue:229/255.0f alpha:1.0f];
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
    
    UIImageView *emailLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    emailLabel.contentMode = UIViewContentModeScaleAspectFit;
    emailLabel.image = [UIImage imageNamed:@"Graphics/emailIcon.png"];
    _email = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, screenWidth/2, 20)];
    _email.textColor = [UIColor colorWithWhite:255/225.0f alpha:1.f];
    _email.backgroundColor=[UIColor clearColor];
    _email.leftViewMode = UITextFieldViewModeAlways;
    _email.leftView = emailLabel;
    _email.placeholder = @"example@me.com";
    [detailsView addSubview:_email];
    
    
    UIImageView *passwordLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    passwordLabel.contentMode = UIViewContentModeScaleAspectFit;
    passwordLabel.image = [UIImage imageNamed:@"Graphics/passwordIcon.png"];
    _password = [[UITextField alloc] initWithFrame:CGRectMake(40, 40, screenWidth/2, 20)];
    _password.textColor = [UIColor colorWithWhite:255/225.0f alpha:1.f];
    _password.backgroundColor=[UIColor clearColor];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = passwordLabel;
    _password.placeholder = @"password123";
    _password.secureTextEntry = YES;
    [detailsView addSubview:_password];
    
    
    UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(40, 80, 50, 20)];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [detailsView addSubview:login];
    
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

- (void)loginButtonClicked:(UIButton*)sender {
    
    NSLog(@"you clicked the login button");
    NSString *userEmail = _email.text;
    NSString *userPassword = _password.text;
    NSLog(@"user entered email: %@", userEmail);
    NSLog(@"user entered password: %@", userPassword);
    
    //later add in condition to execute only if new profile being created.
    CreateProfileController *controller = [[CreateProfileController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
