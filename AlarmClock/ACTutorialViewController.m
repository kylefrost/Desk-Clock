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
@synthesize scrollView, pageControl;
@synthesize viewOne, viewTwo, viewThree;

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
    NSLog(@"Tutorial loaded.");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // self.screenNumber.text = [NSString stringWithFormat:@"Screen #%ld", (long)self.index];
 
    // Scroll View stuff
    UIView *tempView = self.viewOne;
    NSArray *views = [NSArray arrayWithObjects:tempView, [viewTwo viewWithTag:2], [viewThree viewWithTag:3], nil];
    for (int i = 0; i < views.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        // UIView *subview = [[UIView alloc] initWithFrame:frame];
        // subview = [views objectAtIndex:i];
        // subview.backgroundColor = [colors objectAtIndex:i];
        // [self.scrollView addSubview:subview];
        if (i == 0) {
            [self.scrollView addSubview:viewOne];
        }
        else if (i == 1) {
            [self.scrollView addSubview:viewTwo];
        }
        else if (i == 2) {
            [self.scrollView addSubview:viewThree];
        }
    }
 
    
    pageControlBeingUsed = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * views.count, self.scrollView.frame.size.height);
}

-(void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
}

-(IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlBeingUsed = YES;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}


-(IBAction)closeTutorial {
    [self dismissViewControllerAnimated:YES completion:NULL];
    // [self.mainView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end