//
//  ACViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACViewController~ipad.h"
#import "Definitions~ipad.h"
#import "ACAppDelegate.h"
#import "ACAlarmObject~ipad.h"
#import "ACAlarmViewController~ipad.h"
#import "OWMWeatherAPI.h"

#import "UIColor+Custom.h"

#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIScreen.h>
#import <CoreLocation/CoreLocation.h>

@interface ACViewController_ipad ()

@end

@implementation ACViewController_ipad {
    CLLocationManager *weatherLocationManager;
}

@synthesize player;
@synthesize brightness = _brightness;

// Load Tutorial if it is First Open
-(void)isFirstOpen {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"notFirstRun"] != YES || [defaults boolForKey:@"notFirstRun"] == 0) {
        [self isFirstRun];
        [defaults setBool:YES forKey:@"notFirstRun"];
        [defaults synchronize];
    }
    else {
        nil;
    }
}

-(void)isFirstRun {
    
    UIAlertView *firstAlert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                         message:@"We noticed this is your first time opening Desk Clock. We recommend you take a look around Settings in order to get Desk Clock just how you like it. Set custom Night Mode times, change your weather preferences, and even pick a theme. Thank you for buying Desk Clock!"
                                                        delegate:self
                                               cancelButtonTitle:@"No thanks"
                                               otherButtonTitles:@"Open Settings...", nil];
    [firstAlert setTag:2];
    [firstAlert show];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = 0;
    
    if (amRange.location == NSNotFound && pmRange.location == NSNotFound) {
        is24h = 1;
    }
    else if (amRange.location != NSNotFound && pmRange.location != NSNotFound) {
        is24h = 0;
    }
    
    if (is24h == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:1 forKey:@"enabledSwitch"];
        [userDefaults setBool:0 forKey:@"alwaysDaySwitch"];
        [userDefaults setBool:0 forKey:@"alwaysNightSwitch"];
        [userDefaults setBool:0 forKey:@"customTimeSwitch"];
        
        [userDefaults setBool:1 forKey:@"currentLocationSwitch"];
        [userDefaults setBool:0 forKey:@"celsiusSwitch"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm a"];
        
        NSDate *morning = [dateFormat dateFromString:@"08:00"];
        NSDate *night = [dateFormat dateFromString:@"20:00"];
        
        [userDefaults setObject:morning forKey:@"dayTimeFullObject"];
        [userDefaults setObject:night forKey:@"nightTimeFullObject"];
        
        // HOUR
        NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
        [hourFormat setDateFormat:@"HH"];
        
        NSDate *hourMorning = morning;
        NSDate *hourNight = night;
        
        [userDefaults setObject:hourMorning forKey:@"dayHourObject"];
        [userDefaults setObject:hourNight forKey:@"nightHourObject"];
        
        // MINUTE
        NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
        [minuteFormat setDateFormat:@"mm"];
        
        NSDate *minuteMorning = morning;
        NSDate *minuteNight = night;
        
        [userDefaults setObject:minuteMorning forKey:@"dayMinuteObject"];
        [userDefaults setObject:minuteNight forKey:@"nightMinuteObject"];
        
        // AM PM
        NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
        [ampmFormat setDateFormat:@"a"];
        
        NSDate *dayAM = morning;
        NSDate *nightPM = night;
        
        [userDefaults setObject:dayAM forKey:@"dayAMPMObject"];
        [userDefaults setObject:nightPM forKey:@"nightAMPMObject"];
        
        [userDefaults synchronize];
    }
    else if (is24h == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:1 forKey:@"enabledSwitch"];
        [userDefaults setBool:0 forKey:@"alwaysDaySwitch"];
        [userDefaults setBool:0 forKey:@"alwaysNightSwitch"];
        [userDefaults setBool:0 forKey:@"customTimeSwitch"];
        
        [userDefaults setBool:1 forKey:@"currentLocationSwitch"];
        [userDefaults setBool:0 forKey:@"celsiusSwitch"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"h:mm a"];
        
        NSDate *morning = [dateFormat dateFromString:@"8:00 AM"];
        NSDate *night = [dateFormat dateFromString:@"8:00 PM"];
        
        [userDefaults setObject:morning forKey:@"dayTimeFullObject"];
        [userDefaults setObject:night forKey:@"nightTimeFullObject"];
        
        // HOUR
        NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
        [hourFormat setDateFormat:@"h"];
        
        NSDate *hourMorning = morning;
        NSDate *hourNight = night;
        
        [userDefaults setObject:hourMorning forKey:@"dayHourObject"];
        [userDefaults setObject:hourNight forKey:@"nightHourObject"];
        
        // MINUTE
        NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
        [minuteFormat setDateFormat:@"mm"];
        
        NSDate *minuteMorning = morning;
        NSDate *minuteNight = night;
        
        [userDefaults setObject:minuteMorning forKey:@"dayMinuteObject"];
        [userDefaults setObject:minuteNight forKey:@"nightMinuteObject"];
        
        // AM PM
        NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
        [ampmFormat setDateFormat:@"a"];
        
        NSDate *dayAM = morning;
        NSDate *nightPM = night;
        
        [userDefaults setObject:dayAM forKey:@"dayAMPMObject"];
        [userDefaults setObject:nightPM forKey:@"nightAMPMObject"];
        
        [userDefaults synchronize];
    }
    
    // Set Default Theme On First Launch
    NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
    NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
    NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customLightGrayColor]];
    NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
    NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
    NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
    
    NSString *themeFont = @"Digital-7 Mono";
    NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkRedColor]];
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
    [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
    [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
    [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
    [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
    [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
    [themeDefaults setObject:themeFont forKey:@"themeFont"];
    [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
    
    [themeDefaults synchronize];
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
    
    [self determineBuild];
    
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    
    BOOL enabledSwitchState = [nightViewPreferences boolForKey:@"enabledSwitch"];
    BOOL alwaysOnDaySwitchState = [nightViewPreferences boolForKey:@"alwaysDaySwitch"];
    BOOL alwaysOnSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
    BOOL customTimeSwitchState = [nightViewPreferences boolForKey:@"customTimeSwitch"];
    
    if (enabledSwitchState == 0 && alwaysOnDaySwitchState == 0 && alwaysOnSwitchState == 0 && customTimeSwitchState == 0) {
        [nightViewPreferences setBool:1 forKey:@"enabledSwitch"];
    }
    
    [self addAllTheSubViews];
    
    // Slide Status Bar out of view when this View loads
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    // Load tutorial if it is the first open
    [self isFirstOpen];
    
//    // iCloud syncing
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(updateAlarmPortrait)
//                                                 name:kMKiCloudSyncNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(updateAlarmLandscape)
//                                                 name:kMKiCloudSyncNotification
//                                               object:nil];
//    
//    [MKiCloudSync start];
//    [MKiCloudSync initialize];
    
    // Get Orientation at launch
    [self getOrientation];
    
    // Run Portrait/Landscape Independent Functions (found at bottom)
    [self updateClockLabelTime];
    [self updateDayLabelDate];
    [self updateDayMonthLabelDate];
    [self checkNightMode];
    
    weatherLocationManager.delegate = self;
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [weatherLocationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    weatherLocationManager = [[CLLocationManager alloc] init];
    
    [self getWeather];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [self.fadeView setAlpha:0.0];
    // [banner setUserInteractionEnabled:YES];
    
    [UIView commitAnimations];
    
    // Find brightness
    UIScreen *mainScreen = [UIScreen mainScreen];
    // mainScreen.brightness = 0.5;
    
    self.brightness = mainScreen.brightness;
}

-(void)addAllTheSubViews {
    // Add Main Labels
    self.timeLabel = [[UILabel alloc] init];
    [self.view addSubview:self.timeLabel];
    self.dayLabel = [[UILabel alloc] init];
    [self.view addSubview:self.dayLabel];
    self.dayMonthLabel = [[UILabel alloc] init];
    [self.view addSubview:self.dayMonthLabel];
    
    // Add Alarm Labels
    self.alarmLabel = [[UILabel alloc] init];
    [self.view addSubview:self.alarmLabel];
    self.onLabel = [[UILabel alloc] init];
    [self.view addSubview:self.onLabel];
    self.offLabel = [[UILabel alloc] init];
    [self.view addSubview:self.offLabel];
    
    // Add AM / PM labels
    self.amLabel = [[UILabel alloc] init];
    [self.view addSubview:self.amLabel];
    self.pmLabel = [[UILabel alloc] init];
    [self.view addSubview:self.pmLabel];
    self.slashLabel = [[UILabel alloc] init];
    [self.view addSubview:self.slashLabel];
    
    // Add Weather Labels
    self.weatherTempLabel = [[UILabel alloc] init];
    [self.view addSubview:self.weatherTempLabel];
    self.weatherCondLabel = [[UILabel alloc] init];
    [self.view addSubview:self.weatherCondLabel];
    
    [self getOrientation];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
}

// Set code to play alarm if the alarm is going off
-(void)viewDidAppear:(BOOL)animated {
    
    [self getWeather];
    
    // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    //This checks if the home view is shown because of an alarm firing
    if(self.alarmGoingOff) {
        
        UIAlertView *alarmAlert = [[UIAlertView alloc] initWithTitle:@"Your alarm is sounding!"
                                                             message:@"Press done to stop."
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
    
    if ([alertView tag] == 1) {
        if(buttonIndex == 0) {
            
            NSLog(@"Button pressed");
            ACAppDelegate * myAppDelegate = (ACAppDelegate*)[[UIApplication sharedApplication] delegate];
            [myAppDelegate.player stop];
            
        } else {
            
            // Well, nothing.
            
        }
    }
    
    if ([alertView tag] == 2) {
        
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"LoadTutorialView_ipad" sender:self];
        }
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
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self performSelector:@selector(getOrientation) withObject:self afterDelay:0.1];
}

#pragma mark -
#pragma mark Portrait Functions

/******************* All Portrait Functions *******************/

// Update the timeLabel for Portrait view
-(void)updateTimePortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set label attributes
    self.timeLabel.font = [UIFont fontWithName:themeFont size:TIME_SIZE_PORTRAIT];
    [self.timeLabel setFrame:TIME_LABEL_RECT_PORTRAIT];
    
}

// Update the dayLabel for Portrait view
-(void)updateDayPortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set label attributes
    self.dayLabel.font = [UIFont fontWithName:themeFont size:DAY_LABEL_SIZE_PORTRAIT];
    [self.dayLabel setFrame:DAY_LABEL_RECT_PORTRAIT];
    
}

// Update the dayMonthLabel for Portrait view
-(void)updateMonthDayPortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set day of week label attributes
    _dayMonthLabel.font = [UIFont fontWithName:themeFont size:DAYMONTH_LABEL_SIZE_PORTRAIT];
    [_dayMonthLabel setFrame:DAYMONTH_LABEL_RECT_PORTRAIT];
    
}

// Update the alarmLabel for Portrait view
-(void)updateAlarmPortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set text attributes
    self.onLabel.font = [UIFont fontWithName:themeFont size:ON_OFF_SIZE_PORTRAIT];
    [self.onLabel setFrame:ON_LABEL_RECT_PORTRAIT];
    self.onLabel.text = @"ON";
    
    self.offLabel.font = [UIFont fontWithName:themeFont size:ON_OFF_SIZE_PORTRAIT];
    [self.offLabel setFrame:OFF_LABEL_RECT_PORTRAIT];
    self.offLabel.text = @"OFF";
    
    self.alarmLabel.font = [UIFont fontWithName:themeFont size:ALARM_LABEL_SIZE_PORTRAIT];
    [self.alarmLabel setFrame:ALARM_LABEL_RECT_PORTRAIT];
    self.alarmLabel.text = @"Alarm";
    
}

// Update the amLabel and pmLabel and slashLabel for Portrait view
-(void)updateAMPMPortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set text attributes
    self.amLabel.font = [UIFont fontWithName:themeFont size:AM_PM_SIZE_PORTRAIT];
    [self.amLabel setFrame:AM_LABEL_RECT_PORTRAIT];
    self.amLabel.text = @"AM";
    
    self.pmLabel.font = [UIFont fontWithName:themeFont size:AM_PM_SIZE_PORTRAIT];
    [self.pmLabel setFrame:PM_LABEL_RECT_PORTRAIT];
    self.pmLabel.text = @"PM";
    
    self.slashLabel.font = [UIFont fontWithName:themeFont size:SLASH_SIZE_PORTRAIT];
    [self.slashLabel setFrame:SLASH_LABEL_RECT_PORTRAIT];
    self.slashLabel.text = @"/";
    
}

// Update the weather labels for Portrait view
-(void)updateWeatherPortrait {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    self.weatherTempLabel.font = [UIFont fontWithName:themeFont size:TEMP_SIZE_PORTRAIT];
    self.weatherCondLabel.font = [UIFont fontWithName:themeFont size:COND_SIZE_PORTRAIT];
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
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set label attributes
    self.timeLabel.font = [UIFont fontWithName:themeFont size:TIME_SIZE_LANDSCAPE];
    [self.timeLabel setFrame:TIME_LABEL_RECT_LANDSCAPE];
    
}

// Update the dayLabel for Landscape view
-(void)updateDayLandscape {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set label attributes
    self.dayLabel.font = [UIFont fontWithName:themeFont size:DAY_LABEL_SIZE_LANDSCAPE];
    [self.dayLabel setFrame:DAY_LABEL_RECT_LANDSCAPE];
}

// Update the dayMonthLabel for Landscape view
-(void)updateMonthDayLandscape {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set day of week label attributes
    _dayMonthLabel.font = [UIFont fontWithName:themeFont size:DAYMONTH_LABEL_SIZE_LANDSCAPE];
    [_dayMonthLabel setFrame:DAYMONTH_LABEL_RECT_LANDSCAPE];
    
}

// Update the alarmLabel for Landscape view
-(void)updateAlarmLandscape {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set text attributes
    self.onLabel.font = [UIFont fontWithName:themeFont size:ON_OFF_SIZE_LANDSCAPE];
    [self.onLabel setFrame:ON_LABEL_RECT_LANDSCAPE];
    self.onLabel.text = @"ON";
    
    self.offLabel.font = [UIFont fontWithName:themeFont size:ON_OFF_SIZE_LANDSCAPE];
    [self.offLabel setFrame:OFF_LABEL_RECT_LANDSCAPE];
    self.offLabel.text = @"OFF";
    
    self.alarmLabel.font = [UIFont fontWithName:themeFont size:ALARM_LABEL_SIZE_LANDSCAPE];
    [self.alarmLabel setFrame:ALARM_LABEL_RECT_LANDSCAPE];
    self.alarmLabel.text = @"Alarm";
    
}

// Update the amLabel and pmLabel and slashLabel for Landscape view
-(void)updateAMPMLandscape {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    // Set text attributes
    self.amLabel.font = [UIFont fontWithName:themeFont size:AM_PM_SIZE_LANDSCAPE];
    [self.amLabel setFrame:AM_LABEL_RECT_LANDSCAPE];
    self.amLabel.text = @"AM";
    
    self.pmLabel.font = [UIFont fontWithName:themeFont size:AM_PM_SIZE_LANDSCAPE];
    [self.pmLabel setFrame:PM_LABEL_RECT_LANDSCAPE];
    self.pmLabel.text = @"PM";
    
    self.slashLabel.font = [UIFont fontWithName:themeFont size:SLASH_SIZE_LANDSCAPE];
    [self.slashLabel setFrame:SLASH_LABEL_RECT_LANDSCAPE];
    self.slashLabel.text = @"/";
    
}

// Update the weather labels for Portrait view
-(void)updateWeatherLandscape {
    
    NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
    NSString *themeFont = [themeDefaults objectForKey:@"themeFont"];
    
    self.weatherTempLabel.font = [UIFont fontWithName:themeFont size:TEMP_SIZE_LANDSCAPE];
    self.weatherCondLabel.font = [UIFont fontWithName:themeFont size:COND_SIZE_LANDSCAPE];
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
    self.timeLabel.text = [dateFormat stringFromDate:[NSDate date]];
    
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
        self.dayLabel.text = @"Sunday";
    }
    else if (weekday == 2) {
        self.dayLabel.text = @"Monday";
    }
    else if (weekday == 3) {
        self.dayLabel.text = @"Tuesday";
    }
    else if (weekday == 4) {
        self.dayLabel.text = @"Wednesday";
    }
    else if (weekday == 5) {
        self.dayLabel.text = @"Thursday";
    }
    else if (weekday == 6) {
        self.dayLabel.text = @"Friday";
    }
    else if (weekday == 7) {
        self.dayLabel.text = @"Saturday";
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
	
    NSData *dayTextColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"dayTextColor"];
    UIColor *dayTextColor = [NSKeyedUnarchiver unarchiveObjectWithData:dayTextColorData];
    
    NSData *dayBackgroundColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"dayBackgroundColor"];
    UIColor *dayBackgroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:dayBackgroundColorData];
    
    NSData *dayLabelOffColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"dayLabelOffColor"];
    UIColor *dayLabelOffColor = [NSKeyedUnarchiver unarchiveObjectWithData:dayLabelOffColorData];
    
    NSData *themeTintData = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeTintColor"];
    UIColor *themeTint = [NSKeyedUnarchiver unarchiveObjectWithData:themeTintData];
    
	// Alarm Label Status
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *eventArray = [app scheduledLocalNotifications];
	
	// If there are 0 local notifications
	if ([eventArray count] == 0) {
		self.onLabel.textColor = dayLabelOffColor;
		self.offLabel.textColor = dayTextColor;
		self.alarmLabel.textColor = dayTextColor;
	}
	// If there are more than 0 local notifications
	else if ([eventArray count] > 0) {
		self.onLabel.textColor = dayTextColor;
		self.offLabel.textColor = dayLabelOffColor;
		self.alarmLabel.textColor = dayTextColor;
	}
	
	// AM/PM Label Status
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// If it is AM
	if (timeVal < 12) {
		self.amLabel.textColor = dayTextColor;
		self.pmLabel.textColor = dayLabelOffColor;
		self.slashLabel.textColor = dayTextColor;
	}
	// If it is PM
	else if (timeVal >= 12) {
		self.amLabel.textColor = dayLabelOffColor;
		self.pmLabel.textColor = dayTextColor;
		self.slashLabel.textColor = dayTextColor;
	}
	
	// Background Color
	[self.backgroundView setBackgroundColor:dayBackgroundColor];
	
	// Clock Label
	self.timeLabel.textColor = dayTextColor;
	
	// Day Label
	self.dayLabel.textColor = dayTextColor;
	
	// Day and Month Label
	self.dayMonthLabel.textColor = dayTextColor;
    
    // Weather Labels
    self.weatherTempLabel.textColor = dayTextColor;
    self.weatherCondLabel.textColor = dayTextColor;
    
    // Set App Tint Color
    [[UIView appearance] setTintColor:themeTint];
    
    // Set Button Tint
    UIImage *image = [UIImage imageNamed:@"settingsButton"];
    UIImage *templateImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.settingsButton setImage:templateImage forState:UIControlStateNormal];
    self.settingsButton.tintColor = themeTint;
}

// Always Night Mode is Enabled
-(void)nightMode {
    
    NSData *nightTextColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"nightTextColor"];
    UIColor *nightTextColor = [NSKeyedUnarchiver unarchiveObjectWithData:nightTextColorData];
    
    NSData *nightBackgroundColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"nightBackgroundColor"];
    UIColor *nightBackgroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:nightBackgroundColorData];
    
    NSData *nightLabelOffColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"nightLabelOffColor"];
    UIColor *nightLabelOffColor = [NSKeyedUnarchiver unarchiveObjectWithData:nightLabelOffColorData];
    
    NSData *themeTintData = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeTintColor"];
    UIColor *themeTint = [NSKeyedUnarchiver unarchiveObjectWithData:themeTintData];
	
	// Alarm Label Status
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *eventArray = [app scheduledLocalNotifications];
	
	// If there are 0 local notifications
	if ([eventArray count] == 0) {
		self.onLabel.textColor = nightLabelOffColor;
		self.offLabel.textColor = nightTextColor;
		self.alarmLabel.textColor = nightTextColor;
	}
	// If there are more than 0 local notifications
	else if ([eventArray count] > 0) {
		self.onLabel.textColor = nightTextColor;
		self.offLabel.textColor = nightLabelOffColor;
		self.alarmLabel.textColor = nightTextColor;
	}
	
	// AM/PM Label Status
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// If it is AM
	if (timeVal < 12) {
		self.amLabel.textColor = nightTextColor;
		self.pmLabel.textColor = nightLabelOffColor;
		self.slashLabel.textColor = nightTextColor;
	}
	// If it is PM
	else if (timeVal >= 12) {
		self.amLabel.textColor = nightLabelOffColor;
		self.pmLabel.textColor = nightTextColor;
		self.slashLabel.textColor = nightTextColor;
	}
	
	// Background Color
	[self.backgroundView setBackgroundColor:nightBackgroundColor];
	
	// Clock Label
	self.timeLabel.textColor = nightTextColor;
	
	// Day Label
	self.dayLabel.textColor = nightTextColor;
	
	// Day and Month Label
	self.dayMonthLabel.textColor = nightTextColor;
    
    // Weather Labels
    self.weatherTempLabel.textColor = nightTextColor;
    self.weatherCondLabel.textColor = nightTextColor;
    
    // Set App Tint Color
    [[UIView appearance] setTintColor:themeTint];
    
    // Set Button Tint
    UIImage *image = [UIImage imageNamed:@"settingsButton"];
    UIImage *templateImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.settingsButton setImage:templateImage forState:UIControlStateNormal];
    self.settingsButton.tintColor = themeTint;
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
    
	// Find time in 24 hour format
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH"];
	NSString *time = [timeFormat stringFromDate:[NSDate date]];
	int timeVal = [time intValue];
	
	// Set night mode or day mode colors for timeLabel and weather labels
	if (timeVal <= 7) {
        [self nightMode];
	}
	else if (timeVal <= 19 && timeVal >= 8) {
        [self dayMode];
	}
	else if (timeVal >= 20) {
        [self nightMode];
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
    
    NSUserDefaults *weatherDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL currentLocation = [weatherDefaults boolForKey:@"currentLocationSwitch"];
    
    if (currentLocation == 1) {
        [self useCurrentLocation];
    }
    else if (currentLocation == 0) {
        [self useCustomLocation];
    }
    
    float refreshTime = [weatherDefaults floatForKey:@"refreshTime"];
    
    if (refreshTime < 900.0) {
        [self performSelector:@selector(getWeather) withObject:self afterDelay:900.0];
    }
    else {
        [self performSelector:@selector(getWeather) withObject:self afterDelay:refreshTime];
    }
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

// If Weather is in Celsius for Current Location
-(void)weatherIsCelsiusCurrentLocation {
    
    weatherLocationManager.delegate = self;
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [weatherLocationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempCelcius];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"main"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.weatherTempLabel.text = [NSString stringWithFormat:@"%dºC", tempString];
        self.weatherCondLabel.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
}

// Weather is in Celsius for Custom Location
-(void)weatherIsCelsiusCustomLocation {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *customLocation = [defaults objectForKey:@"customLocationField"];
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempCelcius];
    
    NSString *customLocationNoSpace = [customLocation stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [weatherAPI currentWeatherByCityName:customLocationNoSpace withCallback:^(NSError *error, NSDictionary *result) {
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"main"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.weatherTempLabel.text = [NSString stringWithFormat:@"%dºC", tempString];
        self.weatherCondLabel.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
}

// If Weather is in Fahrenheit for Current Location
-(void)weatherIsFahrenheitCurrentLocation {
    
    weatherLocationManager.delegate = self;
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [weatherLocationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"main"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.weatherTempLabel.text = [NSString stringWithFormat:@"%dºF", tempString];
        self.weatherCondLabel.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
}

// If Weather is in Fahrenheit for Custom Location
-(void)weatherIsFahrenheitCustomLocation {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *customLocation = [defaults objectForKey:@"customLocationField"];
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    NSString *customLocationNoSpace = [customLocation stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"%@", customLocationNoSpace);
    
    [weatherAPI currentWeatherByCityName:customLocationNoSpace withCallback:^(NSError *error, NSDictionary *result) {
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"main"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.weatherTempLabel.text = [NSString stringWithFormat:@"%dºF", tempString];
        self.weatherCondLabel.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
}

// If Weather is custom location
-(void)useCustomLocation {
    
    NSUserDefaults *weatherDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL celsius = [weatherDefaults boolForKey:@"celsiusSwitch"];
    
    if (celsius == 1) {
        [self weatherIsCelsiusCustomLocation];
    }
    else if (celsius == 0) {
        [self weatherIsFahrenheitCustomLocation];
    }
}

// If Weather is current location
-(void)useCurrentLocation {
    
    NSUserDefaults *weatherDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL celsius = [weatherDefaults boolForKey:@"celsiusSwitch"];
    
    if (celsius == 1) {
        [self weatherIsCelsiusCurrentLocation];
    }
    else if (celsius == 0) {
        [self weatherIsFahrenheitCurrentLocation];
    }
}

#pragma mark -
#pragma mark Miscellaneous Functions

/******************* Miscellaneous *******************/

-(void)viewWillDisappear:(BOOL)animated {
    
    [[UIScreen mainScreen] setBrightness:self.brightness];
}

-(void)viewDidDisappear:(BOOL)animated {
    
}

-(IBAction)rotatePortrait:(id)sender {
    
}

// Did Receive Memory Warning
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Action for brightnessButton
-(IBAction)updateBrightness {
    
    [UIScreen mainScreen].wantsSoftwareDimming = YES;
    
    // If button is pressed, night mode turned on, and if again, day mode turned on
    if ([UIScreen mainScreen].brightness > 0.1) {
        
        [self.brightnessButton setTitle:@"Normal Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:0.0];
    }
    else if ([UIScreen mainScreen].brightness <= 0.1) {
        
        [self.brightnessButton setTitle:@"Lower Power Mode" forState:UIControlStateNormal];
        [[UIScreen mainScreen] setBrightness:self.brightness];
    }
    
    NSLog(@"%f", self.brightness);
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
