//
//  ACAddEditAlarmViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACAddEditAlarmViewController~ipad.h"
#import "ACAlarmViewController~ipad.h"
#import "ACAlarmObject~ipad.h"

@interface ACAddEditAlarmViewController_ipad ()

@end

@implementation ACAddEditAlarmViewController_ipad

@synthesize tableView;
@synthesize timeToSetOff;
@synthesize label;
@synthesize notificationID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addBar.delegate = self;
    // Do any additional setup after loading the view.
    
    if (self.editMode) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
        NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
        ACAlarmObject_ipad * oldAlarmObject = [alarmList objectAtIndex:self.indexOfAlarmToEdit];
        self.label = oldAlarmObject.label;
        timeToSetOff.date = oldAlarmObject.timeToSetOff;
        self.notificationID = oldAlarmObject.notificationID;
        
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.editMode) {
        return 2;
    }
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if(indexPath.section == 0) {
        
        // Set up the cell...
        UILabel *labelTextField = [[UILabel alloc] initWithFrame:CGRectMake(180, 4, 500, 35)];
        labelTextField.adjustsFontSizeToFitWidth = YES;
        labelTextField.textColor = [UIColor grayColor];
        labelTextField.backgroundColor = [UIColor clearColor];
        [labelTextField setEnabled: YES];
        
        if(indexPath.row == 0) {
            
            cell.textLabel.text = @"Alarm Name";
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            labelTextField.text = self.label;
            labelTextField.font = [UIFont systemFontOfSize:20];
            
            UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
            
            NSData *themeTintData = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeTintColor"];
            UIColor *themeTint = [NSKeyedUnarchiver unarchiveObjectWithData:themeTintData];
            
            myBackView.backgroundColor = themeTint;
            cell.selectedBackgroundView = myBackView;
        }
        
        
        [cell.contentView addSubview:labelTextField];
    }
    
    if(indexPath.section == 1) {
        
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f];;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"Delete Alarm";
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        
        UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
        myBackView.backgroundColor = [UIColor colorWithRed:255/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        cell.selectedBackgroundView = myBackView;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main~ipad" bundle:nil];
            
            ACAlarmLabelEditViewController_ipad *labelEditController = [mystoryboard instantiateViewControllerWithIdentifier:@"LabelEditView"];
            
            labelEditController.delegate = self;
            labelEditController.label = label;
            [self presentViewController:labelEditController animated:YES completion:nil];
        }
    }
    else if(indexPath.section == 1) {
        
        if(indexPath.row == 0) {
            
            UIAlertView *deleteAlarmAlert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                                       message:@"Are you sure you want to delete this alarm?"
                                                                      delegate:self
                                                             cancelButtonTitle:@"Yes"
                                                             otherButtonTitles:@"No", nil];
            [deleteAlarmAlert show];
        }
    }
}

- (void)CancelExistingNotification {
    
    //cancel alarm
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++) {
        
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"notificationID"]];
        if ([uid isEqualToString:[NSString stringWithFormat:@"%i",self.notificationID]]) {
            
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        //cancel alarm
        [self CancelExistingNotification];
        //delete alarm
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
        NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
        [alarmList removeObjectAtIndex: self.indexOfAlarmToEdit];
        NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
        [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
        
        [self dismissViewControllerAnimated:YES completion:nil];  // Dismiss Modal View Controller
    }
    else {
        // Nothing...
    }
}

-(IBAction)saveAlarm:(id)sender {
    
    ACAlarmObject_ipad * newAlarmObject;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *alarmListData = [defaults objectForKey:@"AlarmListData"];
    NSMutableArray *alarmList = [NSKeyedUnarchiver unarchiveObjectWithData:alarmListData];
    
    if(!alarmList) {
        
        alarmList = [[NSMutableArray alloc]init];
    }
    
    if(self.editMode) { // Already Exists
        
        newAlarmObject = [alarmList objectAtIndex:self.indexOfAlarmToEdit];
        
        [self CancelExistingNotification];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
    }
    else { // Adding New
        
        newAlarmObject = [[ACAlarmObject_ipad alloc]init];
        newAlarmObject.enabled = YES;
        newAlarmObject.notificationID = [self getUniqueNotificationID];
    }
    
    newAlarmObject.label = self.label;
    newAlarmObject.timeToSetOff = timeToSetOff.date;
    newAlarmObject.enabled = YES;
    
    [self scheduleLocalNotificationWithDate:self.timeToSetOff.date atIndex:newAlarmObject.notificationID];
    
    if(self.editMode == NO) {
        
        [alarmList addObject:newAlarmObject];
        
    }
    
    NSData *alarmListData2 = [NSKeyedArchiver archivedDataWithRootObject:alarmList];
    [[NSUserDefaults standardUserDefaults] setObject:alarmListData2 forKey:@"AlarmListData"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
    
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss Modal View Controller
    
}

- (void)scheduleLocalNotificationWithDate:(NSDate *)fireDate atIndex:(int)indexOfObject {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    if (!localNotification) {
        return;
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh-mm -a";
    NSDate* date = [dateFormatter dateFromString:[dateFormatter stringFromDate:timeToSetOff.date]];
    
    localNotification.repeatInterval = NSDayCalendarUnit;
    [localNotification setFireDate:date];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    // Setup alert notification
    [localNotification setAlertBody:@"Your alarm is sounding!"];
    [localNotification setAlertAction:@"Open App"];
    [localNotification setSoundName:@"Alarm.mp3"];
    [localNotification setHasAction:YES];
    
    NSLog(@"%@", date);
    //This array maps the alarms uid to the index of the alarm so that we can cancel specific local notifications
    
    NSNumber* uidToStore = [NSNumber numberWithInt:indexOfObject];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:uidToStore forKey:@"notificationID"];
    localNotification.userInfo = userInfo;
    NSLog(@"Uid Store in userInfo %@", [localNotification.userInfo objectForKey:@"notificationID"]);
    
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

-(int)getUniqueNotificationID {
    
    NSMutableDictionary * hashDict = [[NSMutableDictionary alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    for (int i=0; i<[eventArray count]; i++) {
        
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSNumber *uid= [userInfoCurrent valueForKey:@"notificationID"];
        NSNumber * value =[NSNumber numberWithInt:1];
        [hashDict setObject:value forKey:uid];
    }
    for (int i=0; i<[eventArray count]+1; i++) {
        
        NSNumber * value = [hashDict objectForKey:[NSNumber numberWithInt:i]];
        
        if(!value) {
            
            return i;
        }
    }
    return 0;
    
}

- (void)updateLabelText:(NSString *)newLabel {
    
    self.label = newLabel;
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
}

-(IBAction)pressCancel {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlarmListData" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAlarmTable" object:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
