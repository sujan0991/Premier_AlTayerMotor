//
//  DeleteVehicleWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServicesPresenter;
@class ProfilePresenter;
@class FirstTimePresenter;
@class MRegisteredVehicle;

@interface DeleteVehicleWireframe : NSObject
- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController * __nullable)nav
                              withServicesPresenter:(ServicesPresenter * __nullable)presenter
                                        withVehicle:(MRegisteredVehicle * __nullable)vehicle;

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *__nullable)nav
                               withProfilePresenter:(ProfilePresenter *__nullable)profilePresenter
                                        withVehicle:(MRegisteredVehicle *__nullable)vehicle;

- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *__nullable)nav
                             withFirstTimePresenter:(FirstTimePresenter *__nullable)firstTimePresenter
                                        withVehicle:(MRegisteredVehicle *__nullable)vehicle;

- (void)dismissDeleteInterfaceWithCompletion:(void (^ __nullable)(void))completion;
@end
