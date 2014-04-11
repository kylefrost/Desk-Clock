//
//  ACThemesViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/4/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACThemesViewController : UITableViewController {
    NSIndexPath* checkedIndexPath;
}

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@property (strong, nonatomic) IBOutlet UITableViewCell *deskClock;
@property (strong, nonatomic) IBOutlet UITableViewCell *goldIsBest;
@property (strong, nonatomic) IBOutlet UITableViewCell *warm;
@property (strong, nonatomic) IBOutlet UITableViewCell *cool;
@property (strong, nonatomic) IBOutlet UITableViewCell *spring;
@property (strong, nonatomic) IBOutlet UITableViewCell *mono;

@end
