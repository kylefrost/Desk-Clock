//
//  ACAddEditAlarmViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/14/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

// AddEditAlarmViewController Equivalent

#import <UIKit/UIKit.h>

#import "ACAlarmLabelEditViewController.h"

@interface ACAddEditAlarmViewController : UIViewController <ACAlarmLabelEditViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *addBar;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *timeToSetOff;
@property (nonatomic, assign) NSInteger indexOfAlarmToEdit;
@property(atomic,strong) NSString *label;
@property(nonatomic,assign) BOOL editMode;
@property(nonatomic,assign) int notificationID;

@end
