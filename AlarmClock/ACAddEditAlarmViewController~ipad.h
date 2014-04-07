//
//  ACAddEditAlarmViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ACAlarmLabelEditViewController~ipad.h"

@interface ACAddEditAlarmViewController_ipad : UIViewController <ACAlarmLabelEditViewController_ipadDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *addBar;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *timeToSetOff;
@property (nonatomic, assign) NSInteger indexOfAlarmToEdit;
@property(atomic,strong) NSString *label;
@property(nonatomic,assign) BOOL editMode;
@property(nonatomic,assign) int notificationID;

@end
