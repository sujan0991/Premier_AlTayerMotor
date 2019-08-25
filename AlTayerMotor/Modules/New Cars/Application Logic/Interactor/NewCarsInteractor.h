//
//  NewCarsInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewCarsInteractorIO.h"

@class NewCarsDataManager;

@interface NewCarsInteractor : NSObject <NewCarsInteractorInput>

@property (nonatomic, weak) id<NewCarsInteractorOutput> output;

- (instancetype)initWithDataManager:(NewCarsDataManager *)dataManager;

@end
