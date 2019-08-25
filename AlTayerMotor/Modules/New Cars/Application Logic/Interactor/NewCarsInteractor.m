//
//  NewCarsInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarsInteractor.h"
#import "NewCarsDataManager.h"
#import "MBrand.h"
#import "Brand.h"

@interface NewCarsInteractor()
@property (nonatomic, strong) NewCarsDataManager *dataManager;
@end

@implementation NewCarsInteractor


- (instancetype)initWithDataManager:(NewCarsDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

#pragma mark - Interactor
- (void)findAllBrands
{
    NSArray * brands = [[self.dataManager findAllBrands] linq_select:^id(Brand *brand) {
        return [[MBrand alloc] initWithId:[brand.id integerValue]
                                 withName:brand.name
                               withNameAR:brand.name_ar
                                 withLogo:brand.logo
                                  withUrl:brand.url
                             withRoadside:brand.roadside];
    }];
    
    [self.output foundAllBrands:brands];
}

@end
