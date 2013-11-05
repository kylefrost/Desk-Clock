//
//  ACInfoViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACInfoViewController~ipad.h"
#import <UIKit/UIAppearance.h>

@interface ACInfoViewController_ipad ()

@end

@implementation ACInfoViewController_ipad
@synthesize alarmSwitch;

/* - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 } */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
	// Do any additional setup after loading the view.
    
    [self nightMode];
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.bar.delegate = self;
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    BOOL alarmState = [preferences boolForKey:@"switchOnOff"];
    
    if (alarmState == 1) {
        [self.alarmPicker setUserInteractionEnabled:YES];
        [self.alarmPicker setAlpha:1.0];
        alarmSwitch.on = TRUE;
    }
    else if (alarmState == 0) {
        [self.alarmPicker setAlpha:0.0];
        [self.alarmPicker setUserInteractionEnabled:NO];
        alarmSwitch.on = FALSE;
    }
    
    // Load alarmPicker
    // NSUserDefaults *alarmTime = [NSUserDefaults standardUserDefaults];
    NSDate *storedAlarmTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"alarmTimeStateStored"];
    [self.alarmPicker setDate:storedAlarmTime];
    
}

- (BOOL)readValue  {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return [preferences boolForKey:@"switchOnOff"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

-(IBAction)pressDone {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self saveAlarm];
}

-(void)nightMode {
    
    // Update night mode
    
    // Find time in 24 hour format
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    NSString *time = [timeFormat stringFromDate:[NSDate date]];
    int timeVal = [time intValue];
    
    // Create NSDictionary of text attributes for Navigation Bar
    NSDictionary *nightAtt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    NSDictionary *dayAtt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    
    // Set night mode or day mode colors
    if (timeVal <= 7) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:nightAtt];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _backgroundView.backgroundColor = [UIColor darkGrayColor];
        _alarmLabel.textColor = [UIColor whiteColor];
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:dayAtt];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _alarmLabel.textColor = [UIColor blackColor];
    }
    else if (timeVal >= 20) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:nightAtt];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _backgroundView.backgroundColor = [UIColor darkGrayColor];
        _alarmLabel.textColor = [UIColor whiteColor];
    }
}

-(IBAction)toggleEnabledForAlarmSwitch:(id)sender {
    
    // Integer 1 = On -- 0 = Off
    if (alarmSwitch.on) {
        
        [self.alarmPicker setUserInteractionEnabled:YES];
        [self.alarmPicker setAlpha:1.0];
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"switchOnOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        
        [self.alarmPicker setAlpha:0.0];
        [self.alarmPicker setUserInteractionEnabled:NO];
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"switchOnOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSUserDefaults* preferences  = [NSUserDefaults standardUserDefaults];
    BOOL alarmState = [preferences boolForKey:@"switchOnOff"];
    
    NSLog(@"BOOL for AlarmState is %d", alarmState);
}

-(void)saveValue  {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:alarmSwitch.on forKey:@"switchOnOff"];
    [preferences synchronize];
}


-(void)saveAlarm {
    
    // Save time of alarm
    NSUserDefaults *alarmStoreTime = [NSUserDefaults standardUserDefaults];
    NSDate *alarmTime = self.alarmPicker.date;
    [alarmStoreTime setObject:alarmTime forKey:@"alarmTimeStateStored"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"\n\nAlarm time saved.");
}


@end
