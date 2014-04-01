//
//  ACWeatherSettingsViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/1/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACWeatherSettingsViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *customLocationField;

@end
