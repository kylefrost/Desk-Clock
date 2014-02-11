//
//  ACTimeObject.m
//  AlarmClock
//
//  Created by Kyle Frost on 1/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACTimeObject.h"
#import "ACViewController.h"

#define TIME_SIZE 60

@implementation ACTimeObject

+(void)updateTimeObject:(ACViewController *)mainView {
    
    mainView.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 80.0f)];
    mainView.timeLabel.text = @"00:00:00";
    mainView.timeLabel.textColor = [UIColor whiteColor];
    
    /*
    // Set timeLabel to show time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    mainView.timeLabel.text = [dateFormat stringFromDate:[NSDate date]];
    */
    
    // Set label attributes
    mainView.timeLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE];
    
    // Update timeLabel to show every one second
    [mainView performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        mainView.timeLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        mainView.timeLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        mainView.timeLabel.textColor = [UIColor whiteColor];
    }
    
}

@end
