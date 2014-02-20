//
//  ACLandscape_Orient.h
//  AlarmClock
//
//  Created by Kyle Frost on 2/19/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACViewController;

@interface ACLandscape_Orient : NSObject

@property (nonatomic, assign) ACViewController *mainView;

+(void)updateTimeLabel:(ACViewController *)mainView;

+(void)hideAllThePortraitThings:(ACViewController *)mainView;

+(void)addAllTheLandscapeSubviews:(ACViewController *)mainView;


@end
