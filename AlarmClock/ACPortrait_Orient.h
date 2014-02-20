//
//  ACTimeObject.h
//  AlarmClock
//
//  Created by Kyle Frost on 1/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACViewController;

@interface ACPortrait_Orient : NSObject

@property (nonatomic, assign) ACViewController *mainView;

+(void)updateTimeLabel:(ACViewController *)mainView;

+(void)hideAllTheLandscapeThings:(ACViewController *)mainView;

+(void)addAllThePortraitSubviews:(ACViewController *)mainView;

+(void)updateAllTheThings;

@end
