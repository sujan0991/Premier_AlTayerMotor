//
//  BookingServiceViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BookingServiceViewInterface.h"

@protocol BookingServiceModuleInterface;
@class MRegisteredVehicle;

@interface BookingServiceViewController : BaseViewController<BookingServiceViewInterface>

@property (nonatomic, strong) MRegisteredVehicle *registeredVehicle;
@property (nonatomic, strong) id<BookingServiceModuleInterface> eventHandler;

@end