//
//  OffersModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OffersFilterDisplayData;

@protocol OffersModuleInterface <NSObject>
- (void)getOffers;
- (void)getOffersSettings;
- (BOOL)isGettingOffers;
- (void)presentFilterInterfaceWithData:(OffersFilterDisplayData *)data;
- (void)presentOffersInterfaceWithData:(NSArray*)offers
                       withViewedIndex:(NSInteger)index;
@end
