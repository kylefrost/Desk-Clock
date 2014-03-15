//
//  ACAlarmObject.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/14/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

// AlarmObject Equivalent

#import "ACAlarmObject.h"

@implementation ACAlarmObject

@synthesize label;
@synthesize timeToSetOff;
@synthesize enabled;
@synthesize notificationID;

//This is important to for saving the alarm object in user defaults
-(void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.timeToSetOff forKey:@"timeToSetOff"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
    [encoder encodeInt:self.notificationID forKey:@"notificationID"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    self.label = [decoder decodeObjectForKey:@"label"];
    self.timeToSetOff = [decoder decodeObjectForKey:@"timeToSetOff"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    self.notificationID = [decoder decodeIntForKey:@"notificationID"];
    return self;
}

@end
