//
//  ACAlarmViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAlarmViewController_ipad : UIViewController {
    
    UITableView *tableView;
    NSString *alarmBody;
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listOfAlarms;

- (void)reloadAlarmList:(NSNotification *)notif;
-(void)checkRes:(NSNotification *)notification;

@end
