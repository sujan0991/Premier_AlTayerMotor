//
//  BookingServicePresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "BookingServiceModuleInterface.h"
#import "BookingServiceWireframe.h"
#import "BookingServiceInteractorIO.h"
#import "ServicePopupModuleDelegateInterface.h"

@protocol BookingServiceViewInterface;

@interface BookingServicePresenter : NSObject<BookingServiceModuleInterface, BookingServiceInteractorOutput, ServicePopupModuleDelegate>

@property (nonatomic, strong) BookingServiceWireframe *bookingServiceWireframe;
@property (nonatomic, weak) BaseViewController<BookingServiceViewInterface> *userInterface;
@property (nonatomic, strong) id<BookingServiceInteractorInput> bookingServiceInteractor;

@end
