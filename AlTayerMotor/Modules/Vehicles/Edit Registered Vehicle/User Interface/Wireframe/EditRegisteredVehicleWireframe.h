//
//  EditRegisteredVehicleWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;

@interface EditRegisteredVehicleWireframe : NSObject

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController;

@end
