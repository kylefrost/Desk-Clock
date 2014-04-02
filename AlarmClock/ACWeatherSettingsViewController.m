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
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
    [aTextField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
