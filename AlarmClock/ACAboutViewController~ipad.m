//
//  ACAboutViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACAboutViewController~ipad.h"

@interface ACAboutViewController_ipad ()

@end

@implementation ACAboutViewController_ipad

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
    
    NSData *themeTintData = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeTintColor"];
    UIColor *themeTint = [NSKeyedUnarchiver unarchiveObjectWithData:themeTintData];
    
    self.deskClockTwitterCell.textLabel.textColor = themeTint;
    self.kyleFrostTwitterCell.textLabel.textColor = themeTint;
    self.laurenWhiteTwitterCell.textLabel.textColor = themeTint;
    self.adamOramTwitterCell.textLabel.textColor = themeTint;
    self.griffinKoupalTwitterCell.textLabel.textColor = themeTint;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Select a specific row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Determine what Twitter apps are installed
    BOOL tweetbotInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]];
    BOOL twitterInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]];
    BOOL twitterrificInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]];
    
    // Decide what URL Scheme to follow when @twitter names are selected in
    
    // Open Tweetbot
    if (tweetbotInstalled) {
        
        if ([indexPath isEqual:[tableView indexPathForCell:self.kyleFrostTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/_kylefrost"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.laurenWhiteTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/lauren_alexis"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.adamOramTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/adamoram"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.griffinKoupalTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/griffkoupal"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.deskClockTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/deskclockapp"]];
        }
    }
    
    // Open Twitterrific
    else if (twitterrificInstalled) {
        
        if ([indexPath isEqual:[tableView indexPathForCell:self.kyleFrostTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=_kylefrost"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.laurenWhiteTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=lauren_alexis"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.adamOramTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=adamoram"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.griffinKoupalTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=griffkoupal"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.deskClockTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=deskclockapp"]];
        }
    }
    
    // Open Twitter app
    else if (twitterInstalled) {
        
        if ([indexPath isEqual:[tableView indexPathForCell:self.kyleFrostTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=_kylefrost"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.laurenWhiteTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=lauren_alexis"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.adamOramTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=adamoram"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.griffinKoupalTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=griffkoupal"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.deskClockTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=deskclockapp"]];
        }
    }
    
    // Open in Safari
    else {
        
        if ([indexPath isEqual:[tableView indexPathForCell:self.kyleFrostTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/_kylefrost"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.laurenWhiteTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/lauren_alexis"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.adamOramTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/adamoram"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.griffinKoupalTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/griffkoupal"]];
        }
        if ([indexPath isEqual:[tableView indexPathForCell:self.deskClockTwitterCell]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/deskclockapp"]];
        }
    }
}

@end
