//
//  ACInfoViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/1/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACInfoViewController~ipad.h"

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
    }
    else if (timeVal <= 19 && timeVal >= 8) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:dayAtt];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    else if (timeVal >= 20) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:nightAtt];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _backgroundView.backgroundColor = [UIColor darkGrayColor];
    }
}

-(IBAction)toggleEnabledForAlarmSwitch:(id)sender {
    
    // Integer 1 = On -- 0 = Off
    if (alarmSwitch.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setBool:self.alarmSwitch.on forKey:@"switch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
