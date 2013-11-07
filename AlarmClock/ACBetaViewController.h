//
//  ACBetaViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 11/6/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACBetaViewController : UIViewController {

    
}

@property (weak, nonatomic) IBOutlet UINavigationBar *bar;
@property(nonatomic,readonly) UIBarPosition barPosition;
@property (weak, nonatomic) IBOutlet UIButton *crashButton;

-(IBAction)closeBetaSettings;

// Beta Settings

-(IBAction)pressCrashButton;

@end
