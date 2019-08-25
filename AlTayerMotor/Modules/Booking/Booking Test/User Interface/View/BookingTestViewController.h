//
//  BookingTestViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BookingTestViewInterface.h"

@protocol BookingTestModuleInterface;

@interface BookingTestViewController : BaseViewController<BookingTestViewInterface>

@property (nonatomic, strong) id<BookingTestModuleInterface> eventHandler;

@end
