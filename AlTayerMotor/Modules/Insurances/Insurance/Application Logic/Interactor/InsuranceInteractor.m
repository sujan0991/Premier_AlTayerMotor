//
//  InsuranceInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceInteractor.h"
#import "InsuranceDataManager.h"
#import "InsuranceNetwork.h"
#import "MResponse.h"
#import "MDrivingExperience.h"

@interface InsuranceInteractor()
@property (strong, nonatomic) InsuranceNetwork *apiNetwork;
@property (strong, nonatomic) InsuranceDataManager *dataManager;
@end

@implementation InsuranceInteractor

-(instancetype)initWithDataManager:(InsuranceDataManager *)dataManager
                        andNetwork:(InsuranceNetwork *)network
{
    if (self = [super init]) {
        self.apiNetwork = network;
        self.dataManager = dataManager;
    }
    
    return self;
}


#pragma mark - Interactor
- (void)findUserInfo
{
    MUser *user = [self.dataManager findUserInfo];
    [self.output foundUserInfo:user];
}

- (void)findCities
{
    NSArray *cities = [self.dataManager findCities];
    [self.output foundCities:cities];
}

- (void)findDrivingExperiences
{
    NSArray *drivingExperiences = [[self.dataManager findDrivingExperiences] linq_select:^id(id item) {
        return [[MDrivingExperience alloc] initWithDatabaseObject:item];
    }];
    
    [self.output foundDrivingExperiences:drivingExperiences];
}

- (void)postInsuranceRequest:(MInsuranceRequest *)request
{
    [self.apiNetwork postInsuranceRequest:request];
}

#pragma mark - network
- (void)networkError:(NSError *)error
{
    [self.output postInsuranceRequestFailed];
}

- (void)networkDidLoad:(MResponse *)response inRequest:(MInsuranceRequest *)request
{
    MPayloadResult *payload = (MPayloadResult *)response.payload;
    if (payload && payload.success) {
        [self.output postInsuranceRequestSuccessWithRequest:request];
    } else {
        [self.output postInsuranceRequestFailed];
    }
    
}

@end
