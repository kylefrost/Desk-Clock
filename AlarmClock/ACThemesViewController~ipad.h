//
//  ACThemesViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACThemesViewController_ipad : UITableViewController {
    NSIndexPath* checkedIndexPath;
}

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@property (strong, nonatomic) IBOutlet UITableViewCell *deskClock;
@property (strong, nonatomic) IBOutlet UITableViewCell *goldIsBest;
@property (strong, nonatomic) IBOutlet UITableViewCell *classic;

@end
