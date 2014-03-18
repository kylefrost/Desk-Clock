//
//  ACNightViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/12/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACNightViewController.h"

@interface ACNightViewController ()

@end

@implementation ACNightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

}

-(IBAction)toggleEnabledForEnableSwitch:(id)sender {
    
    if(self.enableDisableSwitch.on) {
        
        [self autoOn];
        [self toggleEnabledForCustomTimeSwitch:self];
        
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"enabledSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    } else {
        
        [self autoOff];
        [self toggleEnabledForCustomTimeSwitch:self];
        
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"enabledSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}

-(IBAction)toggleEnabledForAlwaysNightSwitch:(id)sender {
    
    if(self.alwaysNightSwitch.on) {
        
        [self alwaysNightOn];
        
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"alwaysNightSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        [self alwaysNightOff];
        
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"alwaysNightSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}

-(IBAction)toggleEnabledForCustomTimeSwitch:(id)sender {
    
    if(self.customTimeSwitch.on) {
        
        [self customOn];
        
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"customTimeSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        [self customOff];
        
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"customTimeSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}

-(void)autoOn {
  
    [self.customTimeCell setUserInteractionEnabled:YES];
    [self.customTimeCell setAlpha:1.0];
    
}

-(void)autoOff {
    
    [self.customTimeCell setUserInteractionEnabled:NO];
    [self.customTimeCell setAlpha:0.5];

    [self.customTimeSwitch setOn:NO animated:YES];
    
}

-(void)customOn {
    
    [self.morningTimeCell setUserInteractionEnabled:YES];
    [self.morningTimeCell setAlpha:1.0];
    
    [self.nightTimeCell setUserInteractionEnabled:YES];
    [self.nightTimeCell setAlpha:1.0];
    
}

-(void)customOff {
    
    [self.morningTimeCell setUserInteractionEnabled:NO];
    [self.morningTimeCell setAlpha:0.5];
    
    [self.nightTimeCell setUserInteractionEnabled:NO];
    [self.nightTimeCell setAlpha:0.5];
    
    NSDateFormatter *now = [[NSDateFormatter alloc] init];
    [now setDateFormat:@"hh:mm a"];
    NSString *morningDate = @"8:00 AM";
    NSString *nightDate = @"8:00 PM";
    
    self.morningTimeCell.detailTextLabel.text = morningDate;
    self.nightTimeCell.detailTextLabel.text = nightDate;
    
}

-(void)alwaysNightOn {
    
    [self.enabledDisableCell setUserInteractionEnabled:NO];
    [self.enabledDisableCell setAlpha:0.5];
    
    [self.enableDisableSwitch setOn:NO animated:YES];
    [self toggleEnabledForEnableSwitch:self];
    
}

-(void)alwaysNightOff {
    
    [self.enabledDisableCell setUserInteractionEnabled:YES];
    [self.enabledDisableCell setAlpha:1.0];
    
    
}

-(IBAction)pressBetaTest:(id)sender {
    
    NSUserDefaults* enabledSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL enabledSwitchState = [enabledSwitchPreference boolForKey:@"enabledSwitch"];
    
    NSUserDefaults* alwaysOnSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL alwaysOnSwitchState = [alwaysOnSwitchPreference boolForKey:@"alwaysNightSwitch"];
    
    NSUserDefaults* customTimeSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL customTimeSwitchState = [customTimeSwitchPreference boolForKey:@"customTimeSwitch"];
    
    NSLog(@"\n\nenabledSwitchState is %d \nalwaysOnSwitchState is %d \ncustomTimeSwitchState is %d", enabledSwitchState, alwaysOnSwitchState, customTimeSwitchState);
    
}

-(void)determineBuild {
    
    // Determine if build is beta or not
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BetaSettings" ofType:@"plist"];
    NSDictionary* betaDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    BOOL buildBOOL = [[betaDictionary objectForKey:@"isBetaBuildRelease"] boolValue];
    
    // If beta, show button, if not, don't show button
    if (buildBOOL == 1) {
        [self.betaButton setEnabled:YES];
        //[self.betaButton setUserInteractionEnabled:YES];
        NSLog(@"Build is a beta build.");
    }
    else if (buildBOOL == 0) {
        [self.betaButton setEnabled:NO];
        //[self.betaButton setUserInteractionEnabled:NO];
        NSLog(@"Build is NOT a beta build.");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end
