//
//  FirstTimeInteractor.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstTimeInteractorIO.h"

@class FirstTimeDataManager;

@interface FirstTimeInteractor : NSObject <FirstTimeInteractorInput>

@property (nonatomic, weak) id<FirstTimeInteractorOutput> output;

- (instancetype)initWithDataManager:(FirstTimeDataManager *)dataManager;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;

@end