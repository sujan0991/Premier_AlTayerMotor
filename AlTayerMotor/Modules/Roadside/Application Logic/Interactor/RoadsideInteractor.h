//
//  RoadsideInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoadsideInteractorIO.h"

@class RoadsideDataManager;

@interface RoadsideInteractor : NSObject <RoadsideInteractorInput>

@property (nonatomic, weak) id<RoadsideInteractorOutput> output;

- (instancetype)initWithDataManager:(RoadsideDataManager *)dataManager;

@end
