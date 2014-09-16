//
//  HLAppDelegate.m
//  HailAppTest
//
//  Created by Zachary BURGESS on 12/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import "HLAppDelegate.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kGOOGLE_API_KEY @"AIzaSyCKJsoCxiCVNKpQRzc1igbv0ngHIoRHoK8"

@implementation HLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self; // send loc updates to myself
    [_locationManager startUpdatingLocation];
    self.restaurants = [[NSArray alloc]init];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{ }

- (void)applicationDidEnterBackground:(UIApplication *)application
{ }

- (void)applicationWillEnterForeground:(UIApplication *)application
{ }

- (void)applicationDidBecomeActive:(UIApplication *)application
{ }

- (void)applicationWillTerminate:(UIApplication *)application
{ }

#pragma mark - google data fetch

-(void) queryGooglePlaces: (NSString *) googleType {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", _locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude, [NSString stringWithFormat:@"%i", 1000], googleType, kGOOGLE_API_KEY];
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    self.restaurants = [json objectForKey:@"results"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"placesHasBeenUpdated" object:nil];
}

#pragma mark - location manager delegation
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (newLocation.coordinate.latitude != oldLocation.coordinate.latitude && newLocation.coordinate.longitude != oldLocation.coordinate.longitude) {
        [self queryGooglePlaces:@"restaurant"];
        
        [_locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}


@end