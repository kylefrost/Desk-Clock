//
//  ACBetaViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 11/6/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACAppDelegate.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>

@interface ACBetaViewController_ipad : UIViewController <CLLocationManagerDelegate> {
    
    NSString *currentTemp;
    
}

@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property (nonatomic, readonly) UIBarPosition barPosition;
@property (weak, nonatomic) IBOutlet UIButton *crashButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *weather;

-(IBAction)closeBetaSettings;

// Beta Settings

-(IBAction)pressCrashButton;
-(IBAction)resetTutorial;
-(IBAction)sendReport:(id)sender;
-(IBAction)getWeatherButton;
-(void)getWeather;

-(IBAction)resetTo12Hour;

-(IBAction)resetAlarmArray;
-(IBAction)checkNightViewDefaults:(id)sender;


@end
