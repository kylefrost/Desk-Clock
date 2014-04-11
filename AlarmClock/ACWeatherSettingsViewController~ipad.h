//
//  ACWeatherSettingsViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACWeatherSettingsViewController_ipad : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *customLocationField;
@property (strong, nonatomic) IBOutlet UISwitch *currentLocationSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *celsiusSwitch;

@property (weak, nonatomic) IBOutlet UITableViewCell *refreshRateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *customLocationCell;

-(IBAction)toggleEnabledForCurrentLocationSwitch:(id)sender;
-(IBAction)toggleEnabledForCelsiusSwitch:(id)sender;

@end
