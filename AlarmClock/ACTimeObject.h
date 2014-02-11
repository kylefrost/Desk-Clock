//
//  ACTimeObject.h
//  AlarmClock
//
//  Created by Kyle Frost on 1/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACViewController;

@interface ACTimeObject : NSObject

@property (nonatomic, assign) ACViewController *mainView;

+(void)updateTimeObject:(ACViewController *)mainView;


@end
