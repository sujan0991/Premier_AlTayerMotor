//
//  ServicesPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesViewInterface.h"
#import "ServicesModuleInterface.h"
#import "ServicesInteractorIO.h"
#import "DeleteVehicleModuleDelegate.h"

@class ServicesWireframe;
@class BookingServiceWireframe;

@interface ServicesPresenter : NSObject<ServicesModuleInterface, ServicesInteractorOutput, DeleteVehicleModuleDelegate>

@property (nonatomic, strong) id<ServicesInteractorInput> servicesInteractor;
@property (nonatomic, strong) ServicesWireframe *servicesWireframe;
@property (nonatomic, strong) BookingServiceWireframe *bookingServiceWireframe;
@property (nonatomic, strong) UIViewController<ServicesViewInterface> *userInterface;

@end
