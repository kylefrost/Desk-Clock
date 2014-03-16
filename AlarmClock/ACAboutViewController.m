//
//  ACAboutViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACAboutViewController.h"

@interface ACAboutViewController ()

@end

@implementation ACAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL tweetbotInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]];
    BOOL twitterInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]];
    BOOL twitterrificInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]];
    
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
