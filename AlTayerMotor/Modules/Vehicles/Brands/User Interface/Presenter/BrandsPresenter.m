//
//  BrandsPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsPresenter.h"
#import "BrandsWireframe.h"
#import "BrandsDisplayData.h"
#import "MPreownedBrand.h"
#import "NSArray+LinqExtensions.h"


@implementation BrandsPresenter


#pragma mark - Module Interface
- (void)updateView
{
    [self.interactor findAllBrands];
}

- (void)presentVehiclesInterfaceWithData:(MPreownedBrand *)brand
{
    [self.wireframe presentVehiclesInterfaceWithBrand:brand inNavigation:self.userInterface.navigationController];
}

- (void)findUserInfo
{
    [self.interactor findUserInfo];
}

#pragma mark - Interactor
- (void)foundAllBrands:(NSArray *)brands
{
    BrandsDisplayData *data = [BrandsDisplayData displayDataWithBrands:brands];
    [self.userInterface showBrandsDisplayData:data];
}

- (void)foundUserInfo:(MUser *)user
{
    [self.userInterface showUserInfo:user];
}

@end
