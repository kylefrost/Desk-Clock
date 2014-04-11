//
//  ACExtrasDetailsViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 4/11/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import "ACExtrasDetailsViewController.h"

@interface ACExtrasDetailsViewController ()
- (void)configureView;
@end

@implementation ACExtrasDetailsViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
