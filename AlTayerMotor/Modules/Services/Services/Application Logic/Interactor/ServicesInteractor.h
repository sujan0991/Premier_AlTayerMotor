//
//  ServicesInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesInteractorIO.h"
#import "ServicesDataManager.h"

@interface ServicesInteractor : NSObject <ServicesInteractorInput>

@property (nonatomic, weak) id<ServicesInteractorOutput> output;

- (instancetype)initWithDataManager:(ServicesDataManager *)dataManager;

@end
