//
//  ACBetaViewController~ipad.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/6/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACBetaViewController~ipad.h"

@interface ACBetaViewController_ipad ()

@end

@implementation ACBetaViewController_ipad

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIAlertView *betaView = [[UIAlertView alloc] initWithTitle:@"Beta Settings"
                                                       message:@"Proceed with caution. You are now entering the beta settings. Don't report any bugs experienced while in this page." delegate:self cancelButtonTitle:@"Proceed" otherButtonTitles:@"Leave", nil];
    [betaView show];
}

-(IBAction)closeBetaSettings {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
