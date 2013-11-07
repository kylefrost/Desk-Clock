//
//  ACTutorialViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/30/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTutorialViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *screenNumber;
@property (strong, nonatomic) IBOutlet UIView *mainView;

-(IBAction)closeTutorial;

@end
