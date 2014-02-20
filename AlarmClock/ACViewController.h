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
    // BOOL alarmState;
    // int findWeekDay(int date);
    // int date;
    
}


// int findWeekDay(int date);
-(void)updateTime;
-(void)updateDay;
-(void)updateMonthDay;
-(void)updateAlarm;
-(IBAction)updateBrightness;
-(void)updateAMPM;
-(BOOL)readValue;

// First Open
-(void)loadTutorial;
-(void)isFirstOpen;
-(void)showTutorial;

// Brightness Button
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;

// Background
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

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
-(void)refreshPortraitView;


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
-(void)refreshLandscapeView;

@end
