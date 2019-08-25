//
//  LoadingInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingInteractorIO.h"
#import "LoadingNetworkInterface.h"

@class LoadingNetwork;
@class LoadingDataManager;

@interface LoadingInteractor : NSObject <LoadingInteractorInput, LoadingNetworkInterface>

@property (weak, nonatomic) id<LoadingInteractorOutput> output;

-(instancetype)initWithNetwork:(LoadingNetwork *)apiNetwork andDataManager:(LoadingDataManager*)dataManager;

@end