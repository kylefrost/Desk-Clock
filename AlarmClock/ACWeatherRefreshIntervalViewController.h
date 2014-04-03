//
//  ACWeatherRefreshIntervalViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/2/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACWeatherRefreshIntervalViewController : UITableViewController {
    NSIndexPath* checkedIndexPath;
}

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@property (strong, nonatomic) IBOutlet UITableViewCell *fifteen;
@property (strong, nonatomic) IBOutlet UITableViewCell *thirty;
@property (strong, nonatomic) IBOutlet UITableViewCell *hour;
@property (strong, nonatomic) IBOutlet UITableViewCell *twoHours;
@property (strong, nonatomic) IBOutlet UITableViewCell *fiveHours;

@end
