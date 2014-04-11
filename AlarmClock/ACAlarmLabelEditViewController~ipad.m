//
//  ACAlarmLabelEditViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/6/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACAlarmLabelEditViewController~ipad.h"

@interface ACAlarmLabelEditViewController_ipad ()

@end

@implementation ACAlarmLabelEditViewController_ipad

@synthesize delegate;
@synthesize label;

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
    self.labelBar.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    // some over view controller could have changed our nav bar tint color, so reset it here
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([indexPath section] == 0) {
            UITextField *labelTextField = [[UITextField alloc] initWithFrame:CGRectMake(8, 4, 280, 35)];
            labelField = labelTextField;
            labelTextField.adjustsFontSizeToFitWidth = YES;
            labelTextField.textColor = [UIColor blackColor];
            labelTextField.backgroundColor = [UIColor clearColor];
            labelTextField.text = label;
            labelTextField.returnKeyType = UIReturnKeyDone;
            labelTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            labelTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            labelTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            labelTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            labelTextField.keyboardType = UIKeyboardTypeDefault;
            [labelTextField becomeFirstResponder];
            labelTextField.tag = 0;
            labelTextField.delegate = self;
            labelTextField.font = [UIFont systemFontOfSize:20];
            labelTextField.clearButtonMode = UITextFieldViewModeAlways;
            [labelTextField setEnabled: YES];
            [cell.contentView addSubview:labelTextField];
            
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath: indexPath];
    UITextField *textField = [[cellSelected.contentView subviews] objectAtIndex: 0];
    [textField becomeFirstResponder];
    
    [tableView deselectRowAtIndexPath: indexPath animated: NO];
}

-(IBAction)saveAlarmLabel:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(updateLabelText:)]) {
        
        [self.delegate updateLabelText:labelField.text];
    }
    
    [self.delegate updateLabelText:labelField.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self saveAlarmLabel:nil];
    return YES;
}

-(IBAction)pressCancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
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
