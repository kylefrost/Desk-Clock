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
    
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    
    BOOL enabledSwitchState = [nightViewPreferences boolForKey:@"enabledSwitch"];
    BOOL alwaysOnDaySwitchState = [nightViewPreferences boolForKey:@"alwaysDaySwitch"];
    BOOL alwaysOnSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
    BOOL customTimeSwitchState = [nightViewPreferences boolForKey:@"customTimeSwitch"];
    
    
    if (enabledSwitchState == 1) {                        // Enabled Switch is On
        [self loadAutoOn];
    }
    else if (enabledSwitchState == 0) {                   // Enabled Switch is Off
        [self loadAutoOff];
    }
    
    if (alwaysOnDaySwitchState == 1) {                    // Always Day Switch is On
        [self loadAlwaysDayOn];
    }
    else if (alwaysOnDaySwitchState == 0) {               // Always Day Switch is On
        [self loadAlwaysDayoff];
    }

    if (alwaysOnSwitchState == 1) {                       // Always Night Switch is On
        [self loadAlwaysNightOn];
    }
    else if (alwaysOnSwitchState == 0) {                  // Always Night Switch is Off
        [self loadAlwaysNightOff];
    }

    if (customTimeSwitchState == 1) {                     // Custom Time Switch is On
        [self loadCustomOn];
    }
    else if (customTimeSwitchState == 0) {                // Custom Time Switch is Off
        [self loadCustomOff];
    }
    
    if (enabledSwitchState == 0 && alwaysOnDaySwitchState == 0 && alwaysOnSwitchState == 0) {
        [self loadAutoOn];
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"enabledSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self.tableView reloadData];

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

-(IBAction)toggleEnabledForAlwaysDaySwitch:(id)sender {
    
    if(self.alwaysDaySwitch.on) {
        
        [self alwaysDayOn];
        
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"alwaysDaySwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        [self alwaysDayOff];
        
        [[NSUserDefaults standardUserDefaults] setBool:0 forKey:@"alwaysDaySwitch"];
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
    
    
    [self customTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self customTimeCell].contentView.alpha = 1.0;
    [self.customTimeCell setUserInteractionEnabled:YES];
    
    [self.alwaysDaySwitch setOn:NO animated:YES];
    [self.alwaysNightSwitch setOn:NO animated:YES];
    
    [self toggleEnabledForAlwaysDaySwitch:self];
    [self toggleEnabledForAlwaysNightSwitch:self];
    
}

-(void)autoOff {
    
    [self customTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    [self customTimeCell].contentView.alpha = 0.5;
    [self.customTimeCell setUserInteractionEnabled:NO];
    
    [self.customTimeSwitch setOn:NO animated:YES];
    
}

-(void)alwaysDayOn {
    
    [self.enableDisableSwitch setOn:NO animated:YES];
    [self.alwaysNightSwitch setOn:NO animated:YES];
    
    [self toggleEnabledForEnableSwitch:self];
    [self toggleEnabledForAlwaysNightSwitch:self];
    
}

-(void)alwaysDayOff {
    
    
}

-(void)alwaysNightOn {
    
    [self.enableDisableSwitch setOn:NO animated:YES];
    [self.alwaysDaySwitch setOn:NO animated:YES];
    
    [self toggleEnabledForEnableSwitch:self];
    [self toggleEnabledForAlwaysDaySwitch:self];
    
}

-(void)alwaysNightOff {
    
    
}

-(void)customOn {
    
    [self morningTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self morningTimeCell].contentView.alpha = 1.0;
    [self nightTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self nightTimeCell].contentView.alpha = 1.0;
    
    [self.nightTimeCell setUserInteractionEnabled:YES];
    [self.morningTimeCell setUserInteractionEnabled:YES];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *dayPickerDate = [preferences objectForKey:@"dayTimeFullObject"];
    NSDate *nightPickerDate = [preferences objectForKey:@"nightTimeFullObject"];
    
    if (dayPickerDate != NULL) {
        NSDate *dayTimeFull = [preferences objectForKey:@"dayTimeFullObject"];
        NSString *dayTimeDetailedText = [dateFormat stringFromDate:dayTimeFull];
        self.morningTimeCell.detailTextLabel.text = dayTimeDetailedText;
    }
    else if (dayPickerDate == NULL) {
        self.nightTimeCell.detailTextLabel.text = @"8:00 AM";
    }
    
    if (nightPickerDate != NULL) {
        NSDate *nightTimeFull = [preferences objectForKey:@"nightTimeFullObject"];
        NSString *nightTimeDetailedText = [dateFormat stringFromDate:nightTimeFull];
        self.nightTimeCell.detailTextLabel.text = nightTimeDetailedText;

    }
    else if (nightPickerDate == NULL) {
        self.nightTimeCell.detailTextLabel.text = @"8:00 PM";
    }

}

-(void)customOff {
    
    [self morningTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    [self morningTimeCell].contentView.alpha = 0.5;
    [self nightTimeCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    [self nightTimeCell].contentView.alpha = 0.5;
    
    [self.nightTimeCell setUserInteractionEnabled:NO];
    [self.morningTimeCell setUserInteractionEnabled:NO];
    
    NSDateFormatter *now = [[NSDateFormatter alloc] init];
    [now setDateFormat:@"hh:mm a"];
    NSString *morningDate = @"8:00 AM";
    NSString *nightDate = @"8:00 PM";
    
    self.morningTimeCell.detailTextLabel.text = morningDate;
    self.nightTimeCell.detailTextLabel.text = nightDate;
    
}


/******* BETA STUFF *******/

-(IBAction)pressBetaTest:(id)sender {
    
    NSUserDefaults* enabledSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL enabledSwitchState = [enabledSwitchPreference boolForKey:@"enabledSwitch"];
    
    NSUserDefaults* alwaysOnSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL alwaysOnSwitchState = [alwaysOnSwitchPreference boolForKey:@"alwaysNightSwitch"];
    
    NSUserDefaults* customTimeSwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL customTimeSwitchState = [customTimeSwitchPreference boolForKey:@"customTimeSwitch"];
    
    NSUserDefaults* alwaysDaySwitchPreference = [NSUserDefaults standardUserDefaults];
    BOOL alwaysDaySwitchState = [alwaysDaySwitchPreference boolForKey:@"alwaysDaySwitch"];
    
    NSLog(@"\n\nenabledSwitchState is %d \nalwaysDaySwitchState is %d \nalwaysNightSwitchState is %d \ncustomTimeSwitchState is %d\n\n", enabledSwitchState, alwaysDaySwitchState,  alwaysOnSwitchState, customTimeSwitchState);
    
    NSUserDefaults *nightViewPreferences = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
    [hourFormat setDateFormat:@"HH"];
    
    NSDate *hourDate = [nightViewPreferences objectForKey:@"dayHourObject"];
    NSString *dayHourObject = [hourFormat stringFromDate:hourDate];
    NSDate *hourNightDate = [nightViewPreferences objectForKey:@"nightHourObject"];
    NSString *nightHourObject = [hourFormat stringFromDate:hourNightDate];
    
    NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
    [minuteFormat setDateFormat:@"mm"];
    
    NSDate *minuteDate = [nightViewPreferences objectForKey:@"dayMinuteObject"];
    NSString *dayMinuteObject = [minuteFormat stringFromDate:minuteDate];
    NSDate *minuteNightDate = [nightViewPreferences objectForKey:@"nightMinuteObject"];
    NSString *nightMinuteObject = [minuteFormat stringFromDate:minuteNightDate];
    
    NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
    [ampmFormat setDateFormat:@"a"];
    
    NSDate *dayAMPMDate = [nightViewPreferences objectForKey:@"dayAMPMObject"];
    NSString *dayAMPMObject = [ampmFormat stringFromDate:dayAMPMDate];
    NSDate *nightAMPMDate = [nightViewPreferences objectForKey:@"nightAMPMObject"];
    NSString *nightAMPMObject = [ampmFormat stringFromDate:nightAMPMDate];
    
    NSLog(@"\n\ndayHourObject = %@\ndayMinuteObject = %@\ndayAMPMObject = %@\n\nnightHourObject = %@\nnightMinuteObject = %@\nnightAMPMObject = %@\n\n", dayHourObject, dayMinuteObject, dayAMPMObject, nightHourObject, nightMinuteObject, nightAMPMObject);
    
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******* LOAD FROM NSUSERDEFAULTS *******/

-(void)loadAutoOn {
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    BOOL customTimeSwitchState = [nightViewPreferences boolForKey:@"customTimeSwitch"];
    
    NSLog(@"enabledSwitchState is on");
    
    self.enableDisableSwitch.on = TRUE;
    self.alwaysDaySwitch.on = FALSE;
    self.alwaysNightSwitch.on = FALSE;
    
    if(customTimeSwitchState == 1) {
        [self customOn];
    }
    else if (customTimeSwitchState == 0) {
        [self customOff];
    }
    
}

-(void)loadAutoOff {
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    BOOL alwaysOnSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
    
    NSLog(@"enabledSwitchState is off");
    
    self.enableDisableSwitch.on = FALSE;
    
    
    if (alwaysOnSwitchState == 1) {
        [self autoOff];
        [self customOff];
        [self alwaysNightOn];
        
    }
    else if (alwaysOnSwitchState == 0) {
        [self autoOff];
        [self customOff];
        [self alwaysNightOff];
        
    }
    
}

-(void)loadAlwaysDayOn {
    
    self.alwaysDaySwitch.on = TRUE;
    
}

-(void)loadAlwaysDayoff {
    
    self.alwaysDaySwitch.on = FALSE;
    
}

-(void)loadAlwaysNightOn {
    
    self.alwaysNightSwitch.on = TRUE;
    
}

-(void)loadAlwaysNightOff {
    
    self.alwaysNightSwitch.on = FALSE;
    
}

-(void)loadCustomOn {
    
    self.customTimeSwitch.on = TRUE;
    
}

-(void)loadCustomOff {
    
    self.customTimeSwitch.on = FALSE;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    
    BOOL enabledSwitchState = [nightViewPreferences boolForKey:@"enabledSwitch"];
    BOOL alwaysOnDaySwitchState = [nightViewPreferences boolForKey:@"alwaysDaySwitch"];
    BOOL alwaysOnSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
    
    if (enabledSwitchState == 0 && alwaysOnDaySwitchState == 0 && alwaysOnSwitchState == 0) {
        self.enableDisableSwitch.on = TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:1 forKey:@"enabledSwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"You did not choose one of the three Night Mode options, therefore Automatic Switching with Custom Times turned off has been automatically enabled. If you wish to change this, go to the Night Mode settings and select what you prefer." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    
}

@end
