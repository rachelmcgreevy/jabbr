//
//  CreateProfileController.m
//  jabbr
//
//  Created by Rachel McGreevy on 29/10/2016.
//  Copyright © 2016 Rachel McGreevy. All rights reserved.
//
#import "CreateProfileController.h"

@interface CreateProfileController ()

@property (strong, atomic) UIImageView *profilePhoto;

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
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight/5, screenWidth,screenHeight/1.5)];
    [mainView addSubview:detailsView];
    
    _profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _profilePhoto.image = [UIImage imageNamed:@"Graphics/jabbr.png"];
    _profilePhoto.center = CGPointMake(screenWidth/2, 75);
    _profilePhoto.layer.cornerRadius = _profilePhoto.frame.size.width/2;
    _profilePhoto.layer.borderColor = [UIColor grayColor].CGColor;
    _profilePhoto.layer.masksToBounds = YES;
    _profilePhoto.clipsToBounds = YES;
    _profilePhoto.userInteractionEnabled = YES;

    
    UITapGestureRecognizer *addPhoto =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoButtonClicked:)];
    [addPhoto setNumberOfTapsRequired:1];
    
    [_profilePhoto addGestureRecognizer:addPhoto];
    [detailsView addSubview:_profilePhoto];
    
    
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
/*
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
*/

- (void)addPhotoButtonClicked:(UIButton*)sender {
    
    NSLog(@"made it to here");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _profilePhoto.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];

}

@end
