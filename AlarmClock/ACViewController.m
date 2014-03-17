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
#import "Definitions.h"
#import "ACAppDelegate.h"
#import "ACAlarmObject.h"
#import "ACAlarmViewController.h"

#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIScreen.h>

@interface ACViewController ()

@end

@implementation ACViewController

@synthesize player;

// Load Tutorial if it is First Open
-(void)loadTutorial {
    
    NSUserDefaults *tutorialDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![tutorialDefaults boolForKey:@"firstLoad"]) {
        [self showTutorial];
        [tutorialDefaults setBool:YES forKey:@"firstLoad"];
    }
}

// Load Tutorial if it is First Open
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

// View Did Load
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Slide Status Bar out of view when this View loads
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    // Load tutorial if it is the first open
    [self isFirstOpen];
    [self loadTutorial];
    [self performSelector:@selector(loadTutorial) withObject:nil afterDelay:0.0];
    
    // iCloud syncing
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAlarmPortrait)
                                                 name:kMKiCloudSyncNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAlarmLandscape)
                                                 name:kMKiCloudSyncNotification
                                               object:nil];
    
    [MKiCloudSync start];
    [MKiCloudSync initialize];
    
    [self determineBuild];

    // Get Orientation at launch
    [self getOrientation];
    
    // Run Portrait/Landscape Independent Functions (found at bottom)
    [self updateClockLabelTime];
    [self updateDayLabelDate];
    [self updateDayMonthLabelDate];
    [self updateAlarmLabelStatus];
    [self updateAMPMLabelStatus];
    [self updateLabelColors];
    [self updateBackgroundColor];
    
}

// Set code to play alarm if the alarm is going off
-(void)viewDidAppear:(BOOL)animated {
    
    //This checks if the home view is shown because of an alarm firing
    if(self.alarmGoingOff) {
        
        UIAlertView *alarmAlert = [[UIAlertView alloc] initWithTitle:@"Your alarm sounding, bruh"
                                                             message:@"Press done to stop, press snooze to continue sleeping."
                                                            delegate:self
                                                   cancelButtonTitle:@"Done"
                                                   otherButtonTitles:nil, nil];
        [alarmAlert show];
        
        self.alarmGoingOff = NO;
    }
    
    else {
        
        nil;
    }
}

// Alart View when song comes on, stop music on exit
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
        ACAppDelegate * myAppDelegate = (ACAppDelegate*)[[UIApplication sharedApplication] delegate];
        [myAppDelegate.player stop];
        
    } else {
        
        // Well, nothing.
        
    }
}

// Run functions based on orientation
-(void)getOrientation {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // Portrait
    if(orientation == 0) {
        
        [self updateTimePortrait];
        [self updateDayPortrait];
        [self updateMonthDayPortrait];
        [self updateAlarmPortrait];
        [self updateAMPMPortrait];
        
    }
    // Portrait
    else if(orientation == UIInterfaceOrientationPortrait) {
        
        [self updateTimePortrait];
        [self updateDayPortrait];
        [self updateMonthDayPortrait];
        [self updateAlarmPortrait];
        [self updateAMPMPortrait];
        
    }
    // Portrait
    else if(orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        [self updateTimePortrait];
        [self updateDayPortrait];
        [self updateMonthDayPortrait];
        [self updateAlarmPortrait];
        [self updateAMPMPortrait];
        
    }
    // Landscape
    else if(orientation == UIInterfaceOrientationLandscapeLeft) {
        
        [self updateTimeLandscape];
        [self updateDayLandscape];
        [self updateMonthDayLandscape];
        [self updateAlarmLandscape];
        [self updateAMPMLandscape];
        
    }
    // Landscape
    else if(orientation == UIInterfaceOrientationLandscapeRight) {
        
        [self updateTimeLandscape];
        [self updateDayLandscape];
        [self updateMonthDayLandscape];
        [self updateAlarmLandscape];
        [self updateAMPMLandscape];
        
    }
    
    /* 
     Check every tenth second for orientation to decrease lag when
     change orientations. Tried running this afterDelay:0.0 but CPU
     usage was spiking to 98% - 100%. At afterDelay:0.1 it only peaks
     at around 1% - 2%.
     */
    
    [self performSelector:@selector(getOrientation) withObject:self afterDelay:0.1];
}

#pragma mark -
#pragma mark Portrait Functions

/******************* All Portrait Functions *******************/

// Update the timeLabel for Portrait view
-(void)updateTimePortrait {
    
    // NSLog(@"updateTimePortrait is called");
 
    // Set label attributes
    _timeLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE_PORTRAIT];
    [_timeLabel setFrame:TIME_LABEL_RECT_PORTRAIT];
    
}

// Update the dayLabel for Portrait view
-(void)updateDayPortrait {
    
    // NSLog(@"updateDayPortrait is called");

    // Set label attributes
    _dayLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAY_LABEL_SIZE_PORTRAIT];
    [_dayLabel setFrame:DAY_LABEL_RECT_PORTRAIT];

}

// Update the dayMonthLabel for Portrait view
-(void)updateMonthDayPortrait {
    
    // NSLog(@"updateMonthDayPortrait is called");
    
    // Set day of week label attributes
    _dayMonthLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAYMONTH_LABEL_SIZE_PORTRAIT];
    [_dayMonthLabel setFrame:DAYMONTH_LABEL_RECT_PORTRAIT];
    
}

// Update the alarmLabel for Portrait view
-(void)updateAlarmPortrait {
    
    // Set text attributes
    _onLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE_PORTRAIT];
    [_onLabel setFrame:ON_LABEL_RECT_PORTRAIT];
    _onLabel.text = @"ON";
    
    _offLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE_PORTRAIT];
    [_offLabel setFrame:OFF_LABEL_RECT_PORTRAIT];
    _offLabel.text = @"OFF";
    
    _alarmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ALARM_LABEL_SIZE_PORTRAIT];
    [_alarmLabel setFrame:ALARM_LABEL_RECT_PORTRAIT];
    _alarmLabel.text = @"Alarm";
    
}

// Update the amLabel and pmLabel and slashLabel for Portrait view
-(void)updateAMPMPortrait {
    
    // Set text attributes
    _amLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE_PORTRAIT];
    [_amLabel setFrame:AM_LABEL_RECT_PORTRAIT];
    _amLabel.text = @"AM";
    
    _pmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE_PORTRAIT];
    [_pmLabel setFrame:PM_LABEL_RECT_PORTRAIT];
    _pmLabel.text = @"PM";
    
    _slashLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:SLASH_SIZE_PORTRAIT];
    [_slashLabel setFrame:SLASH_LABEL_RECT_PORTRAIT];
    _slashLabel.text = @"/";
    
}

#pragma mark -
#pragma mark Landscape Functions

/******************* All Landscape Functions *******************/

// Update the timeLabel for Landscape view
-(void)updateTimeLandscape {
    
    // NSLog(@"updateTimeLandscape is called");
    
    // Set label attributes
    _timeLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TIME_SIZE_LANDSCAPE];
    [_timeLabel setFrame:TIME_LABEL_RECT_LANDSCAPE];
    
}

// Update the dayLabel for Landscape view
-(void)updateDayLandscape {
    
    // NSLog(@"updateDayLandscape is called");
    
    // Set label attributes
    _dayLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAY_LABEL_SIZE_LANDSCAPE];
    [_dayLabel setFrame:DAY_LABEL_RECT_LANDSCAPE];
}

// Update the dayMonthLabel for Landscape view
-(void)updateMonthDayLandscape {
    
    // NSLog(@"updateMonthDayLandscape is called");
    
    // Set day of week label attributes
    _dayMonthLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:DAYMONTH_LABEL_SIZE_LANDSCAPE];
    [_dayMonthLabel setFrame:DAYMONTH_LABEL_RECT_LANDSCAPE];
    
}

// Update the alarmLabel for Landscape view
-(void)updateAlarmLandscape {
    
     // Set text attributes
     _onLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE_LANDSCAPE];
    [_onLabel setFrame:ON_LABEL_RECT_LANDSCAPE];
    _onLabel.text = @"ON";
    
     _offLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ON_OFF_SIZE_LANDSCAPE];
    [_offLabel setFrame:OFF_LABEL_RECT_LANDSCAPE];
    _offLabel.text = @"OFF";
    
     _alarmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:ALARM_LABEL_SIZE_LANDSCAPE];
    [_alarmLabel setFrame:ALARM_LABEL_RECT_LANDSCAPE];
    _alarmLabel.text = @"Alarm";
     
}

// Update the amLabel and pmLabel and slashLabel for Landscape view
-(void)updateAMPMLandscape {
    
    // Set text attributes
    _amLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE_LANDSCAPE];
    [_amLabel setFrame:AM_LABEL_RECT_LANDSCAPE];
    _amLabel.text = @"AM";
    
    _pmLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:AM_PM_SIZE_LANDSCAPE];
    [_pmLabel setFrame:PM_LABEL_RECT_LANDSCAPE];
    _pmLabel.text = @"PM";
    
    _slashLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:SLASH_SIZE_LANDSCAPE];
    [_slashLabel setFrame:SLASH_LABEL_RECT_LANDSCAPE];
    _slashLabel.text = @"/";
    
}

#pragma mark -
#pragma mark Landscape/Portrait Independent Functions

/******************* Landscape/Portrait Independent *******************/

// Make timeLabel update with time
-(void)updateClockLabelTime {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    _timeLabel.text = [dateFormat stringFromDate:[NSDate date]];
    
    // Run every second to constantly update timeLabel with current time
    [self performSelector:@selector(updateClockLabelTime) withObject:self afterDelay:1.0];
    
}

// Update dayLabel with current weekday
-(void)updateDayLabelDate {
    
    // Get day of week.
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger weekday = [weekdayComponents weekday];
    
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
    
    // Run every second to constantly update dayLabel with current weekday
    [self performSelector:@selector(updateDayLabelDate) withObject:self afterDelay:1.0];
    
}

// Update dayMonthLabel with current month and day of month
-(void)updateDayMonthLabelDate {
    
    // Get month and day of the month
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger month = [weekdayComponents month];
    
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
    
    // Set dayMonth string
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
    
    // Set month and day label as "Month" "Day of Month" e.g. September 15th
    _dayMonthLabel.text = [NSString stringWithFormat:@"%@ %@", monthName, dayOfMonth];
    
    // Run every second to constantly update dayMonthLabel with current month and day of month
    [self performSelector:@selector(updateDayMonthLabelDate) withObject:self afterDelay:1.0];
    
}

// Make Alarm Label show appropriate status of alarm
-(void)updateAlarmLabelStatus {
    
    // Make array of local notifications to check
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    
    
    // NSLog(@"%@", eventArray);
    
    // NSLog(@"%lu", (unsigned long)[eventArray count]);
    
    // Find the time to determine Night/Day mode
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeInt = [time intValue];
    
    // Determine on/off lable status based on local notification array count
    if ([eventArray count] == 0) {
        if (timeInt <= 7) {
            _onLabel.textColor = [UIColor darkGrayColor];
            _offLabel.textColor = [UIColor whiteColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
        else if (timeInt <= 19 && timeInt >= 8) {
            _onLabel.textColor = [UIColor lightGrayColor];
            _offLabel.textColor = [UIColor blackColor];
            _alarmLabel.textColor = [UIColor blackColor];
        }
        else if (timeInt >= 20) {
            _onLabel.textColor = [UIColor darkGrayColor];
            _offLabel.textColor = [UIColor whiteColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
    }
    else if ([eventArray count] > 0) {
        if (timeInt <= 7) {
            _onLabel.textColor = [UIColor whiteColor];
            _offLabel.textColor = [UIColor darkGrayColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
        else if (timeInt <= 19 && timeInt >= 8) {
            _onLabel.textColor = [UIColor blackColor];
            _offLabel.textColor = [UIColor lightGrayColor];
            _alarmLabel.textColor = [UIColor blackColor];
        }
        else if (timeInt >= 20) {
            _onLabel.textColor = [UIColor whiteColor];
            _offLabel.textColor = [UIColor darkGrayColor];
            _alarmLabel.textColor = [UIColor whiteColor];
        }
    }
    
    // Continuously check status of change
    [self performSelector:@selector(updateAlarmLabelStatus) withObject:self afterDelay:1.0];
    
}

// Update AM and PM labels
-(void)updateAMPMLabelStatus {
    
    // Set text
    _amLabel.text = @"AM";
    _pmLabel.text = @"PM";
    _slashLabel.text = @"/";
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
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
    
    // Update every second to be accurate
    [self performSelector:@selector(updateAMPMLabelStatus) withObject:self afterDelay:1.0];
    
}

// Update Background Color for Day/Light Mode
-(void)updateBackgroundColor {
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
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
    
    // Update every second
    [self performSelector:@selector(updateBackgroundColor) withObject:self afterDelay:1.0];
    
}

// Update Label Colors for Day/Night Mode
-(void)updateLabelColors {
    
    // Button Size
    _brightnessButton.titleLabel.font = [UIFont systemFontOfSize:BRIGHT_BUTTON_SIZE];
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Set night mode or day mode colors for timeLabel
    if (timeVal <= 7) {
        _timeLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        _timeLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _timeLabel.textColor = [UIColor whiteColor];
    }
    
    // Set night mode or day mode colors for dayLabel
    if (timeVal <= 7) {
        _dayLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        _dayLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _dayLabel.textColor = [UIColor whiteColor];
    }
    
    // Set night mode or day mode colors for dayMonthLabel
    if (timeVal <= 7) {
        _dayMonthLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        _dayMonthLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        _dayMonthLabel.textColor = [UIColor whiteColor];
    }
    
    // Update every second
    [self performSelector:@selector(updateLabelColors) withObject:self afterDelay:1.0];
    
}

#pragma mark -
#pragma mark Miscellaneous Functions

/******************* Miscellaneous *******************/

// Shows tutorial if first open
-(void)showTutorial {
    
    UIViewController *view = [[ACTutorialViewController alloc] initWithNibName:@"ACTutorialViewController" bundle:nil];
    view.modalPresentationStyle = UIModalPresentationCurrentContext;
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:NULL];
    
    
    // UIView *view = [[UIView alloc] init];
    
    
}

// Did Receive Memory Warning
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Action for brightnessButton
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

// Read Switch
-(BOOL)readValue {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return [preferences boolForKey:@"switchOnOff"];
}

// Determine if Beta
-(void)determineBuild {
    
    // Determine if build is beta or not
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BetaSettings" ofType:@"plist"];
    NSDictionary* betaDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    BOOL buildBOOL = [[betaDictionary objectForKey:@"isBetaBuildRelease"] boolValue];
    
    // If beta, show button, if not, don't show button
    if (buildBOOL == 1) {
        [self.betaButton setEnabled:YES];
        [self.betaButton setAlpha:1.0];
        // [self.betaButton setUserInteractionEnabled:YES];
        NSLog(@"Build is a beta build.");
    }
    else if (buildBOOL == 0) {
        [self.betaButton setEnabled:NO];
        [self.betaButton setAlpha:0.0];
        // [self.betaButton setUserInteractionEnabled:NO];
        NSLog(@"Build is NOT a beta build.");
    }
}


@end
