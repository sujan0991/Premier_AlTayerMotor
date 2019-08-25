//
//  ServicesPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesPresenter.h"
#import "BookingServiceWireframe.h"
#import "ServicesWireframe.h"
#import "MRegisteredVehicle.h"

@implementation ServicesPresenter

#pragma mark - Module Interface
- (void)findRegisteredVehicles
{
    [self.servicesInteractor findRegisteredVehicles];
}

#pragma mark - View Interface
- (void)foundRegisteredVehicles:(NSArray *)vehicles
{
    [self.userInterface updateRegisteredVehicles:vehicles];
}

- (void)showBookingServiceByNavigationController:(UINavigationController *)navigationController
                           withRegisteredVehicle:(id)vehicle
{
    [self.bookingServiceWireframe pushBookingServiceToViewController:navigationController
                                               withRegisteredVehicle:vehicle];
}

- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    [self.servicesWireframe presentDeleteVehicleInterfaceFromNavigation:self.userInterface.navigationController
                                                  withServicesPresenter:self
                                                            withVehicle:vehicle];
}

#pragma mark - Delete Vehicles
- (void)deleteVehicleDidCancelAction
{
    DLog();
}

- (void)deleteVehicleDidSubmitActionWithVehicle:(MRegisteredVehicle *)vehicle
{
    DLog();
    [self.servicesInteractor deleteRegisteredVehicleByRegistrationNumber:vehicle.registrationNumber];
    [self.servicesInteractor findRegisteredVehicles];
}

#pragma mark - Others

@end
