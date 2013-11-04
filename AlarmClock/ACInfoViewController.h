//
//  ACInfoViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACInfoViewController : UIViewController  {
    
    IBOutlet UISwitch *alarmSwitch;
    // NSInteger alarmState;
}

@property (nonatomic, retain) UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property(nonatomic,readonly) UIBarPosition barPosition;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmPicker;

-(IBAction)pressDone;
-(void)nightMode;
-(IBAction)toggleEnabledForAlarmSwitch:(id)sender;
-(void)saveValue;
-(BOOL)readValue;
-(void)saveAlarm;

@end
