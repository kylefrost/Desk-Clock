//
//  UIColor+Custom.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/4/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

+ (instancetype)customGoldColor;
+ (instancetype)customBlackColor;
+ (instancetype)customWhiteColor;
+ (instancetype)customDarkRedColor;
+ (instancetype)customLightGrayColor;
+ (instancetype)customDarkGrayColor;

// Warm Theme
+ (instancetype)customWarmTintColor;

+ (instancetype)customWarmDayTextColor;
+ (instancetype)customWarmDayOffColor;
+ (instancetype)customWarmDayBackgroundColor;

+ (instancetype)customWarmNightTextColor;
+ (instancetype)customWarmNightOffColor;
+ (instancetype)customWarmNightBackgroundColor;

// Cool Theme
+ (instancetype)customCoolTintColor;

+ (instancetype)customCoolDayTextColor;
+ (instancetype)customCoolDayOffColor;
+ (instancetype)customCoolDayBackgroundColor;

+ (instancetype)customCoolNightTextColor;
+ (instancetype)customCoolNightOffColor;
+ (instancetype)customCoolNightBackgroundColor;

// Spring Theme
+ (instancetype)customSpringTintColor;

+ (instancetype)customSpringDayTextColor;
+ (instancetype)customSpringDayOffColor;
+ (instancetype)customSpringDayBackgroundColor;

+ (instancetype)customSpringNightTextColor;
+ (instancetype)customSpringNightOffColor;
+ (instancetype)customSpringNightBackgroundColor;

// Monochrome Theme
+ (instancetype)customMonoTintColor;

+ (instancetype)customMonoDayTextColor;
+ (instancetype)customMonoDayOffColor;
+ (instancetype)customMonoDayBackgroundColor;

+ (instancetype)customMonoNightTextColor;
+ (instancetype)customMonoNightOffColor;
+ (instancetype)customMonoNightBackgroundColor;

@end