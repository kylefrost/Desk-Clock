//
//  ACBetaViewController.m
//  AlarmClock
//
//  Created by Kyle Frost on 11/6/13.
//  Copyright (c) 2013 Kyle Frost. All rights reserved.
//

#import "ACBetaViewController.h"
#import "TestFlight.h"
#import <Crashlytics/Crashlytics.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>
#import "OWMWeatherAPI.h"

@interface ACBetaViewController ()

@end

@implementation ACBetaViewController {
    CLLocationManager *_locationManager;
    CLLocationManager *weatherLocationManager;
    int downloadCount;
}

@synthesize crashButton;

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


-(CLLocationCoordinate2D)getLocation {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    self.bar.delegate = self;
    
    [TestFlight passCheckpoint:@"Beta Settings Page Opened."];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    weatherLocationManager = [[CLLocationManager alloc] init];
    
    
    [self getWeather];
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        NSString *tempString = [NSString stringWithFormat:@"%.1f℃", [result[@"main"][@"temp"] floatValue]];
        NSLog(@"tempString is %@", tempString);
        
    }];
}

-(void) currentWeatherByCoordinate:(CLLocationCoordinate2D)coordinate withCallback:(void(^)(NSError* error, NSDictionary *result))callback {
    
    
    
}

// Beta settings for weather information

-(IBAction)getWeatherButton {
    
    // [self getWeather];
    
    weatherLocationManager.delegate = self;
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [weatherLocationManager startUpdatingLocation];

    CLLocationCoordinate2D coordinate = [self getLocation];
    NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    downloadCount = 0;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"82195186406a95aa715896dcc20e054f"];
    [weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    
    [weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        downloadCount++;
        
        int tempString = [result[@"main"][@"temp"] floatValue];
        NSString *weatherDescription = result[@"weather"][0][@"description"];
        NSLog(@"tempString is %d and weatherDescription = %@", tempString, weatherDescription);
        
        self.temp.text = [NSString stringWithFormat:@"%dº", tempString];
        self.weather.text = [[NSString stringWithFormat:@"%@", weatherDescription] uppercaseString];
    }];
    [self.activityIndicator performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)weatherLocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)weatherLocationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"\n\nLONG is %@\n\nLAT is %@\n\n", longitude, latitude);
    }
}

-(void)getWeather {
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    // NSLog(@"Lat is: %f, and Long is: %f", coordinate.latitude, coordinate.longitude);
    
    NSString *apiURLString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.1/find/city?lat=%f&lon=%f&cnt=1", coordinate.latitude, coordinate.longitude];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiURLString]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSHTTPURLResponse *httpResponse = nil;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            httpResponse = (NSHTTPURLResponse *) response;
        
    }
        
        // NSURLConnection's completionHandler is called on the background thread.
        // Prepare a block to show an alert on the main thread:
        __block NSString *message = @"";
        void (^showAlert)(void) = ^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }];
        };
        
        // Check for error or non-OK statusCode:
        if (error || httpResponse.statusCode != 200) {
            message = @"Error fetching weather";
            showAlert();
            return;
        }
    
    NSError *jsonError = nil;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        @try {
            if (jsonError == nil && root) {
                // TODO: type checking / validation, this is really dangerous...
                NSDictionary *firstListItem = [root[@"list"] objectAtIndex:0];
                NSDictionary *main = firstListItem[@"main"];
                
                // Get the temperature:
                NSNumber *temperatureNumber = main[@"temp"]; // in degrees Kelvin
                int temperature = [temperatureNumber integerValue] - 273.15;
                int ftemp = (((temperature*9)/5)+32);
                
                // NSLog(@"ftemp: %d", ftemp);
            
                // NSString *curTemp = [NSString stringWithFormat:@"%dº", ftemp];
                // NSLog(@"curTemp: %@", curTemp);
                currentTemp = [NSString stringWithFormat:@"%dº", ftemp];
                _temp.text = [NSString stringWithFormat:@"%@", currentTemp];
                
                NSUserDefaults *theTemp = [NSUserDefaults standardUserDefaults];
                [theTemp setObject:currentTemp forKey:@"temp"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                return;
            }
        }
        @catch (NSException *exception) {
        }
        message = @"Error parsing response";
        showAlert();
    }];

}

-(int)getTemp {
    
    return 1;
}

-(void)showLocation {
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    UIAlertView *betaView = [[UIAlertView alloc] initWithTitle:@"Proceed with caution."
                                                       message:@"You are now entering the beta settings. Don't report any bugs experienced while in this page.\n\nIf you do, I will find you, and I will...show you how to properly report bugs.\n\nI went there." delegate:self cancelButtonTitle:@"I can handle this." otherButtonTitles:@"Get me out of here!", nil];
    [betaView show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // User Pressed Proceed
    if (buttonIndex == 0) {
        nil;
        NSLog(@"Pressed Proceed");
        [TestFlight passCheckpoint:@"Beta Settings Accessed."];
    }
    
    //User Pressed Leave
    else if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        [TestFlight passCheckpoint:@"Beta Settings Canceled."];
    }
}

-(IBAction)resetTutorial {
    
    UIAlertView *tutAlert = [[UIAlertView alloc] initWithTitle:@"TutorialView" message:@"ACTutorialViewController NSUserDefault has been reset to NO." delegate:self cancelButtonTitle:@"K Thanks" otherButtonTitles:nil];
    [tutAlert show];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"firstLoad"];
    [defaults synchronize];
    [TestFlight passCheckpoint:@"Tutorial Default Reset to NO."];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

-(IBAction)pressCrashButton {
    [TestFlight passCheckpoint:@"Crash Button Pressed"];
    // [[Crashlytics sharedInstance] crash];
}

-(IBAction)sendReport:(id)sender {
    
    // Email Subject
    NSString *emailTitle = @"Desk Clock Beta: Bug Report/Feature Request";
    // Email Content
    NSString *messageBody = @"List feedback or feature requests below.";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"8e41b0c0f5e1ab257f20c959c8873563_ijkustcefu3tmnzxguztm@n.testflightapp.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    // mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)closeBetaSettings {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)resetAlarmArray {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    NSMutableArray *newEventArray;
    
    eventArray = newEventArray;
    
    [newEventArray removeAllObjects];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

-(IBAction)checkNightViewDefaults:(id)sender {
    
    NSUserDefaults* nightViewPreferences = [NSUserDefaults standardUserDefaults];
    
    BOOL enabledSwitchState = [nightViewPreferences boolForKey:@"enabledSwitch"];
    BOOL alwaysOnDaySwitchState = [nightViewPreferences boolForKey:@"alwaysDaySwitch"];
    BOOL alwaysOnSwitchState = [nightViewPreferences boolForKey:@"alwaysNightSwitch"];
    BOOL customTimeSwitchState = [nightViewPreferences boolForKey:@"customTimeSwitch"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSDate *dayTimeFull = [nightViewPreferences objectForKey:@"dayTimeFullObject"];
    NSString *dayTimeDetailedText = [dateFormat stringFromDate:dayTimeFull];
    NSDate *nightTimeFull = [nightViewPreferences objectForKey:@"nightTimeFullObject"];
    NSString *nightTimeDetailedText = [dateFormat stringFromDate:nightTimeFull];
    
    NSLog(@"\n\nenabledSwitchState is %d\nalwaysOnDaySwitchState is %d\nalwaysOnNightSwitchState is %d\ncustomTimeSwitchState is %d\ndayTimeFullObject is %@\nnightTimeFullObject is %@\n\n", enabledSwitchState, alwaysOnDaySwitchState, alwaysOnSwitchState, customTimeSwitchState, dayTimeDetailedText, nightTimeDetailedText);
    
    
    NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
    [hourFormat setDateFormat:@"h"];
    
    NSDate *hourDate = [nightViewPreferences objectForKey:@"dayHourObject"];
    NSString *dayHourObject = [hourFormat stringFromDate:hourDate];
    NSDate *hourNightDate = [nightViewPreferences objectForKey:@"nightHourObject"];
    NSString *nightHourObject = [hourFormat stringFromDate:hourNightDate];
    
    NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
    [minuteFormat setDateFormat:@"mm"];
    
    NSDate *minuteDate = [nightViewPreferences objectForKey:@"dayMinuteObject"];
    NSString *dayMinuteObject = [minuteFormat stringFromDate:minuteDate];
    NSDate *minuteNightDate = [nightViewPreferences objectForKey:@"nightMinuteObject"];
    NSString *nightMinuteObject = [minuteFormat stringFromDate:minuteNightDate];
    
    NSDateFormatter *ampmFormat = [[NSDateFormatter alloc] init];
    [ampmFormat setDateFormat:@"a"];
    
    NSDate *dayAMPMDate = [nightViewPreferences objectForKey:@"dayAMPMObject"];
    NSString *dayAMPMObject = [ampmFormat stringFromDate:dayAMPMDate];
    NSDate *nightAMPMDate = [nightViewPreferences objectForKey:@"nightAMPMObject"];
    NSString *nightAMPMObject = [ampmFormat stringFromDate:nightAMPMDate];
    
    NSLog(@"\n\ndayHourObject = %@\ndayMinuteObject = %@\ndayAMPMObject = %@\n\nnightHourObject = %@\nnightMinuteObject = %@\nnightAMPMObject = %@\n\n", dayHourObject, dayMinuteObject, dayAMPMObject, nightHourObject, nightMinuteObject, nightAMPMObject);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
