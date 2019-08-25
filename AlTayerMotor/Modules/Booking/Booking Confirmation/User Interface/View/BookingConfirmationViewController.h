//
//  BookingConfirmationViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BookingConfirmationModuleInterface.h"
#import "BookingConfirmationViewInterface.h"

@class MBookingTestRequest;

@interface BookingConfirmationViewController : BaseViewController <BookingConfirmationViewInterface>

@property (nonatomic, strong) id<BookingConfirmationModuleInterface> eventHandler;
@property (nonatomic, strong) MBookingTestRequest *request;

@end
