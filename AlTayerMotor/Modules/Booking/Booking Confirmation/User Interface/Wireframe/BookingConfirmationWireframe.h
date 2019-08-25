//
//  BookingConfirmationWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookingTestPresenter;
@class MBookingTestRequest;

@interface BookingConfirmationWireframe : NSObject

- (void)presentBookingConfirmationInterfaceFromPresenter:(BookingTestPresenter *)presenter
                                             withRequest:(MBookingTestRequest *)request;

@end
