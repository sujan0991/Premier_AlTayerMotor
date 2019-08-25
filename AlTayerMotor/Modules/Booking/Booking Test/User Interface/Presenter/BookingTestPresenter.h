//
//  BookingTestPresenter.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BookingTestModuleInterface.h"
#import "BookingTestInteractor.h"

@class BookingTestWireframe;
@protocol BookingTestViewInterface;
@class BookingConfirmationWireframe;

@interface BookingTestPresenter : NSObject<BookingTestModuleInterface, BookingTestInteractorOutput>

@property (nonatomic, strong) BookingTestWireframe *bookingTestWireframe;
@property (nonatomic, strong) BookingConfirmationWireframe *bookingConfirmationWireframe;
@property (nonatomic, strong) BaseViewController<BookingTestViewInterface> *userInterface;
@property (nonatomic, strong) id<BookingTestInteractorInput> interactor;

@end
