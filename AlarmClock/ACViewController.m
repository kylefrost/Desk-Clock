//
//  ACViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACViewController.h"
#import <UIKit/UIScreen.h>

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateTime];
    [self updateDay];
    [self updateMonthDay];
    [self updateAlarm];
    [self updateBrightness];
    [self updateAMPM];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
    }
    else if (timeVal <= 19 && timeVal >=8) {
        [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    else if (timeVal >= 20) {
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTime {
    
    // Set timeLabel to show time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    _timeLabel.text = [dateFormat stringFromDate:[NSDate date]];
    
    // Set label attributes
    _timeLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:125];
    
    // Update timeLabel to show every one second
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        _timeLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >=8) {
        _timeLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _timeLabel.textColor = [UIColor whiteColor];
    }
}


-(void)updateDay {
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Get day of week.
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger weekday = [weekdayComponents weekday];
    
    // NSLog of day
    NSLog(@"NSInteger 'day' = %ld\nNSInteger 'weekday' = %ld", (long)day, (long)weekday);

    // Attributes of dayLabel text
    _dayLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:40];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        _dayLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >=8) {
        _dayLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _dayLabel.textColor = [UIColor whiteColor];
    }
    
    // Set weekday label based on weekday value
    if (weekday == 1) {
        _dayLabel.text = @"Sunday";
    }
    else if (weekday == 2) {
        _dayLabel.text = @"Monday";
    }
    else if (weekday == 3) {
        _dayLabel.text = @"Tuesday";
    }
    else if (weekday == 4) {
        _dayLabel.text = @"Wednesday";
    }
    else if (weekday == 5) {
        _dayLabel.text = @"Thursday";
    }
    else if (weekday == 6) {
        _dayLabel.text = @"Friday";
    }
    else if (weekday == 7) {
        _dayLabel.text = @"Saturday";
    }
}

-(void)updateMonthDay {
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Get day of week.
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger month = [weekdayComponents month];
    
    // Set day of week label attributes
    _dayMonthLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:40];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        _dayMonthLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >=8) {
        _dayMonthLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _dayMonthLabel.textColor = [UIColor whiteColor];
    }
    
    // Set monthName string
    if (month == 1) {
        monthName = @"January";
    }
    else if (month == 2) {
        monthName = @"February";
    }
    else if (month == 3) {
        monthName = @"March";
    }
    else if (month == 4) {
        monthName = @"April";
    }
    else if (month == 5) {
        monthName = @"May";
    }
    else if (month == 6) {
        monthName = @"June";
    }
    else if (month == 7) {
        monthName = @"July";
    }
    else if (month == 8) {
        monthName = @"August";
    }
    else if (month == 9) {
        monthName = @"September";
    }
    else if (month == 10) {
        monthName = @"October";
    }
    else if (month == 11) {
        monthName = @"November";
    }
    else if (month == 12) {
        monthName = @"December";
    }
    
    // Set text of Day of Month
    if (day == 1) {
        dayOfMonth = @"1st";
    }
    else if (day == 2) {
        dayOfMonth = @"2nd";
    }
    else if (day == 3) {
        dayOfMonth = @"3rd";
    }
    else if (day == 4) {
        dayOfMonth = @"4th";
    }
    else if (day == 5) {
        dayOfMonth = @"5th";
    }
    else if (day == 6) {
        dayOfMonth = @"6th";
    }
    else if (day == 7) {
        dayOfMonth = @"7th";
    }
    else if (day == 8) {
        dayOfMonth = @"8th";
    }
    else if (day == 9) {
        dayOfMonth = @"9th";
    }
    else if (day == 10) {
        dayOfMonth = @"10th";
    }
    else if (day == 11) {
        dayOfMonth = @"11th";
    }
    else if (day == 12) {
        dayOfMonth = @"12th";
    }
    else if (day == 13) {
        dayOfMonth = @"13th";
    }
    else if (day == 14) {
        dayOfMonth = @"14th";
    }
    else if (day == 15) {
        dayOfMonth = @"15th";
    }
    else if (day == 16) {
        dayOfMonth = @"16th";
    }
    else if (day == 17) {
        dayOfMonth = @"17th";
    }
    else if (day == 18) {
        dayOfMonth = @"18th";
    }
    else if (day == 19) {
        dayOfMonth = @"19th";
    }
    else if (day == 20) {
        dayOfMonth = @"20th";
    }
    else if (day == 21) {
        dayOfMonth = @"21st";
    }
    else if (day == 22) {
        dayOfMonth = @"22nd";
    }
    else if (day == 23) {
        dayOfMonth = @"23rd";
    }
    else if (day == 24) {
        dayOfMonth = @"24th";
    }
    else if (day == 25) {
        dayOfMonth = @"25th";
    }
    else if (day == 26) {
        dayOfMonth = @"26th";
    }
    else if (day == 27) {
        dayOfMonth = @"27th";
    }
    else if (day == 28) {
        dayOfMonth = @"28th";
    }
    else if (day == 29) {
        dayOfMonth = @"29th";
    }
    else if (day == 30) {
        dayOfMonth = @"30th";
    }
    else if (day == 31) {
        dayOfMonth = @"31st";
    }
    
    // Set month and day label as **Month** **Date**
    _dayMonthLabel.text = [NSString stringWithFormat:@"%@ %@", monthName, dayOfMonth];
}

-(void)updateAlarm {
    
    // Set text attributes
    _onLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:25];
    _offLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:25];
    _alarmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:40];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    if (timeVal <= 7) {
        _onLabel.textColor = [UIColor whiteColor];
        _offLabel.textColor = [UIColor whiteColor];
        _alarmLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >=8) {
        _onLabel.textColor = [UIColor blackColor];
        _offLabel.textColor = [UIColor blackColor];
        _alarmLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _onLabel.textColor = [UIColor whiteColor];
        _offLabel.textColor = [UIColor whiteColor];
        _alarmLabel.textColor = [UIColor whiteColor];
    }
}

-(IBAction)updateBrightness {
    
    // Find brightness
    UIScreen *mainScreen = [UIScreen mainScreen];
    // mainScreen.brightness = 0.5;
    
    // If button is pressed, night mode turned on, and if again, day mode turned on
    if (mainScreen.brightness > 0.1) {
        [_brightnessButton setTitle:@"Night Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.1];
    }
    else if (mainScreen.brightness <= 0.1) {
        [_brightnessButton setTitle:@"View Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.5];
    }
}

-(void)updateAMPM {
    
    // Set text attributes
    _amLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:17];
    _pmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:17];
    _slashLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:17];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Set if statements for showing AM and PM
    if (timeVal < 12) {
        if (timeVal <= 7) {
            _amLabel.textColor = [UIColor whiteColor];
            _pmLabel.textColor = [UIColor grayColor];
        }
        else if (timeVal <= 19 && timeVal >=8) {
            
        }
        else if (timeVal >= 20) {
            
        }
    }
    else {
        if (timeVal <= 7) {
            
        }
        else if (timeVal <= 19 && timeVal >=8) {
            
        }
        else if (timeVal >= 20) {
            
        }
    }
}


@end
