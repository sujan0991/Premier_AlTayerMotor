//
//  VehicleDetailsWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVehicle;
@class MPreownedBrand;

@interface VehicleDetailsWireframe : NSObject
- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle
                           inNavigation:(UINavigationController *)navigationController;
- (void)presentEnquiryInterfaceWithData:(MPreownedBrand *)brand
                              withModel:(NSInteger)modelId
                           inNavigation:(UINavigationController *)navigationController;
@end
