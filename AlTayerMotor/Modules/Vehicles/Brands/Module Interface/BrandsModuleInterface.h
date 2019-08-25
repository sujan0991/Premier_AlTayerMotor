//
//  BrandsModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPreownedBrand;

@protocol BrandsModuleInterface <NSObject>
- (void)updateView;
- (void)presentVehiclesInterfaceWithData:(MPreownedBrand *)brand;
- (void)findUserInfo;
@end
