//
//  ACInfoViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACInfoViewController_ipad : UIViewController {
    
    IBOutlet UISwitch *alarmSwitch;
    IBOutlet UIButton *betaButton;
    // NSInteger alarmState;
}

@property (nonatomic, retain) UISwitch *alarmSwitch;
@property (nonatomic, retain) IBOutlet UIButton *betaButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property(nonatomic,readonly) UIBarPosition barPosition;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmPicker;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;

-(IBAction)pressDone;
-(void)nightMode;
-(IBAction)toggleEnabledForAlarmSwitch:(id)sender;
-(void)saveValue;
-(BOOL)readValue;
-(void)determineBuild;
// -(void)saveAlarm;

@end
