//
//  ProfileWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class ProfilePresenter;

@interface ProfileWireframe : NSObject

- (void)presentProfileInterfaceFromViewController:(UINavigationController *)navigationController;

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController;

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                               withProfilePresenter:(ProfilePresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle;

@end
