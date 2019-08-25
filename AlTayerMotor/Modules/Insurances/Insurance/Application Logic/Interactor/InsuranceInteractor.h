//
//  InsuranceInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsuranceInteractorIO.h"
#import "InsuranceNetworkInterface.h"

@class InsuranceDataManager;
@class InsuranceNetwork;

@interface InsuranceInteractor : NSObject <InsuranceInteractorInput, InsuranceNetworkInterface>

@property (weak, nonatomic) id<InsuranceInteractorOutput> output;

-(instancetype)initWithDataManager:(InsuranceDataManager *)dataManager
                        andNetwork:(InsuranceNetwork *)network;

@end
