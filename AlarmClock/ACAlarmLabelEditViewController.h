//
//  ACAlarmLabelEditViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 3/14/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

// AlarmLabelEditViewController Equivalent

#import <UIKit/UIKit.h>

@class ACAlarmLabelEditViewController;

@protocol ACAlarmLabelEditViewControllerDelegate <NSObject>
-(void)updateLabelText:(NSString*)newLabel;
@end

@interface ACAlarmLabelEditViewController : UIViewController <UITextFieldDelegate> {
    UITextField * labelField;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *labelBar;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString * label;
@property(unsafe_unretained) id <ACAlarmLabelEditViewControllerDelegate> delegate;

@end
