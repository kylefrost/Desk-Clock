//
//  ACNightViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/12/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACNightViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableViewCell *enabledDisableCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *customTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *alwaysDayCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *alwaysNightCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *morningTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nightTimeCell;

@property (strong, nonatomic) IBOutlet UISwitch *enableDisableSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *alwaysDaySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *alwaysNightSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *customTimeSwitch;

-(IBAction)toggleEnabledForEnableSwitch:(id)sender;
-(IBAction)toggleEnabledForAlwaysNightSwitch:(id)sender;
-(IBAction)toggleEnabledForAlwaysDaySwitch:(id)sender;
-(IBAction)toggleEnabledForCustomTimeSwitch:(id)sender;

-(void)autoOn;
-(void)autoOff;
-(void)customOn;
-(void)customOff;
-(void)alwaysDayOn;
-(void)alwaysDayOff;
-(void)alwaysNightOn;
-(void)alwaysNightOff;

-(void)loadAutoOn;
-(void)loadAutoOff;
-(void)loadCustomOn;
-(void)loadCustomOff;
-(void)loadAlwaysDayOn;
-(void)loadAlwaysDayoff;
-(void)loadAlwaysNightOn;
-(void)loadAlwaysNightOff;

-(void)determineBuild;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *betaButton;
-(IBAction)pressBetaTest:(id)sender;


@end