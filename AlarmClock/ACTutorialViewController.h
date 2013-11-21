//
//  ACTutorialViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 10/30/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTutorialViewController : UIViewController {
    
    UIScrollView *scrollView;
    UIPageControl* pageControl;
    UIView *viewOne;
    UIView *viewTwo;
    UIView *viewThree;
    
    BOOL pageControlBeingUsed;
}

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *screenNumber;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (strong, nonatomic) IBOutlet UIView *viewOne;
@property (strong, nonatomic) IBOutlet UIView *viewTwo;
@property (strong, nonatomic) IBOutlet UIView *viewThree;

-(IBAction)closeTutorial;
-(IBAction)changePage;

@end
