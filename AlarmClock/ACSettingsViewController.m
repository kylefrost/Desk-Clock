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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"How are you liking Desk Clock?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"I love it!", @"I like it.", @"It could be better.", @"I hate it.", nil];
    
    [actionSheet setTag:1];
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([actionSheet tag] == 1) {
        if (buttonIndex == 0) {
            // I love it!
            UIActionSheet *loveActionSheet = [[UIActionSheet alloc] initWithTitle:@"We're glad to hear that!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share to Twitter", @"Share to Facebook", @"Rate on App Store", nil];
            [loveActionSheet setTag:2];
            [loveActionSheet showInView:self.view];
        }
        else if (buttonIndex == 1) {
            // I like it. I love it. I want some more of it.
            // I mean, just "I like it."
            
        }
        else if (buttonIndex == 2) {
            // It could be better.
            
        }
        else if (buttonIndex == 3) {
            // I hate it.
            
        }
    }
    
    else if ([actionSheet tag] == 2) {
        
        if (buttonIndex == 0) {
            
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"I'm loving @DeskClockApp! Check it out! #deskclockapp"];
            
            [self presentViewController:tweetSheet animated:YES completion:nil];
            
            
        }
        else if (buttonIndex == 1) {
            
            SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [shareSheet setInitialText:@"I'm loving Desk Clock App! Check it out! #deskclockapp"];
            
            [self presentViewController:shareSheet animated:YES completion:nil];
            
        }
        else if (buttonIndex == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.com/apps/deskclock"]];
        }
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
