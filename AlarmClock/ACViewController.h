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
    // int findWeekDay(int date);
    // int date;
    
}

// int findWeekDay(int date);
-(void)updateTime;
-(void)updateDay;
-(void)updateMonthDay;
-(void)updateAlarm;
-(IBAction)updateBrightness;

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLabel;
@property (weak, nonatomic) IBOutlet UILabel *offLabel;
@property(nonatomic) CGFloat brightness;
@property (weak, nonatomic) IBOutlet UIButton *brightnessButton;

@end
