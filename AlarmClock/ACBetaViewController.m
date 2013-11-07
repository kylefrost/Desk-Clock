//
//  ACBetaViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/6/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACBetaViewController.h"
#import "TestFlight.h"
#import <Crashlytics/Crashlytics.h>

@interface ACBetaViewController ()

@end

@implementation ACBetaViewController
@synthesize crashButton;

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.bar.delegate = self;
    
    [TestFlight passCheckpoint:@"Beta Settings Page Opened."];
}

-(void)viewDidAppear:(BOOL)animated {
    UIAlertView *betaView = [[UIAlertView alloc] initWithTitle:@"Proceed with caution."
                                                       message:@"You are now entering the beta settings. Don't report any bugs experienced while in this page.\n\nIf you do, I will find you, and I will...show you how to properly report bugs.\n\nI went there." delegate:self cancelButtonTitle:@"I can handle this." otherButtonTitles:@"Get me out of here!", nil];
    [betaView show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // User Pressed Proceed
    if (buttonIndex == 0) {
        nil;
        NSLog(@"Pressed Proceed");
        [TestFlight passCheckpoint:@"Beta Settings Accessed."];
    }
    
    //User Pressed Leave
    else if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        [TestFlight passCheckpoint:@"Beta Settings Canceled."];
    }
}

-(IBAction)resetTutorial {
    
    UIAlertView *tutAlert = [[UIAlertView alloc] initWithTitle:@"TutorialView" message:@"ACTutorialViewController NSUserDefault has been reset to NO." delegate:self cancelButtonTitle:@"K Thanks" otherButtonTitles:nil];
    [tutAlert show];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"firstLoad"];
    [defaults synchronize];
    [TestFlight passCheckpoint:@"Tutorial Default Reset to NO."];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

-(IBAction)pressCrashButton {
    [TestFlight passCheckpoint:@"Crash Button Pressed"];
    [[Crashlytics sharedInstance] crash];
}

-(IBAction)closeBetaSettings {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
