//
//  BookingConfirmationPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BookingConfirmationViewInterface.h"
#import "BookingConfirmationModuleInterface.h"
#import "BookingConfirmationWireframe.h"


@interface BookingConfirmationPresenter : NSObject <BookingConfirmationModuleInterface>

@property (nonatomic, strong) BookingConfirmationWireframe *wireframe;
@property (nonatomic, strong) BaseViewController<BookingConfirmationViewInterface> *userInterface;
@property (nonatomic, weak) BookingTestPresenter *bookingPresenter;

@end
