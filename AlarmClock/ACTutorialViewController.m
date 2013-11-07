//
//  ACTutorialViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 10/30/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACTutorialViewController.h"
#import "ACAppDelegate.h"

@interface ACTutorialViewController ()

@end

@implementation ACTutorialViewController

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
    // Do any additional setup after loading the view from its nib.
    self.screenNumber.text = [NSString stringWithFormat:@"Screen #%ld", (long)self.index];
}

-(IBAction)closeTutorial {
    [self dismissViewControllerAnimated:YES completion:NULL];
    // [self.mainView removeFromSuperview];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TutorialState" ofType:@"plist"];
    NSMutableDictionary *betaDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    BOOL buildBOOL = [[betaDictionary objectForKey:@"hasSeenTutorial"] boolValue];
    
    NSLog(@"buildBOOL is %hhd", buildBOOL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
