//
//  HLMapViewController.m
//  HailAppTest
//
//  Created by Zachary BURGESS on 13/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import "HLMapViewController.h"
#import "HLMapPoint.h"
#import "HLAppDelegate.h"

@interface HLMapViewController ()

@property (strong,nonatomic) CLLocationManager * locationManager;

@end

@implementation HLMapViewController

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
	// Do any additional setup after loading the view.
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshRequest)];
    self.navigationItem.rightBarButtonItem = button;
    self.title = @"Restaurant Map";
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;

    [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
    
    HLAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [self plotPositions:delegate.restaurants];

}

-(void)refreshRequest
{
    HLAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate methods.
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(_locationManager.location.coordinate,10000,10000);
    
    
    [mv setRegion:region animated:YES];
}


-(void)plotPositions:(NSArray *)data {
    // 1 - Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[HLMapPoint class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    // 2 - Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++) {
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        // 3 - There is a specific NSDictionary object that gives us the location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        // Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        // 4 - Get your name and address info for adding to a pin.
        NSString *name=[place objectForKey:@"name"];
        NSString *vicinity=[place objectForKey:@"vicinity"];
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        // 5 - Create a new annotation.
        HLMapPoint *placeObject = [[HLMapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        [self.mapView addAnnotation:placeObject];
    }
}
@end
