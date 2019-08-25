//
//  RoadsideInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsideInteractor.h"
#import "RoadsideDataManager.h"
#import "MBrand.h"
#import "Brand.h"

@interface RoadsideInteractor()
@property (nonatomic, strong) RoadsideDataManager *dataManager;
@end

@implementation RoadsideInteractor

- (instancetype)initWithDataManager:(RoadsideDataManager *)dataManager
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
