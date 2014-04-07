//
//  ACAlarmLabelEditViewController~ipad.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACAlarmLabelEditViewController_ipad;

@protocol ACAlarmLabelEditViewController_ipadDelegate <NSObject>
-(void)updateLabelText:(NSString*)newLabel;
@end

@interface ACAlarmLabelEditViewController_ipad : UIViewController <UITextFieldDelegate> {
    UITextField * labelField;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *labelBar;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString * label;
@property(unsafe_unretained) id <ACAlarmLabelEditViewController_ipadDelegate> delegate;

@end
