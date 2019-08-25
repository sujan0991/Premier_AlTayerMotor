//
//  LatestOffersInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOffersInteractor.h"
#import "LatestOffersNetwork.h"
#import "MResponse.h"

@interface LatestOffersInteractor()
@property (strong, nonatomic) LatestOffersNetwork *apiNetwork;
@end

@implementation LatestOffersInteractor

- (instancetype)initWithNetwork:(LatestOffersNetwork *)apiNetwork
{
    if (self = [super init]) {
        _apiNetwork = apiNetwork;
    }
    
    return self;
}

- (void)getLatestOffers
{
    [_apiNetwork getLatestOffers];
}

#pragma mark - Network
- (void)didGetLatestOffers:(MResponse *)resposne
{
    NSArray *offers = ((MPayloadOffersList *)resposne.payload).offers;
    [self.output didGetOffers:offers];
}

- (void)didGetError:(NSError *)error
{
    [self.output didGetOffersError:error];
}

@end
