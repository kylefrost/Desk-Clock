//
//  ACInfoViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 10/28/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACInfoViewController.h"

@interface ACInfoViewController ()

@end

@implementation ACInfoViewController

/* - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
} */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressDone {
    [self dismissViewControllerAnimated:YES completion:NULL];
    // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

@end
