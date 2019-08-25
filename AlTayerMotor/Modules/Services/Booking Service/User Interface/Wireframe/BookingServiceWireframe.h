//
//  BookingServiceWireframe.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class ServiceConfirmationWireframe;
@class ServicePopupWireframe;
@class BookingServicePresenter;
@class MServiceRequest;

@interface BookingServiceWireframe : NSObject

@property (strong, nonatomic)ServiceConfirmationWireframe *confirmationWireframe;
@property (strong, nonatomic)ServicePopupWireframe *servicePopupWireframe;

- (void)pushBookingServiceToViewController:(UINavigationController *)navigationController
                     withRegisteredVehicle:(MRegisteredVehicle *)vehicle;

- (void)presentServicePopupInterfaceWithPresenter:(BookingServicePresenter *)presenter;

- (void)pushConfirmationInterfaceToController:(UINavigationController *)navigationController
                                  withRequest:(MServiceRequest *)request;

@end