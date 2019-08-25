//
//  OffersInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersInteractor.h"
#import "OffersDataManager.h"
#import "OffersNetwork.h"
#import "MResponse.h"
#import "MOffer.h"

@interface OffersInteractor()
@property (nonatomic, strong) OffersDataManager *dataManager;
@property (nonatomic, strong) OffersNetwork *network;
@end

@implementation OffersInteractor

- (instancetype)initWithDataManager:(OffersDataManager *)dataManager andNetwork:(OffersNetwork *)network
{
    if (self = [super init]) {
        self.dataManager = dataManager;
        self.network = network;
    }
    
    return self;
}

- (void)getOffers
{
    [self.network getOffers];
}

- (void)getOffersSettings
{
    NSArray *settings = [self.dataManager getOffersSettings];
    [self.output didGetOffersSettings:settings];
}

- (void)didGetOffers:(MResponse *)response;
{
    NSArray *offers = ((MPayloadOffersList *)response.payload).offers;
    [offers enumerateObjectsUsingBlock:^(MOffer *offer, NSUInteger idx, BOOL * _Nonnull stop) {
        offer.brand = [_dataManager getBrandById:offer.brandId];
        if (offer.brand) {
            [offer.brand setOfferCategory:offer.category];
        }
    }];
    
    [self.output didGetOffers:offers];
}

- (void)didGetError:(NSError *)error
{
    [self.output didGetError:error];
}

@end
