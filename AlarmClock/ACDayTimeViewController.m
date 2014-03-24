//
//  ACDayTimeViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/20/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACDayTimeViewController.h"

@interface ACDayTimeViewController ()

@end

@implementation ACDayTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.dayTimePicker setDatePickerMode:UIDatePickerModeTime];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDate *pickerDate = [preferences objectForKey:@"dayTimeFullObject"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *setPickerDate = pickerDate;
    
    if (pickerDate == NULL) {
        NSLog(@"pickerDate is NULL");
        self.dayTimePicker.date = [dateFormat dateFromString:@"8:00 AM"];
        self.timeLabel.text = @"8:00 AM";
    }
    else if (pickerDate != NULL) {
        self.dayTimePicker.date = setPickerDate;
        self.timeLabel.text = [dateFormat stringFromDate:setPickerDate];
    }
    // Do any additional setup after loading the view.
}

-(IBAction)timePickerDidChange:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *pickerDate = self.dayTimePicker.date;
    
    self.timeLabel.text = [dateFormat stringFromDate:pickerDate];
    
    NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
    [hourFormat setDateFormat:@"h"];
    
    NSDate *hourDate = self.dayTimePicker.date;
    
    NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
    [minuteFormat setDateFormat:@"mm"];
    
    NSDate *minuteDate = self.dayTimePicker.date;
    
    NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
    [ampmFormat setDateFormat:@"a"];
    
    NSDate *dayAMPMDate = self.dayTimePicker.date;
    
    NSUserDefaults *storePreferences = [NSUserDefaults standardUserDefaults];
    [storePreferences setObject:pickerDate forKey:@"dayTimeFullObject"];
    [storePreferences setObject:hourDate forKey:@"dayHourObject"];
    [storePreferences setObject:minuteDate forKey:@"dayMinuteObject"];
    [storePreferences setObject:dayAMPMDate forKey:@"dayAMPMObject"];
    [storePreferences synchronize];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
