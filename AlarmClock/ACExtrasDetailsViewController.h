//
//  ACExtrasDetailsViewController.h
//  AlarmClock
//
//  Created by Kyle Frost on 4/11/14.
//  Copyright (c) 2014 Kyle Frost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACExtrasDetailsViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
