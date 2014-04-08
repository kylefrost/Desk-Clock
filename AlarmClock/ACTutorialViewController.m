//
//  ACTutorialViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/8/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACTutorialViewController.h"

@interface ACTutorialViewController ()

@end

@implementation ACTutorialViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
}

-(IBAction)pressDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
