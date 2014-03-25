//
//  ACNightTimeViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/20/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACNightTimeViewController.h"

@interface ACNightTimeViewController ()

@end

@implementation ACNightTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.nightTimePicker setDatePickerMode:UIDatePickerModeTime];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDate *pickerDate = [preferences objectForKey:@"nightTimeFullObject"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *setPickerDate = pickerDate;
    
    if (pickerDate == NULL) {
        NSLog(@"pickerDate is NULL");
        self.nightTimePicker.date = [dateFormat dateFromString:@"8:00 PM"];
        self.timeLabel.text = @"8:00 PM";
    }
    else if (pickerDate != NULL) {
        self.nightTimePicker.date = setPickerDate;
        self.timeLabel.text = [dateFormat stringFromDate:setPickerDate];
    }
    // Do any additional setup after loading the view.
}

-(IBAction)timePickerDidChange:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *pickerDate = self.nightTimePicker.date;
    
    self.timeLabel.text = [dateFormat stringFromDate:pickerDate];
    
    NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
    [hourFormat setDateFormat:@"h"];
    
    NSDate *hourDate = self.nightTimePicker.date;
    
    NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
    [minuteFormat setDateFormat:@"mm"];
    
    NSDate *minuteDate = self.nightTimePicker.date;
    
    NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
    [ampmFormat setDateFormat:@"a"];
    
    NSDate *nightAMPMDate = self.nightTimePicker.date;
    
    NSUserDefaults *storePreferences = [NSUserDefaults standardUserDefaults];
    [storePreferences setObject:pickerDate forKey:@"nightTimeFullObject"];
    [storePreferences setObject:hourDate forKey:@"nightHourObject"];
    [storePreferences setObject:minuteDate forKey:@"nightMinuteObject"];
    [storePreferences setObject:nightAMPMDate forKey:@"nightAMPMObject"];
    [storePreferences synchronize];
    
    NSString *nightAMPMString = [ampmFormat stringFromDate:nightAMPMDate];
    
    if ([nightAMPMString isEqual:@"AM"]) {
        [self showWarning];
    }
}

-(void)showWarning {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Night should start during a PM time, and you have set it to AM." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
    
    NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
    [ampmFormat setDateFormat:@"a"];
    
    NSDate *nightAMPMDate = self.nightTimePicker.date;
    
    nightAMPMDate = [ampmFormat dateFromString:@"PM"];
    self.nightTimePicker.date = nightAMPMDate;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *pickerDate = self.nightTimePicker.date;
    
    self.timeLabel.text = [dateFormat stringFromDate:pickerDate];
    
    NSUserDefaults *storePreferences = [NSUserDefaults standardUserDefaults];
    [storePreferences setObject:pickerDate forKey:@"nightTimeFullObject"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
