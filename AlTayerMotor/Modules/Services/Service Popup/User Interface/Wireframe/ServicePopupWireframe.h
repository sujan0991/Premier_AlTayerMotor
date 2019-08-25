//
//  ServicePopupWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookingServicePresenter;

@interface ServicePopupWireframe : NSObject
- (void)presentAddInterfaceFromViewController:(UIViewController *)viewController
                  withBookingServicePresenter:(BookingServicePresenter *)presenter;
- (void)dismissAddInterface;
@end
