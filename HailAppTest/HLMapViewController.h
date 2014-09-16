//
//  HLMapViewController.h
//  HailAppTest
//
//  Created by Zachary BURGESS on 13/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

/** */
@interface HLMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

/** */
@property (strong,nonatomic) IBOutlet MKMapView * mapView;

@end
