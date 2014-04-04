//
//  ACAppDelegate.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACTutorialViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <UIKit/UIKit.h>

@interface ACAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    
    float brightness;
}

-(void)showTutorial;
-(void)isFirstOpen;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ACTutorialViewController *tutorialViewController;
@property (strong, nonatomic) ACAppDelegate *appViewController;

@property (nonatomic, strong) AVAudioPlayer *player;


@end
