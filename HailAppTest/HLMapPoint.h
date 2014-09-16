//
//  HLMapPoint.h
//  HailAppTest
//
//  Created by Zachary BURGESS on 13/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/** Hail Test App Map Point */
@interface HLMapPoint : NSObject <MKAnnotation>

/** Map point's name*/
@property (copy, nonatomic) NSString *name;
/** Map point's address*/
@property (copy, nonatomic) NSString *address;
/** Map point's location*/
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;

/** custom init
 @param name name of point on the mapp
 @param address formatted address as string to display
 @param coordinate CLLocationCoordinate2D representing the location of the point on the map
 */
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

/** custom factory method
 @param name name of point on the mapp
 @param address formatted address as string to display
 @param coordinate CLLocationCoordinate2D representing the location of the point on the map
 @return HLMapPoint setup with custom values*/
+ (HLMapPoint*)HLMapPointWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end