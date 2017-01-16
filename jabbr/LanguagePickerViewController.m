//
//  LanguagePickerViewController.m
//  jabbr
//
//  Created by Rachel McGreevy on 15/01/2017.
//  Copyright © 2017 Rachel McGreevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguagePickerViewController.h"

@interface LangaugePickerViewController ()

@property NSArray *languagesList;
@property (strong, nonatomic) UIPickerView *languagePicker;
@property (strong, nonatomic) NSString *languageType;

@end

@implementation LangaugePickerViewController

- (void) initWithLanguageType:(NSString *)type {
    _languageType = type;
}


-(void) loadView
{
    CGRect mainViewBounds = [[UIScreen mainScreen] bounds];
    _languagePicker = [[UIPickerView alloc] initWithFrame:mainViewBounds];
    _languagePicker.backgroundColor = [UIColor colorWithWhite:1.f alpha:1.f];
    _languagesList = [NSArray arrayWithObjects:@"English", @"Italian", @"French", @"Spanish", @"German", nil];
    _languagePicker.translatesAutoresizingMaskIntoConstraints = NO;
    _languagePicker.delegate = self;
    _languagePicker.dataSource = self;

    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,mainViewBounds.size.width,60)];
    [toolBar setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    toolBar.translucent = YES;
    UIBarButtonItem *toolBarCancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closePickerView:)];
    UIBarButtonItem *toolBarDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(closePickerView:)];
    UIBarButtonItem *toolBarSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:toolBarCancelButton, toolBarSpaceButton, toolBarDoneButton, nil] animated:YES];
    
    UIView *pickerParentView = [[UIView alloc] initWithFrame:mainViewBounds];
    [pickerParentView addSubview:_languagePicker];
    [pickerParentView addSubview:toolBar];
    self.view = pickerParentView;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _languagesList.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *languageString = _languagesList[row];  //can also use array[row] to get string
    NSDictionary *attributeDict;
    if (row == [pickerView selectedRowInComponent:component]){
        attributeDict = @{NSForegroundColorAttributeName : [UIColor colorWithRed:14.0/255 green:122.0/255 blue:254.0/255 alpha:1.0]};
    } else {
        attributeDict = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    }
    return [[NSAttributedString alloc] initWithString:languageString attributes:attributeDict];
}

-(void)closePickerView:(UIBarButtonItem *)sender {
    if([sender.title isEqual: @"Done"]){
        NSInteger row = [_languagePicker selectedRowInComponent:0];
        [self.delegate didCloseVC:_languagesList[row] withLanguageType:_languageType];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
