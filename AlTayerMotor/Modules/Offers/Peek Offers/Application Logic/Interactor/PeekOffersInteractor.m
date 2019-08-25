//
//  PeekOffersInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "PeekOffersInteractor.h"
#import "PeekOffersDataManager.h"

@interface PeekOffersInteractor()
@property (nonatomic, strong) PeekOffersDataManager *dataManager;
@end

@implementation PeekOffersInteractor

- (instancetype)initWithDataManager:(PeekOffersDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

@end
