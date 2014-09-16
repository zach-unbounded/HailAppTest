//
//  HLMapPoint.m
//  HailAppTest
//
//  Created by Zachary BURGESS on 13/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import "HLMapPoint.h"

@implementation HLMapPoint

-(id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        
    }
    return self;
}

+ (HLMapPoint*)HLMapPointWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate
{
    return [[HLMapPoint alloc] initWithName:name address:address coordinate:coordinate];
}

-(NSString *)title
{
    if ([self.name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return self.name;
}

-(NSString *)subtitle
{
    return self.address;
}

@end