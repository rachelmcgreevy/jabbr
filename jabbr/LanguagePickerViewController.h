//
//  LanguagePickerViewController.h
//  jabbr
//
//  Created by Rachel McGreevy on 15/01/2017.
//  Copyright © 2017 Rachel McGreevy. All rights reserved.
//

@protocol LanguagePickerVCDelegate <NSObject>

- (void)didCloseVC:(NSString *)selectedLanguage withLanguageType:(NSString *)languageType;

@end

#import <UIKit/UIKit.h>
#import "CreateProfileController.h"

@interface LangaugePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<LanguagePickerVCDelegate>delegate;
- (void) initWithLanguageType:(NSString *)type;


@end
