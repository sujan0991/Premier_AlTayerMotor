//
//  LatestOffersPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOffersPresenter.h"
#import "LatestOffersViewInterface.h"

@implementation LatestOffersPresenter

- (void)presentBrandsInterface
{
    [self.wireframe presentBrandsInterfaceInNavigation:self.userInterface.navigationController];
}

- (void)presentOffersInterfaceWithData:(NSArray *)offers
                       withViewedIndex:(NSInteger)index
{
    [self.wireframe presentPeekOffersInterfaceWithData:offers
                                       withViewedIndex:index
                                          inNavigation:self.userInterface.navigationController];
}

- (void)getLatestOffers {
    [self.interactor getLatestOffers];
}

- (void)didGetOffers:(NSArray *)offers
{
    [self.userInterface setLatestOffers:offers];
}

- (void)didGetOffersError:(NSError *)error
{
    [self.userInterface setLatestOffers:nil];
}

@end
