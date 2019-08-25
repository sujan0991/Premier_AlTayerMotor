//
//  ServicesWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServicesPresenter;
@class MRegisteredVehicle;

@interface ServicesWireframe : NSObject

- (void)initServicesViewController;
- (void)presentDeleteVehicleInterfaceFromNavigation:(UINavigationController *)nav
                              withServicesPresenter:(ServicesPresenter *)presenter
                                        withVehicle:(MRegisteredVehicle *)vehicle;
@end