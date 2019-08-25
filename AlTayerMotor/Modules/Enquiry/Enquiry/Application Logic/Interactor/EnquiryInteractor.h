//
//  EnquiryInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnquiryInteractorIO.h"
#import "EnquiryNetworkInterface.h"

@class EnquiryDataManager;
@class EnquiryNetwork;

@interface EnquiryInteractor : NSObject <EnquiryInteractorInput, EnquiryNetworkInterface>

@property (nonatomic, weak) id<EnquiryInteractorOutput> output;

- (instancetype)initWithDataManager:(EnquiryDataManager *)dataManager
                         andNetwork:(EnquiryNetwork *)network;

@end
