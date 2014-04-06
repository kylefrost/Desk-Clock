//
//  ACThemesViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/4/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACThemesViewController.h"
#import "UIColor+Custom.h"

@interface ACThemesViewController ()

@end

@implementation ACThemesViewController

@synthesize checkedIndexPath;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexPath = [defaults integerForKey:@"themeSetting"];
    
    if (indexPath == 0) {
        self.deskClock.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 1) {
        self.goldIsBest.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 2) {
        self.classic.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 3) {
        
    }
    else if (indexPath == 4) {
        
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
    
    // Desk Clock
    if (indexPathInt == 0) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customLightGrayColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkRedColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:0 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Gold Is Best
    else if (indexPathInt == 1) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customGoldColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customLightGrayColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customGoldColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:1 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Warm
    else if (indexPathInt == 2) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWhiteColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customGoldColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customLightGrayColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customGoldColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customBlackColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customDarkGrayColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:1 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Cool
    else if (indexPathInt == 3) {

    }
    // Spring
    else if (indexPathInt == 4) {

    }
    // Monochrome
    else if (indexPathInt == 5) {
        
    }
    
    if (indexPathInt != 0) {
        self.deskClock.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 1) {
        self.goldIsBest.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 2) {
        self.classic.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 3) {
        
    }
    if (indexPathInt != 4) {
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
