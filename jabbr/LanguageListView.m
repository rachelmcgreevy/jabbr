//
//  LanguageListView.m
//  jabbr
//
//  Created by Rachel McGreevy on 17/01/2017.
//  Copyright © 2017 Rachel McGreevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "LanguageListView.h"

@interface LanguageListView ()

@property CGFloat rowHeight;
@property NSInteger numberOfRows;
@property NSInteger currentRow;

@end

@implementation LanguageListView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _rowHeight = 30.0;
        _numberOfRows = (NSInteger)(frame.size.height/_rowHeight);
    }
    return self;
}

- (void) updateListView:(NSArray *)languagesList {
    [self resetListView];
    for (int i = 0; i < languagesList.count; i++){
        [self addTag:languagesList[i]];
    }
}

- (void) resetListView {
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    _currentRow = 0;
}

- (void) addTag:(NSString *)langaugeName {
    UILabel *languageLabel = [[UILabel alloc] init];
    languageLabel.layer.cornerRadius = 5;
    languageLabel.clipsToBounds = YES;
    languageLabel.textColor = [UIColor whiteColor];
    languageLabel.backgroundColor = [UIColor blueColor];
    languageLabel.text = langaugeName;
    [languageLabel sizeToFit];
    languageLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.subviews.count == 0) {
        languageLabel.frame = CGRectMake(0,0,70, _rowHeight);
    } else {
        languageLabel.frame = CGRectMake(0, (_currentRow*_rowHeight), 70, _rowHeight);
        _currentRow++;
    }
    
    [self addSubview:languageLabel];
    
}

@end

