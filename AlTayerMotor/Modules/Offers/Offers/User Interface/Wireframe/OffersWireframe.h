//
//  OffersWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OffersFilterDisplayData;

@interface OffersWireframe : NSObject
- (void)presentOffersInterfaceInNavigation:(UINavigationController *)navControlelr;
- (void)presentOffersFilterWithData:(OffersFilterDisplayData *)data
                         inNavigation:(UINavigationController *)navController;
- (void)presentPeekOffersInterfaceWithData:(NSArray*)offers
                           withViewedIndex:(NSInteger)index
                              inNavigation:(UINavigationController *)navController;
@end
