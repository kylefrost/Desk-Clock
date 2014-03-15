//
//  ACAlarmObject.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/14/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

// AlarmObject Equivalent

#import <Foundation/Foundation.h>

@interface ACAlarmObject : NSObject <NSCoding>

@property(nonatomic,strong) NSString * label;
@property(nonatomic,strong) NSDate * timeToSetOff;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic,assign) int notificationID;

@end
