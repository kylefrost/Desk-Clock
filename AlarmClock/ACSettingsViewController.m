//
//  ACSettingsViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 3/15/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACSettingsViewController.h"
#import <objc/message.h>
#import <MessageUI/MFMailComposeViewController.h>
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

-(void)viewWillAppear:(BOOL)animated {
    // objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
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
            UIActionSheet *likeActionSheet = [[UIActionSheet alloc] initWithTitle:@"We're glad you like it, but we can do better." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email Us", @"Share on Twitter", @"Share on Facebook", nil];
            [likeActionSheet setTag:3];
            [likeActionSheet showInView:self.view];
            
        }
        else if (buttonIndex == 2) {
            // It could be better.
            UIActionSheet *betterActionSheet = [[UIActionSheet alloc] initWithTitle:@"We really want to do better. What can you suggest?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email Us", @"Tweet Support", @"Visit Our Site", nil];
            [betterActionSheet setTag:4];
            [betterActionSheet showInView:self.view];
        }
        else if (buttonIndex == 3) {
            // I hate it.
            UIActionSheet *hateActionSheet = [[UIActionSheet alloc] initWithTitle:@"We're sorry to hear that. Let us know what we can do better." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Tell Us Why", @"Request Refund", nil];
            [hateActionSheet setTag:5];
            [hateActionSheet showInView:self.view];
        }
    }
    
    // I love it!
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
    
    // I like it.
    else if ([actionSheet tag] == 3) {
        
        if (buttonIndex == 0) {
            NSString *messageBody = [NSString stringWithFormat:@"\n\n%@, %@", [UIDevice currentDevice].model, [UIDevice currentDevice].systemVersion];
            
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setSubject:@"Desk Clock Feedback"];
            [controller setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"support@kylefrostdesign.com"], nil]];
            [controller setMessageBody:messageBody isHTML:NO];
            if (controller) [self presentViewController:controller animated:YES completion:nil];
        }
        else if (buttonIndex == 1) {
            
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"I'm loving @DeskClockApp! Check it out! #deskclockapp"];
            
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else if (buttonIndex == 2) {
            
            SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [shareSheet setInitialText:@"I'm loving Desk Clock App! Check it out! #deskclockapp"];
            
            [self presentViewController:shareSheet animated:YES completion:nil];
        }
    }
    
    // It could be better.
    else if ([actionSheet tag] == 4) {
        
        if (buttonIndex == 0) {
            NSString *messageBody = [NSString stringWithFormat:@"\n\n%@, %@", [UIDevice currentDevice].model, [UIDevice currentDevice].systemVersion];
            
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setSubject:@"Desk Clock Feedback"];
            [controller setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"support@kylefrostdesign.com"], nil]];
            [controller setMessageBody:messageBody isHTML:NO];
            if (controller) [self presentViewController:controller animated:YES completion:nil];
        }
        else if (buttonIndex == 1) {
            
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"@DeskClockApp"];
            
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else if (buttonIndex == 2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.kylefrostdesign.com"]];
        }
    }
    
    // I hate it.
    else if ([actionSheet tag] == 5) {
        
        if (buttonIndex == 0) {
            NSString *messageBody = [NSString stringWithFormat:@"\n\n%@, %@", [UIDevice currentDevice].model, [UIDevice currentDevice].systemVersion];
            
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setSubject:@"I don't like Desk Clock"];
            [controller setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"support@kylefrostdesign.com"], nil]];
            [controller setMessageBody:messageBody isHTML:NO];
            if (controller) [self presentViewController:controller animated:YES completion:nil];
        }
        else if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://reportaproblem.apple.com"]];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
