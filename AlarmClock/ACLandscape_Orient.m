//
//  ACLandscape_Orient.m
//  AlarmClock
//
//  Created by Kyle Frost on 2/19/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACLandscape_Orient.h"
#import "ACViewController.h"

#define TIME_SIZE 120
#define DAY_DAYMONTH_ALARM_SIZE 40
#define ON_OFF_SIZE 25
#define AM_PM_SIZE 20
#define SLASH_SIZE 30

@implementation ACLandscape_Orient

+(void)hideAllThePortraitThings:(ACViewController *)mainView {
    
    // Set all the Portrait Labels to hidden
    
    [mainView.timeLabelPortrait setHidden:YES];
    [mainView.dayLabelPortrait setHidden:YES];
    [mainView.dayMonthLabelPortrait setHidden:YES];
    [mainView.alarmLabelPortrait setHidden:YES];
    [mainView.onLabelPortrait setHidden:YES];
    [mainView.offLabelPortrait setHidden:YES];
    [mainView.amLabelPortrait setHidden:YES];
    [mainView.pmLabelPortrait setHidden:YES];
    [mainView.slashLabelPortrait setHidden:YES];
    
}

+(void)updateTimeLabel:(ACViewController *)mainView {
    
    mainView.timeLabelLandscape = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 300.0f, 80.0f)];
    mainView.timeLabelLandscape.text = @"00:00:00";
    mainView.timeLabelLandscape.textColor = [UIColor whiteColor];
    
    
     // Set timeLabel to show time
     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
     [dateFormat setDateFormat:@"hh:mm:ss"];
     mainView.timeLabelLandscape.text = [dateFormat stringFromDate:[NSDate date]];
     
    
    // Set label attributes
    mainView.timeLabelLandscape.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE];
    
    // Update timeLabel to show every one second
    [mainView performSelector:@selector(self) withObject:self afterDelay:1.0];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        mainView.timeLabelLandscape.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        mainView.timeLabelLandscape.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        mainView.timeLabelLandscape.textColor = [UIColor whiteColor];
    }
    
}

+(void)addAllTheLandscapeSubviews:(ACViewController *)mainView {
    
    // Add all the Landscape Labels as Subviews of mainView
    
    [mainView.view addSubview:mainView.timeLabelLandscape];
    [mainView.view addSubview:mainView.dayLabelLandscape];
    [mainView.view addSubview:mainView.dayMonthLabelLandscape];
    [mainView.view addSubview:mainView.alarmLabelLandscape];
    [mainView.view addSubview:mainView.onLabelLandscape];
    [mainView.view addSubview:mainView.offLabelLandscape];
    [mainView.view addSubview:mainView.amLabelLandscape];
    [mainView.view addSubview:mainView.slashLabelLandscape];
    
}

@end
