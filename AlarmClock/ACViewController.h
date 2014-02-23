//
//  ACViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//
//  Test GitHub Branches

#import <UIKit/UIKit.h>

@interface ACViewController : UIViewController {
    
    NSDate *dateOfInterest;
    NSString *monthName;
    NSString *dayOfMonth;
    // IBOutlet UILabel *timeLabel;
    // BOOL alarmState;
    // int findWeekDay(int date);
    // int date;
    
}


// int findWeekDay(int date);

// First Open
-(void)loadTutorial;
-(void)isFirstOpen;
-(void)showTutorial;
-(BOOL)readValue;

// Brightness Button
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;
-(IBAction)updateBrightness;

// Background
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

// Check Orientation
-(void)getOrientation;

// Update Label Time
-(void)updateClockLabelTime;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) UILabel *dayLabel;
@property (weak, nonatomic) UILabel *dayMonthLabel;
@property (weak, nonatomic) UILabel *alarmLabel;
@property (weak, nonatomic) UILabel *onLabel;
@property (weak, nonatomic) UILabel *offLabel;
@property (weak, nonatomic) UILabel *amLabel;
@property (weak, nonatomic) UILabel *pmLabel;
@property (weak, nonatomic) UILabel *slashLabel;
-(void)addAllTheSubviews;

// Portrait Stuff
@property (strong, nonatomic) UILabel *timeLabelPortrait;
@property (strong, nonatomic) UILabel *dayLabelPortrait;
@property (strong, nonatomic) UILabel *dayMonthLabelPortrait;
@property (strong, nonatomic) UILabel *alarmLabelPortrait;
@property (strong, nonatomic) UILabel *onLabelPortrait;
@property (strong, nonatomic) UILabel *offLabelPortrait;
@property (strong, nonatomic) UILabel *amLabelPortrait;
@property (strong, nonatomic) UILabel *pmLabelPortrait;
@property (strong, nonatomic) UILabel *slashLabelPortrait;
-(void)loadPortraitLabels;
-(void)setUpPortraitView;
// Portrait Functions
-(void)updateTimePortrait;
-(void)updateDayPortrait;
-(void)updateMonthDayPortrait;
-(void)updateAlarmPortrait;
-(void)updateAMPMPortrait;


// Landscape Stuff
@property (strong, nonatomic) UILabel *timeLabelLandscape;
@property (strong, nonatomic) UILabel *dayLabelLandscape;
@property (strong, nonatomic) UILabel *dayMonthLabelLandscape;
@property (strong, nonatomic) UILabel *alarmLabelLandscape;
@property (strong, nonatomic) UILabel *onLabelLandscape;
@property (strong, nonatomic) UILabel *offLabelLandscape;
@property (strong, nonatomic) UILabel *amLabelLandscape;
@property (strong, nonatomic) UILabel *pmLabelLandscape;
@property (strong, nonatomic) UILabel *slashLabelLandscape;
-(void)loadLandscapeLabels;
-(void)setUpLandscapeView;
// Landscape Functions
-(void)updateTimeLandscape;
-(void)updateDayLandscape;
-(void)updateMonthDayLandscape;
-(void)updateAlarmLandscape;
-(void)updateAMPMLandscape;

@end
