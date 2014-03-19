//
//  ACSettingsViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACSettingsViewController.h"
#import <Social/Social.h>

@interface ACSettingsViewController ()

@end

@implementation ACSettingsViewController

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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)pressShare:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Enjoying Desk Clock? Share it with friends!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", @"Facebook", nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I'm loving @DeskClockApp! Check it out! #deskclockapp"];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
        // NSLog(@"Twitter Pressed");
        
    }
    else if (buttonIndex == 1) {
        
        SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [shareSheet setInitialText:@"I'm loving Desk Clock App! Check it out! #deskclockapp"];
        
        [self presentViewController:shareSheet animated:YES completion:nil];
        
        // NSLog(@"Facebook Pressed");
        
    }
    
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
