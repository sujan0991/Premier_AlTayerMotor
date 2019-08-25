//
//  BookingTestInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookingTestInteractorIO.h"
#import "BookingTestNetworkInterface.h"

@class BookingTestDataManager;
@class BookingTestNetwork;

@interface BookingTestInteractor : NSObject <BookingTestInteractorInput, BookingTestNetworkInterface>

@property (weak, nonatomic) id<BookingTestInteractorOutput> output;

- (instancetype)initWithDataManager:(BookingTestDataManager *)dataManager
                         andNetwork:(BookingTestNetwork *)network;

@end
