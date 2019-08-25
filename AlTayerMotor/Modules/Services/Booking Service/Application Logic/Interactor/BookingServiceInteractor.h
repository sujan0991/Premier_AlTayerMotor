//
//  BookingServiceInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookingServiceInteractorIO.h"
#import "BookingServiceNetworkInterface.h"

@class BookingServiceNetwork;
@class BookingServiceDataManager;

@interface BookingServiceInteractor : NSObject<BookingServiceInteractorInput, BookingServiceNetworkInterface>

@property (weak, nonatomic) id<BookingServiceInteractorOutput> output;

- (instancetype)initWithDataManager:(BookingServiceDataManager *)dataManager
                         andNetwork:(BookingServiceNetwork *)network;

@end
