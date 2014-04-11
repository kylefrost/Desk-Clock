//
//  ACThemesViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACThemesViewController~ipad.h"
#import "UIColor+Custom.h"

@interface ACThemesViewController_ipad ()

@end

@implementation ACThemesViewController_ipad

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
        self.warm.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 3) {
        self.cool.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 4) {
        self.spring.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath == 5) {
        self.mono.accessoryType = UITableViewCellAccessoryCheckmark;
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
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmDayTextColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmDayBackgroundColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmDayOffColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmNightTextColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmNightBackgroundColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmNightOffColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customWarmTintColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:2 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Cool
    else if (indexPathInt == 3) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolDayTextColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolDayBackgroundColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolDayOffColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolNightTextColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolNightBackgroundColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolNightOffColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customCoolTintColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:3 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Spring
    else if (indexPathInt == 4) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringDayTextColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringDayBackgroundColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringDayOffColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringNightTextColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringNightBackgroundColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringNightOffColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customSpringTintColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:4 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    // Monochrome
    else if (indexPathInt == 5) {
        NSData *dayTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoDayTextColor]];
        NSData *dayBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoDayBackgroundColor]];
        NSData *dayLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoDayOffColor]];
        NSData *nightTextColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoNightTextColor]];
        NSData *nightBackgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoNightBackgroundColor]];
        NSData *nightLabelOffColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoNightOffColor]];
        
        NSString *themeFont = @"Digital-7 Mono";
        NSData *themeTintColorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor customMonoTintColor]];
        
        NSUserDefaults *themeDefaults = [NSUserDefaults standardUserDefaults];
        [themeDefaults setObject:dayTextColorData forKey:@"dayTextColor"];
        [themeDefaults setObject:dayBackgroundColorData forKey:@"dayBackgroundColor"];
        [themeDefaults setObject:dayLabelOffColorData forKey:@"dayLabelOffColor"];
        [themeDefaults setObject:nightTextColorData forKey:@"nightTextColor"];
        [themeDefaults setObject:nightBackgroundColorData forKey:@"nightBackgroundColor"];
        [themeDefaults setObject:nightLabelOffColorData forKey:@"nightLabelOffColor"];
        [themeDefaults setObject:themeFont forKey:@"themeFont"];
        [themeDefaults setObject:themeTintColorData forKey:@"themeTintColor"];
        
        [themeDefaults setInteger:5 forKey:@"themeSetting"];
        
        [themeDefaults synchronize];
    }
    
    if (indexPathInt != 0) {
        self.deskClock.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 1) {
        self.goldIsBest.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 2) {
        self.warm.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 3) {
        self.cool.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 4) {
        self.spring.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPathInt != 5) {
        self.mono.accessoryType = UITableViewCellAccessoryNone;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
