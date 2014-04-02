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
#import "OWMWeatherAPI.h"

#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIScreen.h>
#import <CoreLocation/CoreLocation.h>

@interface ACViewController ()

@end

@implementation ACViewController {
    CLLocationManager *_locationManager;
    CLLocationManager *weatherLocationManager;
}

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

// Get current location
-(CLLocationCoordinate2D)getLocation {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
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
    [self checkNightMode];
    
    // Weather Information
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    weatherLocationManager = [[CLLocationManager alloc] init];
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        NSString *tempString = [NSString stringWithFormat:@"%.1f", [result[@"main"][@"temp"] floatValue]];
        NSLog(@"tempString is %@", tempString);
        
    }];
    [self getWeather];
}

// Set code to play alarm if the alarm is going off
-(void)viewDidAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
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

// Alart View when alarm comes on, stop alarm on exit
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
        [self updateWeatherPortrait];
        
    }
    // Portrait
    else if(orientation == UIInterfaceOrientationPortrait) {
        
        [self updateTimePortrait];
        [self updateDayPortrait];
        [self updateMonthDayPortrait];
        [self updateAlarmPortrait];
        [self updateAMPMPortrait];
        [self updateWeatherPortrait];
        
    }
    // Portrait
    else if(orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        [self updateTimePortrait];
        [self updateDayPortrait];
        [self updateMonthDayPortrait];
        [self updateAlarmPortrait];
        [self updateAMPMPortrait];
        [self updateWeatherPortrait];
        
    }
    // Landscape
    else if(orientation == UIInterfaceOrientationLandscapeLeft) {
        
        [self updateTimeLandscape];
        [self updateDayLandscape];
        [self updateMonthDayLandscape];
        [self updateAlarmLandscape];
        [self updateAMPMLandscape];
        [self updateWeatherLandscape];
        
    }
    // Landscape
    else if(orientation == UIInterfaceOrientationLandscapeRight) {
        
        [self updateTimeLandscape];
        [self updateDayLandscape];
        [self updateMonthDayLandscape];
        [self updateAlarmLandscape];
        [self updateAMPMLandscape];
        [self updateWeatherLandscape];
        
    }
    
    /* 
     Check every tenth second for orientation to decrease lag when
     change orientations. Tried running this afterDelay:0.0 but CPU
     usage was spiking to 98% - 100%. At afterDelay:0.1 it only peaks
     at around 1% - 2%.
     */
    
    [self performSelector:@selector(getOrientation) withObject:self afterDelay:0.05];
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

// Update the weather labels for Portrait view
-(void)updateWeatherPortrait {
    
    self.weatherTempLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TEMP_SIZE_PORTRAIT];
    self.weatherCondLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:COND_SIZE_PORTRAIT];
    self.weatherCondLabel.textAlignment = NSTextAlignmentLeft;
    
    self.weatherTempLabel.frame = TEMP_RECT_PORTRAIT;
    self.weatherCondLabel.frame = COND_RECT_PORTRAIT;
    self.refreshButton.frame = REFRESH_BUTTON_RECT_PORTRAIT;
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

// Update the weather labels for Portrait view
-(void)updateWeatherLandscape {
    
    self.weatherTempLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:TEMP_SIZE_LANDSCAPE];
    self.weatherCondLabel.font = [UIFont fontWithName:@"Digital-7 Mono" size:COND_SIZE_LANDSCAPE];
    self.weatherCondLabel.textAlignment = NSTextAlignmentRight;
    
    self.weatherTempLabel.frame = TEMP_RECT_LANDSCAPE;
    self.weatherCondLabel.frame = COND_RECT_LANDSCAPE;
    self.refreshButton.frame = REFRESH_BUTTON_RECT_LANDSCAPE;
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


#pragma mark -
#pragma mark Night Mode Methods

/******************* Night Mode Methods *******************/

// Check which Night Mode setting is enabled and run methods appropriately
-(void)checkNightMode {
	
	// Load Defaults to check Switches state from Night Mode Settings page
	NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
	
	BOOL enabledSwitchState = [nightViewPreferences boolForKey:@"enabledSwitch"];
	BOOL alwaysOnDaySwitchState = [nightViewPreferences boolForKey:@"alwaysDaySwitch"];
	BOOL alwaysOnNightSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
	BOOL customTimeSwitchState = [nightViewPreferences boolForKey:@"customTimeSwitch"];
	
	// Automatic Switching is Enabled
	if (enabledSwitchState == 1) {
		
		// Custom Time Switch is Enabled
		if (customTimeSwitchState == 1) {
			[self customIsOn];
		}
		
		// Custom Time Switch is Disabled
		else if (customTimeSwitchState == 0) {
			[self customIsOff];
		}
	}
	
	// Always Day Mode is Enabled
	if (alwaysOnDaySwitchState == 1) {
		[self dayMode];
		// NSLog(@"dayMode is being called from checkNightMode.");
	}
	
	// Always Night Mode is Enabled
	if (alwaysOnNightSwitchState == 1) {
		[self nightMode];
		// NSLog(@"nightMode is being called from checkNightMode.");
	}
	
	[self performSelector:@selector(checkNightMode) withObject:self afterDelay:1.0];
}

// Always Day Mode is Enabled
-(void)dayMode {
	
	// Alarm Label Status
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *eventArray = [app scheduledLocalNotifications];
	
	// If there are 0 local notifications
	if ([eventArray count] == 0) {
		self.onLabel.textColor = [UIColor lightGrayColor];
		self.offLabel.textColor = [UIColor blackColor];
		self.alarmLabel.textColor = [UIColor blackColor];
	}
	// If there are more than 0 local notifications
	else if ([eventArray count] > 0) {
		self.onLabel.textColor = [UIColor blackColor];
		self.offLabel.textColor = [UIColor lightGrayColor];
		self.alarmLabel.textColor = [UIColor blackColor];
	}
	
	// AM/PM Label Status
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// If it is AM
	if (timeVal < 12) {
		self.amLabel.textColor = [UIColor blackColor];
		self.pmLabel.textColor = [UIColor lightGrayColor];
		self.slashLabel.textColor = [UIColor blackColor];
	}
	// If it is PM
	else if (timeVal >= 12) {
		self.amLabel.textColor = [UIColor lightGrayColor];
		self.pmLabel.textColor = [UIColor blackColor];
		self.slashLabel.textColor = [UIColor blackColor];
	}
	
	// Background Color
	[self.backgroundView setBackgroundColor:[UIColor whiteColor]];
	
	// Clock Label
	self.timeLabel.textColor = [UIColor blackColor];
	
	// Day Label
	self.dayLabel.textColor = [UIColor blackColor];
	
	// Day and Month Label
	self.dayMonthLabel.textColor = [UIColor blackColor];
    
    // Weather Labels
    self.weatherTempLabel.textColor = [UIColor blackColor];
    self.weatherCondLabel.textColor = [UIColor blackColor];
}

// Always Night Mode is Enabled
-(void)nightMode {
	
	// Alarm Label Status
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *eventArray = [app scheduledLocalNotifications];
	
	// If there are 0 local notifications
	if ([eventArray count] == 0) {
		self.onLabel.textColor = [UIColor darkGrayColor];
		self.offLabel.textColor = [UIColor whiteColor];
		self.alarmLabel.textColor = [UIColor whiteColor];
	}
	// If there are more than 0 local notifications
	else if ([eventArray count] > 0) {
		self.onLabel.textColor = [UIColor whiteColor];
		self.offLabel.textColor = [UIColor darkGrayColor];
		self.alarmLabel.textColor = [UIColor whiteColor];
	}
	
	// AM/PM Label Status
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// If it is AM
	if (timeVal < 12) {
		self.amLabel.textColor = [UIColor whiteColor];
		self.pmLabel.textColor = [UIColor darkGrayColor];
		self.slashLabel.textColor = [UIColor whiteColor];
	}
	// If it is PM
	else if (timeVal >= 12) {
		self.amLabel.textColor = [UIColor darkGrayColor];
		self.pmLabel.textColor = [UIColor whiteColor];
		self.slashLabel.textColor = [UIColor whiteColor];
	}
	
	// Background Color
	[self.backgroundView setBackgroundColor:[UIColor blackColor]];
	
	// Clock Label
	self.timeLabel.textColor = [UIColor whiteColor];
	
	// Day Label
	self.dayLabel.textColor = [UIColor whiteColor];
	
	// Day and Month Label
	self.dayMonthLabel.textColor = [UIColor whiteColor];
    
    // Weather Labels
    self.weatherTempLabel.textColor = [UIColor whiteColor];
    self.weatherCondLabel.textColor = [UIColor whiteColor];
}

// Automatic Switching is Enabled and Custom Times are On - Times are based on Custom Times settings
-(void)customIsOn {
	
	// NSLog(@"customIsOn is being called.");
	
	// Load time objects
	NSUserDefaults *customTimePreferences = [NSUserDefaults standardUserDefaults];
	
	// Load the Hour Objects
	NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
	[hourFormat setDateFormat:@"HH"];
	
	NSDate *hourDate = [customTimePreferences objectForKey:@"dayHourObject"];
	NSString *dayHourObject = [hourFormat stringFromDate:hourDate];
	int dayHour = [dayHourObject intValue];
	NSDate *hourNightDate = [customTimePreferences objectForKey:@"nightHourObject"];
	NSString *nightHourObject = [hourFormat stringFromDate:hourNightDate];
	int nightHour = [nightHourObject intValue];
	
	// Load the Minute Objects
	NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
	[minuteFormat setDateFormat:@"mm"];
	
	NSDate *minuteDate = [customTimePreferences objectForKey:@"dayMinuteObject"];
	NSString *dayMinuteObject = [minuteFormat stringFromDate:minuteDate];
	int dayMinute = [dayMinuteObject intValue];
	NSDate *minuteNightDate = [customTimePreferences objectForKey:@"nightMinuteObject"];
	NSString *nightMinuteObject = [minuteFormat stringFromDate:minuteNightDate];
	int nightMinute = [nightMinuteObject intValue];
	
	// Find current Hour in 24 hour format
	NSDateFormatter *currentHourFormat = [[NSDateFormatter alloc] init];
	[currentHourFormat setDateFormat:@"HH"];
	NSString *hour = [currentHourFormat stringFromDate:[NSDate date]];
	int currentHour = [hour intValue];
	
	// Find current Minute
	NSDateFormatter *currentMinuteFormat = [[NSDateFormatter alloc] init];
	[currentMinuteFormat setDateFormat:@"mm"];
	NSString *minute = [currentMinuteFormat stringFromDate:[NSDate date]];
	int currentMinute = [minute intValue];
	
	// Load Day or Night mode based on Custom Times
	if (currentHour < dayHour) {
		[self nightMode];
	}
	// Get minute-to-minute updates if current time is within an hour from switch time
	// It's early morning
	else if (currentHour == dayHour) {
		if (currentMinute < dayMinute) {
			[self nightMode];
		}
		else if (currentMinute >= dayMinute) {
			[self dayMode];
		}
	}
	// During the day between switches
	else if (currentHour < nightHour && currentHour > dayHour) {
		[self dayMode];
	}
	// Get minute-to-minute updates if current time is within an hour from switch time
	else if (currentHour == nightHour) {
		if (currentMinute < nightMinute) {
			[self dayMode];
		}
		else if (currentMinute >= nightMinute) {
			[self nightMode];
		}
	}
	// It's late night
	else if (currentHour > nightHour) {
		[self nightMode];
	}
}

// Automatic Switching is Enabled and Custom Times are Off - Times switch at 8AM and 8PM
-(void)customIsOff {
    
	// NSLog(@"customIsOff is being called.");
	
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// Set night mode or day mode colors for timeLabel and weather labels
	if (timeVal <= 7) {
		self.timeLabel.textColor = [UIColor whiteColor];
        // Weather Labels
        self.weatherTempLabel.textColor = [UIColor whiteColor];
        self.weatherCondLabel.textColor = [UIColor whiteColor];
	}
	else if (timeVal <= 19 && timeVal >= 8) {
		self.timeLabel.textColor = [UIColor blackColor];
        // Weather Labels
        self.weatherTempLabel.textColor = [UIColor blackColor];
        self.weatherCondLabel.textColor = [UIColor blackColor];
	}
	else if (timeVal >= 20) {
		self.timeLabel.textColor = [UIColor whiteColor];
        // Weather Labels
        self.weatherTempLabel.textColor = [UIColor whiteColor];
        self.weatherCondLabel.textColor = [UIColor whiteColor];
	}
	
	// Set night mode or day mode colors for dayLabel
	if (timeVal <= 7) {
		self.dayLabel.textColor = [UIColor whiteColor];
	}
	else if (timeVal <= 19 && timeVal >= 8) {
		self.dayLabel.textColor = [UIColor blackColor];
	}
	else if (timeVal >= 20) {
		self.dayLabel.textColor = [UIColor whiteColor];
	}
	
	// Set night mode or day mode colors for dayMonthLabel
	if (timeVal <= 7) {
		self.dayMonthLabel.textColor = [UIColor whiteColor];
	}
	else if (timeVal <= 19 && timeVal >= 8) {
		self.dayMonthLabel.textColor = [UIColor blackColor];
	}
	else if (timeVal >= 20) {
		self.dayMonthLabel.textColor = [UIColor whiteColor];
	}
	
	// Set night or day mode colors for background
	if (timeVal <= 7) {
		[self.backgroundView setBackgroundColor:[UIColor blackColor]];
	}
	else if (timeVal <= 19 && timeVal >= 8) {
		[self.backgroundView setBackgroundColor:[UIColor whiteColor]];
	}
	else if (timeVal >= 20) {
		[self.backgroundView setBackgroundColor:[UIColor blackColor]];
	}
	
	// AM and PM Labels
	// If it is AM
	if (timeVal < 12) {
		// It's Night
		if (timeVal <= 7) {
			self.amLabel.textColor = [UIColor whiteColor];
			self.pmLabel.textColor = [UIColor darkGrayColor];
			self.slashLabel.textColor = [UIColor whiteColor];
		}
		// It's Day
		else if (timeVal <= 19 && timeVal >= 8) {
			self.amLabel.textColor = [UIColor blackColor];
			self.pmLabel.textColor = [UIColor lightGrayColor];
			self.slashLabel.textColor = [UIColor blackColor];
		}
		// It's Night
		else if (timeVal >= 20) {
			self.amLabel.textColor = [UIColor whiteColor];
			self.pmLabel.textColor = [UIColor darkGrayColor];
			self.slashLabel.textColor = [UIColor whiteColor];
		}
	}
	// If it is PM
	else if (timeVal >= 12) {
		// It's Night
		if (timeVal <= 7) {
			self.amLabel.textColor = [UIColor darkGrayColor];
			self.pmLabel.textColor = [UIColor whiteColor];
			self.slashLabel.textColor = [UIColor whiteColor];
		}
		// It's Day
		else if (timeVal <= 19 && timeVal >= 8) {
			self.amLabel.textColor = [UIColor lightGrayColor];
			self.pmLabel.textColor = [UIColor blackColor];
			self.slashLabel.textColor = [UIColor blackColor];
		}
		// It's Night
		else if (timeVal >= 20) {
			self.amLabel.textColor = [UIColor darkGrayColor];
			self.pmLabel.textColor = [UIColor whiteColor];
			self.slashLabel.textColor = [UIColor whiteColor];
		}
	}
	
	// Check local notification count
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *eventArray = [app scheduledLocalNotifications];
	
	// Change Alarm On/Off State based on [eventArray count]
	// If no alarms turn it OFF
	if ([eventArray count] == 0) {
		// It's Night
		if (timeVal <= 7) {
			self.onLabel.textColor = [UIColor darkGrayColor];
			self.offLabel.textColor = [UIColor whiteColor];
			self.alarmLabel.textColor = [UIColor whiteColor];
		}
		// It's Day
		else if (timeVal <= 19 && timeVal >= 8) {
			self.onLabel.textColor = [UIColor lightGrayColor];
			self.offLabel.textColor = [UIColor blackColor];
			self.alarmLabel.textColor = [UIColor blackColor];
		}
		// It's Night
		else if (timeVal >= 20) {
			self.onLabel.textColor = [UIColor darkGrayColor];
			self.offLabel.textColor = [UIColor whiteColor];
			self.alarmLabel.textColor = [UIColor whiteColor];
		}
	}
	// If alarms present turn it ON
	else if ([eventArray count] > 0) {
		// It's Night
		if (timeVal <= 7) {
			self.onLabel.textColor = [UIColor whiteColor];
			self.offLabel.textColor = [UIColor darkGrayColor];
			self.alarmLabel.textColor = [UIColor whiteColor];
		}
		// It's Day
		else if (timeVal <= 19 && timeVal >= 8) {
			self.onLabel.textColor = [UIColor blackColor];
			self.offLabel.textColor = [UIColor lightGrayColor];
			self.alarmLabel.textColor = [UIColor blackColor];
		}
		// It's Night
		else if (timeVal >= 20) {
			self.onLabel.textColor = [UIColor whiteColor];
			self.offLabel.textColor = [UIColor darkGrayColor];
			self.alarmLabel.textColor = [UIColor whiteColor];
		}
	}
}


#pragma mark -
#pragma mark Weather Functions

/******************* Weather *******************/

// Refresh weather button
-(IBAction)updateWeather:(id)sender {
    [self getWeather];
}

// Get and Show Weather Information
-(void)getWeather {
    
    weatherLocationManager.delegate = self;
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [weatherLocationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"description"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.weatherTempLabel.text = [NSString stringWithFormat:@"%dºF", tempString];
        self.weatherCondLabel.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
}

// If location manager fails to get location
- (void)weatherLocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

// Location updates
- (void)weatherLocationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"\n\nLONG is %@\n\nLAT is %@\n\n", longitude, latitude);
    }
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

-(void)viewDidDisappear:(BOOL)animated {
    [self getOrientation];
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
    
    float brightness = mainScreen.brightness;
    NSUserDefaults *brightnessDefault = [NSUserDefaults standardUserDefaults];
    [brightnessDefault setFloat:brightness forKey:@"brightness"];
    [brightnessDefault synchronize];
    
    // If button is pressed, night mode turned on, and if again, day mode turned on
    if (mainScreen.brightness > 0.1) {
        
        [_brightnessButton setTitle:@"View Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.0];
    }
    else if (mainScreen.brightness <= 0.1) {
        
        [_brightnessButton setTitle:@"Night Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:brightness];
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
        [self.refreshButton setEnabled:YES];
        [self.refreshButton setAlpha:1.0];
        // [self.betaButton setUserInteractionEnabled:YES];
        NSLog(@"Build is a beta build.");
    }
    else if (buildBOOL == 0) {
        [self.betaButton setEnabled:NO];
        [self.betaButton setAlpha:0.0];
        [self.refreshButton setEnabled:NO];
        [self.refreshButton setAlpha:0.0];
        // [self.betaButton setUserInteractionEnabled:NO];
        NSLog(@"Build is NOT a beta build.");
    }
}

@end
