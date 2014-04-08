//
//  UIColor+Custom.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/4/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (instancetype)customGoldColor {
	return [[self class] customColorWithRed:0.906 green:0.776 blue:0.592 alpha:1.0];
}

+ (instancetype)customBlackColor {
	return [[self class] customColorWithRed:0.000 green:0.000 blue:0.000 alpha:1.0];
}

+ (instancetype)customWhiteColor {
	return [[self class] customColorWithRed:1.000 green:1.000 blue:1.000 alpha:1.0];
}

+ (instancetype)customDarkRedColor {
	return [[self class] customColorWithRed:178/255.0f green:28/255.0f blue:38/255.0f alpha:1.0];
}

+ (instancetype)customLightGrayColor {
    return [UIColor lightGrayColor];
}

+ (instancetype)customDarkGrayColor {
    return [UIColor darkGrayColor];
}

// Warm Theme
+ (instancetype)customWarmTintColor {
    return [[self class] customColorWithRed:188/255.0f green:44/255.0f blue:7/255.0f alpha:1.0f];
}
+ (instancetype)customWarmDayTextColor {
    return [[self class] customColorWithRed:252/255.0f green:105/255.0f blue:0/255.0f alpha:1.0f];
}
+ (instancetype)customWarmDayOffColor {
    return [[self class] customColorWithRed:248/255.0f green:139/255.0f blue:66/255.0f alpha:1.0f];
}
+ (instancetype)customWarmDayBackgroundColor {
    return [[self class] customColorWithRed:253/255.0f green:168/255.0f blue:68/255.0f alpha:1.0f];
}
+ (instancetype)customWarmNightTextColor {
    return [[self class] customColorWithRed:143/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}
+ (instancetype)customWarmNightOffColor {
    return [[self class] customColorWithRed:87/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}
+ (instancetype)customWarmNightBackgroundColor {
    return [[self class] customColorWithRed:69/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}

// Cool Theme
+ (instancetype)customCoolTintColor {
    return [[self class] customColorWithRed:0/255.0f green:212/255.0f blue:250/255.0f alpha:1.0f];
}
+ (instancetype)customCoolDayTextColor {
    return [[self class] customColorWithRed:53/255.0f green:134/255.0f blue:234/255.0f alpha:1.0f];
}
+ (instancetype)customCoolDayOffColor {
    return [[self class] customColorWithRed:135/255.0f green:143/255.0f blue:191/255.0f alpha:1.0f];
}
+ (instancetype)customCoolDayBackgroundColor {
    return [[self class] customColorWithRed:1.000 green:1.000 blue:1.000 alpha:1.0];
}
+ (instancetype)customCoolNightTextColor {
    return [[self class] customColorWithRed:53/255.0f green:134/255.0f blue:234/255.0f alpha:1.0f];
}
+ (instancetype)customCoolNightOffColor {
    return [[self class] customColorWithRed:32/255.0f green:43/255.0f blue:109/255.0f alpha:1.0f];
}
+ (instancetype)customCoolNightBackgroundColor {
    return [[self class] customColorWithRed:25/255.0f green:0/255.0f blue:94/255.0f alpha:1.0f];
}

// Spring Theme
+ (instancetype)customSpringTintColor {
    return [[self class] customColorWithRed:249/255.0f green:122/255.0f blue:164/255.0f alpha:1.0f];
}
+ (instancetype)customSpringDayTextColor {
    return [[self class] customColorWithRed:44/255.0f green:222/255.0f blue:177/255.0f alpha:1.0f];
}
+ (instancetype)customSpringDayOffColor {
    return [[self class] customColorWithRed:241/255.0f green:240/255.0f blue:181/255.0f alpha:1.0f];
}
+ (instancetype)customSpringDayBackgroundColor {
    return [[self class] customColorWithRed:249/255.0f green:122/255.0f blue:164/255.0f alpha:1.0f];
}
+ (instancetype)customSpringNightTextColor {
    return [[self class] customColorWithRed:108/255.0f green:204/255.0f blue:249/255.0f alpha:1.0f];
}
+ (instancetype)customSpringNightOffColor {
    return [[self class] customColorWithRed:51/255.0f green:88/255.0f blue:83/255.0f alpha:1.0f];
}
+ (instancetype)customSpringNightBackgroundColor {
    return [[self class] customColorWithRed:27/255.0f green:109/255.0f blue:102/255.0f alpha:1.0f];
}

// Monochrome Theme
+ (instancetype)customMonoTintColor {
    return [[self class] customColorWithRed:155/255.0f green:155/255.0f blue:155/255.0f alpha:1.0f];
}
+ (instancetype)customMonoDayTextColor {
    return [[self class] customColorWithRed:71/255.0f green:71/255.0f blue:71/255.0f alpha:1.0f];
}
+ (instancetype)customMonoDayOffColor {
    return [[self class] customColorWithRed:207/255.0f green:207/255.0f blue:207/255.0f alpha:1.0f];
}
+ (instancetype)customMonoDayBackgroundColor {
    return [[self class] customColorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0f];
}
+ (instancetype)customMonoNightTextColor {
    return [[self class] customColorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1.0f];
}
+ (instancetype)customMonoNightOffColor {
    return [[self class] customColorWithRed:77/255.0f green:77/255.0f blue:77/255.0f alpha:1.0f];
}
+ (instancetype)customMonoNightBackgroundColor {
    return [[self class] customColorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1.0f];
}


// Custom Color Methods
+ (instancetype)customColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	static NSCache *cache = nil;
    
	if(!cache) {
		cache = [[NSCache alloc] init];
        
		[cache setName:@"UIColor+Custom"];
	}
    
	NSString *cacheKey = [[self class] cacheKeyWithRed:red green:green blue:blue alpha:alpha];
    
	UIColor *color = [cache objectForKey:cacheKey];
    
	if(!color) {
		color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        
		[cache setObject:color forKey:cacheKey];
	}
    
	return color;
}

+ (NSString *)cacheKeyWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [NSString stringWithFormat:@"%.2f%.2f%.2f%.2f", red, green, blue, alpha];
}

@end