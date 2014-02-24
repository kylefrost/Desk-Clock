//
//  ACViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACViewController : UIViewController {
    
    NSDate *dateOfInterest;
    NSString *monthName;
    NSString *dayOfMonth;
    
}

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

// Landscape Functions
-(void)updateTimeLandscape;
-(void)updateDayLandscape;
-(void)updateMonthDayLandscape;
-(void)updateAlarmLandscape;
-(void)updateAMPMLandscape;

// Portrait/Lanscape Independent Functions
-(void)updateClockLabelTime;
-(void)updateDayLabelDate;
-(void)updateDayMonthLabelDate;
-(void)updateAlarmLabelStatus;
-(void)updateAMPMLabelStatus;
-(void)updateLabelColors;
-(void)updateBackgroundColor;

@end
