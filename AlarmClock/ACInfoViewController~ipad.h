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
    NSInteger alarmState;
}

@property (nonatomic, retain) UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property(nonatomic,readonly) UIBarPosition barPosition;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

-(IBAction)pressDone;
-(void)nightMode;
-(IBAction)toggleEnabledForAlarmSwitch:(id)sender;

@end
