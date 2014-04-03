//
//  ACWeatherRefreshIntervalViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/2/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACWeatherRefreshIntervalViewController.h"

@interface ACWeatherRefreshIntervalViewController ()

@end

@implementation ACWeatherRefreshIntervalViewController

@synthesize checkedIndexPath;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexPath = [defaults integerForKey:@"refreshSetting"];
    
    if (indexPath == 0) {
        self.fifteen.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 1) {
        self.thirty.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 2) {
        self.hour.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 3) {
        self.twoHours.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 4) {
        self.fiveHours.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if([self.checkedIndexPath isEqual:indexPath]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Uncheck the previous checked row
    if(self.checkedIndexPath) {
        
        UITableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    
    NSInteger indexPathInt = indexPath.row;
    
    // 15 min
    if (indexPathInt == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:900.0 forKey:@"refreshTime"];
        [defaults setInteger:0 forKey:@"refreshSetting"];
    }
    // 30 min
    else if (indexPathInt == 1) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:1800.0 forKey:@"refreshTime"];
        [defaults setInteger:1 forKey:@"refreshSetting"];
    }
    // 1 hour
    else if (indexPathInt == 2) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:3600.0 forKey:@"refreshTime"];
        [defaults setInteger:2 forKey:@"refreshSetting"];
    }
    // 2 hours
    else if (indexPathInt == 3) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:7200.0 forKey:@"refreshTime"];
        [defaults setInteger:3 forKey:@"refreshSetting"];
    }
    // 5 hours
    else if (indexPathInt == 4) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:180000.0 forKey:@"refreshTime"];
        [defaults setInteger:4 forKey:@"refreshSetting"];
    }
}

-(void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
