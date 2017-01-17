//
//  CreateProfileController.m
//  jabbr
//
//  Created by Rachel McGreevy on 29/10/2016.
//  Copyright © 2016 Rachel McGreevy. All rights reserved.
//
#import "CreateProfileController.h"
#import "LanguageListView.h"

@interface CreateProfileController ()

@property (strong, atomic) UIImageView *profilePhoto;
@property (strong, atomic) UITextField *name;
@property (strong, atomic) UITextField *age;
@property (strong, atomic) UITextField *gender;
@property (strong, atomic) UIView *detailsView;
@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property NSArray *pickerData;
@property (strong, nonatomic) NSMutableArray *fluentLanguagesList;
@property (strong, nonatomic) LanguageListView *fluentLanguageListView;
@property (strong, nonatomic) NSMutableArray *learningLanguagesList;
@property (strong, nonatomic) LanguageListView *learningLanguageListView;

@end

@implementation CreateProfileController

-(void) loadView{
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _screenWidth = screenRect.size.width;
    _screenHeight = screenRect.size.height;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight)];
    view.backgroundColor = [UIColor colorWithRed:84/255.0f green:144/255.0f blue:196/255.0f alpha:1.0f];
    self.view = view;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, _screenWidth, _screenHeight-statusBarHeight)];
    [self.view addSubview:mainView];
    
    [self createVCTitle:mainView];
    
    _detailsView = [[UIView alloc]initWithFrame:CGRectMake(0, _screenHeight/5, _screenWidth,_screenHeight/1.5)];
    [mainView addSubview:_detailsView];
    
    [self createVCProfileDetails];
    [self createVCLanguageDetails];
    
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

-(void) createVCTitle:(UIView *)mainView {
    UIImageView *title = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth, 150)];
    title.contentMode = UIViewContentModeScaleAspectFit;
    [mainView addSubview:title];
    title.image = [UIImage imageNamed:@"Graphics/jabbr.png"];
}

-(void) createVCProfileDetails {
    _profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _profilePhoto.tag = 1;
    _profilePhoto.image = [UIImage imageNamed:@"Graphics/jabbr.png"];
    _profilePhoto.center = CGPointMake(_screenWidth/2, 110);
    _profilePhoto.layer.cornerRadius = _profilePhoto.frame.size.width/2;
    _profilePhoto.layer.borderColor = [UIColor grayColor].CGColor;
    _profilePhoto.layer.masksToBounds = YES;
    _profilePhoto.clipsToBounds = YES;
    _profilePhoto.userInteractionEnabled = YES;
    [_detailsView addSubview:_profilePhoto];
    
    UITapGestureRecognizer *addPhoto =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoButtonClicked:)];
    [addPhoto setNumberOfTapsRequired:1];
    [_profilePhoto addGestureRecognizer:addPhoto];
    
    UIImageView *nameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,20)];
    nameIcon.contentMode = UIViewContentModeScaleAspectFit;
    nameIcon.image = [UIImage imageNamed:@"Graphics/emailIcon.png"];
    _name = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, _screenWidth/1.2, 20)];
    _name.tag = 1;
    _name.textColor = [UIColor colorWithWhite:255/225.0f alpha:1.f];
    _name.backgroundColor=[UIColor clearColor];
    _name.leftViewMode = UITextFieldViewModeAlways;
    _name.leftView = nameIcon;
    _name.placeholder = @"John Doe";
    [_detailsView addSubview:_name];
    _name.center = CGPointMake(_screenWidth/2, 220);
    
    UIPickerView *agePV = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,3*(_screenWidth/4), 130)];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(int i=1; i<=100; i++){
        [array addObject:[NSString stringWithFormat:@"%i",i]];
    }
    _pickerData = array;
    agePV.delegate = self;
    agePV.dataSource = self;
    agePV.showsSelectionIndicator = YES;
    agePV.tag = 1;
    [_detailsView addSubview:agePV];
    agePV.center = CGPointMake(_screenWidth/2, 280);
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    nextButton.tag = 1;
    [_detailsView addSubview:nextButton];
    nextButton.center = CGPointMake(_screenWidth/2, 390);
    
    [nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

}
-(void) createVCLanguageDetails {
    
    _learningLanguageListView = [[LanguageListView alloc] init];
    
    UILabel *fluentLanguagesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, _screenWidth/1.2, 20)];
    fluentLanguagesLabel.tag = 2;
    fluentLanguagesLabel.textColor = [UIColor whiteColor];
    fluentLanguagesLabel.backgroundColor=[UIColor clearColor];
    fluentLanguagesLabel.text = @"Languages I am Fluent in";
    fluentLanguagesLabel.hidden = YES;
    [_detailsView addSubview:fluentLanguagesLabel];
    
    UIButton *addFluentLanguagesButton = [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth-30, 50, 20, 20)];
    [addFluentLanguagesButton setTitle:@"Fluent" forState:UIControlStateNormal];
    [addFluentLanguagesButton setImage:[UIImage imageNamed:@"Graphics/plus.png"] forState:UIControlStateNormal];
    addFluentLanguagesButton.tag = 2;
    addFluentLanguagesButton.hidden = YES;
    [_detailsView addSubview:addFluentLanguagesButton];
    [addFluentLanguagesButton addTarget:self action:@selector(addLanguageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    _fluentLanguageListView = [[LanguageListView alloc] initWithFrame:CGRectMake(0, 100, _screenWidth, 100)];
    _fluentLanguageListView.tag = 2;
    _fluentLanguageListView.hidden = YES;
    [_detailsView addSubview:_fluentLanguageListView];
    
    
    UILabel *learningLanguagesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, _screenWidth/1.2, 20)];
    learningLanguagesLabel.tag = 2;
    learningLanguagesLabel.textColor = [UIColor whiteColor];
    learningLanguagesLabel.backgroundColor=[UIColor clearColor];
    learningLanguagesLabel.text = @"Languages I am Learning";
    learningLanguagesLabel.hidden = YES;
    [_detailsView addSubview:learningLanguagesLabel];
    
    UIButton *addLearningLanguagesButton = [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth-30, 200, 20, 20)];
    [addLearningLanguagesButton setTitle:@"Learning" forState:UIControlStateNormal];
    [addLearningLanguagesButton setImage:[UIImage imageNamed:@"Graphics/plus.png"] forState:UIControlStateNormal];
    addLearningLanguagesButton.tag = 2;
    addLearningLanguagesButton.hidden = YES;
    [_detailsView addSubview:addLearningLanguagesButton];
    [addLearningLanguagesButton addTarget:self action:@selector(addLanguageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _learningLanguageListView = [[LanguageListView alloc] initWithFrame:CGRectMake(0, 220, _screenWidth, 100)];
    _learningLanguageListView.tag = 2;
    _learningLanguageListView.hidden = YES;
    [_detailsView addSubview:_learningLanguageListView];
    
    _fluentLanguagesList = [[NSMutableArray alloc] init];
    _learningLanguagesList = [[NSMutableArray alloc] init];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.tag = 2;
    backButton.hidden = YES;
    [_detailsView addSubview:backButton];
    backButton.center = CGPointMake(_screenWidth/2 - 50, 490);
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [finishButton setTitle:@"Finish" forState:UIControlStateNormal];
    finishButton.tag = 2;
    finishButton.hidden = YES;
    [_detailsView addSubview:finishButton];
    finishButton.center = CGPointMake(_screenWidth/2 + 50, 490);
    
    [finishButton addTarget:self action:@selector(finishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) addPhotoButtonClicked:(UIButton*)sender {
    NSLog(@"User clicked to add a profile photo");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)nextButtonClicked:(UIButton *)sender {
    NSLog(@"User clicked the next button");
    for(UIView *view in _detailsView.subviews){
        if(view.tag == 1){
            view.hidden = YES;
        }
        if(view.tag == 2){
            view.hidden = NO;
        }
    }
}

- (void)backButtonClicked:(UIButton *)sender {
    NSLog(@"User clicked the next button");
    for(UIView *view in _detailsView.subviews){
        if(view.tag == 2){
            view.hidden = YES;
        }
        if(view.tag == 1){
            view.hidden = NO;
        }
    }
}

- (void) addLanguageButtonClicked:(UIButton*)sender {
    NSLog(@"%@", [NSString stringWithFormat:@"User clicked to add a language for %@", sender.titleLabel.text]);
    LangaugePickerViewController *languagePicker = [[LangaugePickerViewController alloc] init];
    [languagePicker initWithLanguageType:sender.titleLabel.text];
    languagePicker.delegate = self;
    [self presentViewController:languagePicker animated:YES completion:NULL];
}


- (void)finishButtonClicked:(UIButton *)sender {
    NSLog(@"User clicked the finish button");
    //
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _profilePhoto.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)didCloseVC:(NSString *)selectedLanguage withLanguageType:(NSString *)languageType{
    if ([languageType  isEqual: @"Fluent"]) {
        [_fluentLanguagesList addObject:selectedLanguage];
    } else {
        [_learningLanguagesList addObject:selectedLanguage];
    }
    [self updateLanguageTagViews:languageType];
    
}

- (void) updateLanguageTagViews:(NSString *)languageType {
    if ([languageType  isEqual: @"Fluent"]) {
        [_fluentLanguageListView updateListView:_fluentLanguagesList];
    } else {
      [_learningLanguageListView updateListView:_learningLanguagesList];
    }
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

@end
