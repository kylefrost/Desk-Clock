//
//  ACViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ACViewController_ipad : UIViewController <UIAlertViewDelegate, CLLocationManagerDelegate> {
    
    NSDate *dateOfInterest;
    NSString *monthName;
    NSString *dayOfMonth;
    
    float brightness;
}

// Fade in view
@property (weak, nonatomic) IBOutlet UIView *fadeView;

// Check for alarm
@property(nonatomic) BOOL alarmGoingOff;
@property (nonatomic, strong) AVAudioPlayer *player;

// Alarm Label Determinate
@property (nonatomic, strong) NSMutableArray *listOfAlarms;

// First Open
-(void)isFirstOpen;
-(void)isFirstRun;
-(BOOL)readValue;

// Brightness and Settings Button
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
-(IBAction)updateBrightness;

// Night Mode
-(void)checkNightMode;
-(void)dayMode;
-(void)nightMode;
-(void)customIsOn;
-(void)customIsOff;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

// Weather
@property (retain, nonatomic) UILabel *weatherTempLabel;
@property (retain, nonatomic) UILabel *weatherCondLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
-(void)getWeather;
-(IBAction)updateWeather:(id)sender;
-(void)weatherIsCelsiusCurrentLocation;
-(void)weatherIsCelsiusCustomLocation;
-(void)weatherIsFahrenheitCurrentLocation;
-(void)weatherIsFahrenheitCustomLocation;
-(void)useCustomLocation;
-(void)useCurrentLocation;

// Check Orientation
-(void)getOrientation;
-(IBAction)rotatePortrait:(id)sender;

// Labels
@property (retain, nonatomic) UILabel *timeLabel;
@property (retain, nonatomic) UILabel *dayLabel;
@property (retain, nonatomic) UILabel *dayMonthLabel;
@property (retain, nonatomic) UILabel *alarmLabel;
@property (retain, nonatomic) UILabel *onLabel;
@property (retain, nonatomic) UILabel *offLabel;
@property (retain, nonatomic) UILabel *amLabel;
@property (retain, nonatomic) UILabel *pmLabel;
@property (retain, nonatomic) UILabel *slashLabel;

// Portrait Functions
-(void)updateTimePortrait;
-(void)updateDayPortrait;
-(void)updateMonthDayPortrait;
-(void)updateAlarmPortrait;
-(void)updateAMPMPortrait;
-(void)updateWeatherPortrait;

// Landscape Functions
-(void)updateTimeLandscape;
-(void)updateDayLandscape;
-(void)updateMonthDayLandscape;
-(void)updateAlarmLandscape;
-(void)updateAMPMLandscape;
-(void)updateWeatherLandscape;

// Portrait/Lanscape Independent Functions
-(void)updateClockLabelTime;
-(void)updateDayLabelDate;
-(void)updateDayMonthLabelDate;

// Beta Button
@property (nonatomic, retain) IBOutlet UIButton *betaButton;
-(void)determineBuild;

@end