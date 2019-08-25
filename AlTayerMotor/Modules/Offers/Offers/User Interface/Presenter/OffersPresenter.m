//
//  OffersPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersPresenter.h"
#import "OffersWireframe.h"

@interface OffersPresenter()
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation OffersPresenter

- (void)getOffers
{
    _isLoading = YES;
    [self.interactor getOffers];
}

- (BOOL)isGettingOffers
{
    return _isLoading;
}

- (void)presentFilterInterfaceWithData:(OffersFilterDisplayData *)data
{
    [self.wireframe presentOffersFilterWithData:data
                                   inNavigation:self.userInterface.navigationController];
}

- (void)getOffersSettings
{
    [self.interactor getOffersSettings];
}

- (void)presentOffersInterfaceWithData:(NSArray *)offers
                       withViewedIndex:(NSInteger)index
{
    [self.wireframe presentPeekOffersInterfaceWithData:offers
                                       withViewedIndex:index
                                          inNavigation:self.userInterface.navigationController];
}

#pragma mark - Database
- (void)didGetOffersSettings:(NSArray *)settings
{
    [self.userInterface updateSettings:settings];
}

#pragma mark - Network
- (void)didGetOffers:(NSArray *)offers
{
    _isLoading = NO;
    [self.userInterface updateOffers:offers];
}

- (void)didGetError:(NSError *)error
{
    _isLoading = NO;
    [self.userInterface updateOffers:nil];
}

@end
