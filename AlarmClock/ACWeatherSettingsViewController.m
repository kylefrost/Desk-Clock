//
//  ACWeatherSettingsViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/1/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACWeatherSettingsViewController.h"

@interface ACWeatherSettingsViewController ()

@end

@implementation ACWeatherSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customLocationField.delegate = self;
    self.customLocationCell.textLabel.text = @"Location";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL currentLocation = [defaults boolForKey:@"currentLocationSwitch"];
    BOOL celsius = [defaults boolForKey:@"celsiusSwitch"];
    
    if (currentLocation == 1) {
        self.currentLocationSwitch.on = YES;
        [self customLocationCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [self customLocationCell].contentView.alpha = 0.5;
        [self.customLocationCell setUserInteractionEnabled:NO];
        self.customLocationField.placeholder = @"Disable Current Location";
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.customLocationField.text = [defaults objectForKey:@"customLocationField"];
    }
    else if (currentLocation == 0) {
        self.currentLocationSwitch.on = NO;
        [self customLocationCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self customLocationCell].contentView.alpha = 1.0;
        [self.customLocationCell setUserInteractionEnabled:YES];
        self.customLocationField.placeholder = @"Type custom location...";
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.customLocationField.text = [defaults objectForKey:@"customLocationField"];
    }
    
    if (celsius == 1) {
        self.celsiusSwitch.on = YES;
    }
    else if (celsius == 0) {
        self.celsiusSwitch.on = NO;
    }
    
    NSInteger indexPath = [defaults integerForKey:@"refreshSetting"];
    
    if (indexPath == 0) {
        self.refreshRateCell.detailTextLabel.text = @"15 minutes";
    }
    else if (indexPath == 1) {
        self.refreshRateCell.detailTextLabel.text = @"30 minutes";
    }
    else if (indexPath == 2) {
        self.refreshRateCell.detailTextLabel.text = @"1 hour";
    }
    else if (indexPath == 3) {
        self.refreshRateCell.detailTextLabel.text = @"2 hours";
    }
    else if (indexPath == 4) {
        self.refreshRateCell.detailTextLabel.text = @"5 hours";
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

-(void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexPath = [defaults integerForKey:@"refreshSetting"];
    
    if (indexPath == 0) {
        self.refreshRateCell.detailTextLabel.text = @"15 minutes";
    }
    else if (indexPath == 1) {
        self.refreshRateCell.detailTextLabel.text = @"30 minutes";
    }
    else if (indexPath == 2) {
        self.refreshRateCell.detailTextLabel.text = @"1 hour";
    }
    else if (indexPath == 3) {
        self.refreshRateCell.detailTextLabel.text = @"2 hours";
    }
    else if (indexPath == 4) {
        self.refreshRateCell.detailTextLabel.text = @"5 hours";
    }
}

-(IBAction)toggleEnabledForCurrentLocationSwitch:(id)sender {
    
    if (self.currentLocationSwitch.on) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:1 forKey:@"currentLocationSwitch"];
        [defaults synchronize];
        
        [self customLocationCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [self customLocationCell].contentView.alpha = 0.5;
        [self.customLocationCell setUserInteractionEnabled:NO];
        self.customLocationField.placeholder = @"Disable Current Location";
    }
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:0 forKey:@"currentLocationSwitch"];
        [defaults synchronize];
        
        [self customLocationCell].backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self customLocationCell].contentView.alpha = 1.0;
        [self.customLocationCell setUserInteractionEnabled:YES];
        self.customLocationField.placeholder = @"Type custom location...";
        
        self.customLocationField.text = [defaults objectForKey:@"customLocationField"];
    }
}

-(IBAction)toggleEnabledForCelsiusSwitch:(id)sender {
    
    if (self.celsiusSwitch.on) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:1 forKey:@"celsiusSwitch"];
        [defaults synchronize];
    }
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:0 forKey:@"celsiusSwitch"];
        [defaults synchronize];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.customLocationField.text forKey:@"customLocationField"];
    [defaults synchronize];
    NSLog(@"customLocationFieldText saved as %@", self.customLocationField.text);
    
    [aTextField resignFirstResponder];
    return NO;
}

-(void)viewDidDisappear:(BOOL)animated {
    
    if ([self.customLocationField.text isEqual:@""]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:1 forKey:@"currentLocationSwitch"];
        [defaults synchronize];
    }
    else {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.customLocationField.text forKey:@"customLocationField"];
        [defaults synchronize];
        NSLog(@"customLocationFieldText saved as %@", self.customLocationField.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
