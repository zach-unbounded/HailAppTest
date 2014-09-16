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

static NSString * const HLMapViewTitle = @"Restaurant Map";


static NSString * const HLGoogleLocationServiceGeometryKey = @"geometry";
static NSString * const HLGoogleLocationServiceLocationKey = @"location";
static NSString * const HLGoogleLocationServiceNameKey = @"name";
static NSString * const HLGoogleLocationServiceVicinityKey = @"vicinity";
static NSString * const HLGoogleLocationServiceLatitudeKey = @"lat";
static NSString * const HLGoogleLocationServiceLongitudeKey = @"lng";

static CLLocationDistance const HLLatitudeSpan = 10000.0f;
static CLLocationDistance const HLLongitudeSpan = 10000.0f;

@interface HLMapViewController ()

@property (assign,nonatomic) HLAppDelegate* delegate;

@end

@implementation HLMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = (HLAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                            target:self
                                                                            action:@selector(refreshRequest)];
    self.navigationItem.rightBarButtonItem = button;
    self.title = HLMapViewTitle;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    [self plotPositions:self.delegate.restaurants];
}

-(void)viewDidAppear:(BOOL)animated {
    self.delegate.locationManager.delegate = self;
}
-(void)viewDidDisappear:(BOOL)animated {
    self.delegate.locationManager.delegate = self.delegate;
}

-(void)refreshRequest
{
    [self.delegate.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate methods.

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(self.delegate.locationManager.location.coordinate,
                                                HLLatitudeSpan,
                                                HLLongitudeSpan);
    [mv setRegion:region animated:YES];
}

-(void)plotPositions:(NSArray *)data
{
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[HLMapPoint class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    for (NSDictionary* place in data) {
        NSDictionary *geo = [place objectForKey:HLGoogleLocationServiceGeometryKey];
        NSDictionary *loc = [geo objectForKey:HLGoogleLocationServiceLocationKey];
        NSString *name=[place objectForKey:HLGoogleLocationServiceNameKey];
        NSString *vicinity=[place objectForKey:HLGoogleLocationServiceVicinityKey];
        CLLocationCoordinate2D placeCoord;
        placeCoord.latitude=[[loc objectForKey:HLGoogleLocationServiceLatitudeKey] doubleValue];
        placeCoord.longitude=[[loc objectForKey:HLGoogleLocationServiceLongitudeKey] doubleValue];
        HLMapPoint *placeObject = [HLMapPoint HLMapPointWithName:name
                                                         address:vicinity
                                                      coordinate:placeCoord];
        [self.mapView addAnnotation:placeObject];
    }
}

@end
