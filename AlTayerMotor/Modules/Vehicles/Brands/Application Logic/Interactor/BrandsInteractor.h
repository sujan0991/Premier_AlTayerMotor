//
//  BrandsInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BrandsInteractorIO.h"

@class BrandsDataManager;

@interface BrandsInteractor : NSObject <BrandsInteractorInput>

@property (nonatomic, weak) id<BrandsInteractorOutput> output;

- (instancetype)initWithDataManager:(BrandsDataManager *)dataManager;

@end
