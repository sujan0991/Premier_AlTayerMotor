//
//  PeekOffersInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PeekOffersInteractorIO.h"

@class PeekOffersDataManager;

@interface PeekOffersInteractor : NSObject <PeekOffersInteractorInput>

@property (nonatomic, weak) id<PeekOffersInteractorOutput> output;

- (instancetype)initWithDataManager:(PeekOffersDataManager *)dataManager;

@end
