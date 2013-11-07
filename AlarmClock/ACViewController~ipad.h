//
//  ACViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACViewController_ipad : UIViewController {
    
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

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLabel;
@property (weak, nonatomic) IBOutlet UILabel *offLabel;
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;
@property (weak, nonatomic) IBOutlet UILabel *amLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UILabel *slashLabel;

@end
