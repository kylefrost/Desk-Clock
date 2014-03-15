//
//  ACAlarmViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/14/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

// AlarmListTableController Equivalent

#import <UIKit/UIKit.h>

@interface ACAlarmViewController : UIViewController {
    
    UITableView *tableView;
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listOfAlarms;

- (void)reloadAlarmList:(NSNotification *)notif;
-(void)checkRes:(NSNotification *)notification;

@end
