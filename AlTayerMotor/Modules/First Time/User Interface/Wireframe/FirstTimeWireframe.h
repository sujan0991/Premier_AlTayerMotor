//
//  FirstTimeWireframe.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FirstTimePresenter;
@class RootWireframe;
@class TabBarWireframe;
@class MRegisteredVehicle;

@interface FirstTimeWireframe : NSObject

@property (nonatomic, strong) FirstTimePresenter *firstTimePresenter;
@property (nonatomic, strong) RootWireframe *rootWireframe;
@property (nonatomic, strong) TabBarWireframe *tabBarWireframe;

- (void)presentFirstTimeInterfaceFromWindow:(UIWindow *)window;
- (void)presentTabBarWireframe;
- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
                        inNavigation:(UINavigationController *)navController;
- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                               withFirstTimePresenter:(FirstTimePresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle;

@end
