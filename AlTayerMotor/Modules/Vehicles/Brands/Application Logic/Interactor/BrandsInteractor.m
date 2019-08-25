//
//  BrandsInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsInteractor.h"
#import "BrandsDataManager.h"
#import "MBrand.h"

@interface BrandsInteractor()
@property (nonatomic, strong) BrandsDataManager *dataManager;
@end

@implementation BrandsInteractor

- (instancetype)initWithDataManager:(BrandsDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

- (void)findUserInfo
{
    MUser *user = [self.dataManager findUserInfo];
    [self.output foundUserInfo:user];
}

#pragma mark - First Time Interactor
- (void)findAllBrands
{
    NSArray *brands = [self.dataManager findAllBrands];
    [self.output foundAllBrands:brands];
}

@end
