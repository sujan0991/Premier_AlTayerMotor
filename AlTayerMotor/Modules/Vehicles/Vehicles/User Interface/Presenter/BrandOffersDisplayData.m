//
//  BrandOfferDisplayData.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandOffersDisplayData.h"

@implementation BrandOffersDisplayData

- (instancetype)initWithOffers:(NSArray *)offers
{
    if (self = [super init]) {
        self.offers = offers;
        self.timeStamp = [[NSDate date] timeIntervalSince1970];
    }
    
    return self;
}

- (BOOL)isEqualToBrandOffersDisplayData:(BrandOffersDisplayData *)data
{
    if (!data)
    {
        return NO;
    }
    
    BOOL hasEqualOffers = [self.offers isEqualToArray:data.offers];
    
    return hasEqualOffers;
}


- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[BrandOffersDisplayData class]])
    {
        return NO;
    }
    
    return [self isEqualToBrandOffersDisplayData:object];
}


- (NSUInteger)hash
{
    return [self.offers hash];
}

@end
