//
//  ACIAPHelper.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/11/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACIAPHelper.h"

@implementation ACIAPHelper

+ (ACIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static ACIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.kylefrost.DeskClock.neontheme",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
