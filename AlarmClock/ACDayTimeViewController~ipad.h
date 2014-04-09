//
//  ACDayTimeViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACDayTimeViewController_ipad : UITableViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *dayTimePicker;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

-(IBAction)timePickerDidChange:(id)sender;

-(void)showWarning;

@end
