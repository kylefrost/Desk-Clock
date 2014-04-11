//
//  ACNightTimeViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/20/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACNightTimeViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *nightTimePicker;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

-(IBAction)timePickerDidChange:(id)sender;

-(void)showWarning;

@end
