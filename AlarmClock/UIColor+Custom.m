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