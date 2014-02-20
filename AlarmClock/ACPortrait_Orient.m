//
//  ACTimeObject.m
//  AlarmClock
//
//  Created by Kyle Frost on 1/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACPortrait_Orient.h"
#import "ACViewController.h"

#define TIME_SIZE 60
#define DAY_DAYMONTH_ALARM_SIZE 40
#define ON_OFF_SIZE 25
#define AM_PM_SIZE 20
#define SLASH_SIZE 30

@implementation ACPortrait_Orient

+(void)updateAllTheThings {
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(updateTimeLabel:)
                                   userInfo:nil
                                    repeats:YES];
}

+(void)hideAllTheLandscapeThings:(ACViewController *)mainView {
    
    // Set all the Landscape Labels to Hidden
    
    [mainView.timeLabelLandscape setHidden:YES];
    [mainView.dayLabelLandscape setHidden:YES];
    [mainView.dayMonthLabelLandscape setHidden:YES];
    [mainView.alarmLabelLandscape setHidden:YES];
    [mainView.onLabelLandscape setHidden:YES];
    [mainView.offLabelLandscape setHidden:YES];
    [mainView.amLabelLandscape setHidden:YES];
    [mainView.pmLabelLandscape setHidden:YES];
    [mainView.slashLabelLandscape setHidden:YES];
    
}

+(void)updateTimeLabel:(ACViewController *)mainView {
    
    mainView.timeLabelPortrait = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 80.0f)];
    mainView.timeLabelPortrait.text = @"00:00:00";
    mainView.timeLabelPortrait.textColor = [UIColor whiteColor];
    
    
    // Set timeLabel to show time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    mainView.timeLabelPortrait.text = [dateFormat stringFromDate:[NSDate date]];
    
    // Set label attributes
    mainView.timeLabelPortrait.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE];
    
    // Update timeLabel to show every one second
    // [self performSelector:@selector(updateTimeLabel:) withObject:self afterDelay:1.0];
    
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        mainView.timeLabelPortrait.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        mainView.timeLabelPortrait.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        mainView.timeLabelPortrait.textColor = [UIColor whiteColor];
    }
}


+(void)addAllThePortraitSubviews:(ACViewController *)mainView {
    
    // Add all the Portrait Labels as Subviews of mainView
    
    [mainView.view addSubview:mainView.timeLabelPortrait];
    [mainView.view addSubview:mainView.dayLabelPortrait];
    [mainView.view addSubview:mainView.dayMonthLabelPortrait];
    [mainView.view addSubview:mainView.alarmLabelPortrait];
    [mainView.view addSubview:mainView.onLabelPortrait];
    [mainView.view addSubview:mainView.offLabelPortrait];
    [mainView.view addSubview:mainView.amLabelPortrait];
    [mainView.view addSubview:mainView.slashLabelPortrait];
    
}

@end
