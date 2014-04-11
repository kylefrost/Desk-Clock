//
//  ACAlarmObject~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACAlarmObject_ipad : NSObject <NSCoding>

@property(nonatomic,strong) NSString * label;
@property(nonatomic,strong) NSDate * timeToSetOff;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic,assign) int notificationID;

@end
