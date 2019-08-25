//
//  LatestOffersModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LatestOffersModuleInterface <NSObject>
- (void)presentBrandsInterface;
- (void)presentOffersInterfaceWithData:(NSArray*)offers
                       withViewedIndex:(NSInteger)index;
- (void)getLatestOffers;
@end
