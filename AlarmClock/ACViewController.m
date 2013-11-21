//
//  ACViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACViewController.h"
#import "ACInfoViewController.h"
#import "MKiCloudSync.h"
#import "ACTutorialViewController.h"
#import <UIKit/UIScreen.h>

#define TIME_SIZE 125
#define DAY_DAYMONTH_ALARM_SIZE 40
#define ON_OFF_SIZE 25
#define AM_PM_SIZE 20
#define SLASH_SIZE 30
#define BRIGHT_BUTTON_SIZE 12


@interface ACViewController ()

@end

@implementation ACViewController


-(void)loadTutorial {
    
    NSUserDefaults *tutorialDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![tutorialDefaults boolForKey:@"firstLoad"]) {
        [self showTutorial];
        [tutorialDefaults setBool:YES forKey:@"firstLoad"];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateTime];
    [self updateDay];
    [self updateMonthDay];
    [self updateAlarm];
    // [self updateBrightness];
    [self updateAMPM];
    
    // If following is commented out, status bar will disappear when InfoViewController is opened
    
    /*
     // Find time in 24 hour format
     NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
     [timeFormat setDateFormat:@"HH"];
     NSString *time = [timeFormat stringFromDate:[NSDate date]];
     // NSLNSLog(@"timeVal: %@", time);
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
     */
    
    // Update timeLabel to show every one second
    // [self performSelector:@selector(viewDidLoad) withObject:self afterDelay:1.0];
    
    // First Open
    // [self isFirstOpen];
    
    [self performSelector:@selector(loadTutorial) withObject:nil afterDelay:0.0];
    
    // iCloud syncing
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAlarm)
                                                 name:kMKiCloudSyncNotification
                                               object:nil];
    
    [MKiCloudSync start];
    [MKiCloudSync initialize];
    // [self loadTutorial];
}

-(void)isFirstOpen {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    // [defaults setBool:NO forKey:@"notFirstRun"];
    if (![defaults boolForKey:@"notFirstRun"]) {
        [self showTutorial];
        [defaults setBool:YES forKey:@"notFirstRun"];
        [defaults synchronize];
    }
    else {
        nil;
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
    _timeLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE];
    
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
    else if (timeVal <= 19 && timeVal >= 8) {
        _timeLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _timeLabel.textColor = [UIColor whiteColor];
    }
    
    // Set night or day mode colors for background
    if (timeVal <= 7) {
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    else if (timeVal >= 20) {
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
    }
}


-(void)updateDay {
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    // NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Get day of week.
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    // NSInteger day = [weekdayComponents day];
    NSInteger weekday = [weekdayComponents weekday];
    
    // NSLog of day
    // NSLog(@"NSInteger 'day' = %ld\nNSInteger 'weekday' = %ld", (long)day, (long)weekday);
    
    // Attributes of dayLabel text
    _dayLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAY_DAYMONTH_ALARM_SIZE];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        _dayLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
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
    
    // Update timeLabel to show every one second
    [self performSelector:@selector(updateDay) withObject:self afterDelay:1.0];
}

-(void)updateMonthDay {
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    // NSLog(@"timeVal: %@", time);
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
    _dayMonthLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAY_DAYMONTH_ALARM_SIZE];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        _dayMonthLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
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
    
    // Update timeLabel to show every one second
    [self performSelector:@selector(updateMonthDay) withObject:self afterDelay:1.0];
}


-(BOOL)readValue {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return [preferences boolForKey:@"switchOnOff"];
}

-(void)updateAlarm {
    
    // Set text attributes
    _onLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE];
    _offLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE];
    _alarmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAY_DAYMONTH_ALARM_SIZE];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    // NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    // Get UISwitch state
    NSUserDefaults* alarmPreference = [NSUserDefaults standardUserDefaults];
    BOOL alarmState = [alarmPreference boolForKey:@"switchOnOff"];
    
    // Set alarm state
    if (alarmState == 1) {
        if (timeVal <= 7) {
            _onLabel.textColor = [UIColor whiteColor];
            _offLabel.textColor = [UIColor darkGrayColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
        else if (timeVal <= 19 && timeVal >= 8) {
            _onLabel.textColor = [UIColor blackColor];
            _offLabel.textColor = [UIColor lightGrayColor];
            _alarmLabel.textColor = [UIColor blackColor];
        }
        else if (timeVal >= 20) {
            _onLabel.textColor = [UIColor whiteColor];
            _offLabel.textColor = [UIColor darkGrayColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
    }
    else if (alarmState == 0) {
        if (timeVal <= 7) {
            _onLabel.textColor = [UIColor darkGrayColor];
            _offLabel.textColor = [UIColor whiteColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
        else if (timeVal <= 19 && timeVal >= 8) {
            _onLabel.textColor = [UIColor lightGrayColor];
            _offLabel.textColor = [UIColor blackColor];
            _alarmLabel.textColor = [UIColor blackColor];
        }
        else if (timeVal >= 20) {
            _onLabel.textColor = [UIColor darkGrayColor];
            _offLabel.textColor = [UIColor whiteColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
    }
    
    // Button Size
    _brightnessButton.titleLabel.font = [UIFont systemFontOfSize:BRIGHT_BUTTON_SIZE];
    
    // Update timeLabel to show every one second
    [self performSelector:@selector(updateAlarm) withObject:self afterDelay:1.0];
}

-(IBAction)updateBrightness {
    
    // Find brightness
    UIScreen *mainScreen = [UIScreen mainScreen];
    // mainScreen.brightness = 0.5;
    
    // If button is pressed, night mode turned on, and if again, day mode turned on
    if (mainScreen.brightness > 0.1) {
        [_brightnessButton setTitle:@"View Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.0];
        // UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Night Mode Enabled" message: @"Night Mode has been enabled, and brightness has been turned down. Press View Mode to turn brightness back up." delegate: nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // [alert show];
    }
    else if (mainScreen.brightness <= 0.1) {
        
        [_brightnessButton setTitle:@"Night Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.5];
    }
    
}


-(void)updateAMPM {
    
    // Set text attributes
    _amLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE];
    _pmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE];
    _slashLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:SLASH_SIZE];
    
    // Set text
    _amLabel.text = @"AM";
    _pmLabel.text = @"PM";
    _slashLabel.text = @"/";
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    // NSLog(@"timeVal: %@", time);
    int timeVal = [time intValue];
    
    
    // Set if statements for showing AM and PM
    if (timeVal < 12) {
        if (timeVal <= 7) {
            _amLabel.textColor = [UIColor whiteColor];
            _pmLabel.textColor = [UIColor darkGrayColor];
            _slashLabel.textColor = [UIColor whiteColor];
        }
        else if (timeVal <= 19 && timeVal >= 8) {
            _amLabel.textColor = [UIColor blackColor];
            _pmLabel.textColor = [UIColor lightGrayColor];
            _slashLabel.textColor = [UIColor blackColor];
        }
        else if (timeVal >= 20) {
            _amLabel.textColor = [UIColor whiteColor];
            _pmLabel.textColor = [UIColor darkGrayColor];
            _slashLabel.textColor = [UIColor whiteColor];
        }
    }
    else if (timeVal >= 12) {
        if (timeVal <= 7) {
            _amLabel.textColor = [UIColor darkGrayColor];
            _pmLabel.textColor = [UIColor whiteColor];
            _slashLabel.textColor = [UIColor whiteColor];
        }
        else if (timeVal <= 19 && timeVal >= 8) {
            _amLabel.textColor = [UIColor lightGrayColor];
            _pmLabel.textColor = [UIColor blackColor];
            _slashLabel.textColor = [UIColor blackColor];
        }
        else if (timeVal >= 20) {
            _amLabel.textColor = [UIColor darkGrayColor];
            _pmLabel.textColor = [UIColor whiteColor];
            _slashLabel.textColor = [UIColor whiteColor];
        }
    }
    
    
    // Update timeLabel to show every one second
    [self performSelector:@selector(updateAMPM) withObject:self afterDelay:1.0];
}

-(void)showTutorial {
    UIViewController *view = [[ACTutorialViewController alloc] initWithNibName:@"ACTutorialViewController" bundle:nil];
    view.modalPresentationStyle = UIModalPresentationCurrentContext;
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:NULL];
    
}

@end
