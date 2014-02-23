//
//  ACAppDelegate.m
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACAppDelegate.h"
#import "MKiCloudSync.h"
#import "TestFlight.h"
#import "ACTutorialViewController.h"
#import "ACViewController.h"
#import <Crashlytics/Crashlytics.h>

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 3rd Party Tracking Tools
    [Crashlytics startWithAPIKey:@"e6796ec21a8268eef118ce2bffeb5fd9a084bcb1"];
    [TestFlight takeOff:@"d9f92e3b-23a4-4db3-a9a7-afb748461408"];
    
    // Start NSUserDefaults iCloud Sync
    [MKiCloudSync start];
    
    // [self isFirstOpen];
    
    // Override point for customization after application launch.
    return YES;
    
}

-(void)isFirstOpen {

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"notFirstRun"];
    if (![defaults boolForKey:@"notFirstRun"]) {
        [self showTutorial];
        [defaults setBool:YES forKey:@"notFirstRun"];
        [defaults synchronize];
    }
    else {
        nil;
    }
}

-(void)showTutorial {
    
    // ACTutorialViewController *view = [[ACTutorialViewController alloc] initWithNibName:@"ACTutorialViewController" bundle:nil];
    
    // UIAlertView *tutView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Test Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // [tutView show];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
