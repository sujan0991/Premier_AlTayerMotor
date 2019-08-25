//
//  PeekOffersDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface PeekOffersDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

@end
