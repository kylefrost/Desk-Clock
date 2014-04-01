//
//  ACViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ACViewController : UIViewController <UIAlertViewDelegate, CLLocationManagerDelegate> {
    
    NSDate *dateOfInterest;
    NSString *monthName;
    NSString *dayOfMonth;
    
}

// Check for alarm
@property(nonatomic) BOOL alarmGoingOff;
@property (nonatomic, strong) AVAudioPlayer *player;

// Alarm Label Determinate
@property (nonatomic, strong) NSMutableArray *listOfAlarms;

// First Open
-(void)loadTutorial;
-(void)isFirstOpen;
-(void)showTutorial;
-(BOOL)readValue;

// Brightness Button
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;
-(IBAction)updateBrightness;

// Night Mode
-(void)checkNightMode;
-(void)dayMode;
-(void)nightMode;
-(void)customIsOn;
-(void)customIsOff;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

// Weather
@property (weak, nonatomic) IBOutlet UILabel *weatherTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherCondLabel;
-(void)getWeather;
-(IBAction)updateWeather:(id)sender;

// Check Orientation
-(void)getOrientation;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLabel;
@property (weak, nonatomic) IBOutlet UILabel *offLabel;
@property (weak, nonatomic) IBOutlet UILabel *amLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UILabel *slashLabel;

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
