//
//  BrandsWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPreownedBrand;

@interface BrandsWireframe : NSObject
- (void)initInsuranceViewController;
- (void)presentBrandsInterfaceInNavigation:(UINavigationController *)navigationController;
- (void)presentVehiclesInterfaceWithBrand:(MPreownedBrand *)barnd
                             inNavigation:(UINavigationController *)navigationController;
@end
