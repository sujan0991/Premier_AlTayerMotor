//
//  LatestOffersWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestOffersWireframe : NSObject
- (void)initLatestOffersViewController;
- (void)presentBrandsInterfaceInNavigation:(UINavigationController *)navController;
- (void)presentPeekOffersInterfaceWithData:(NSArray*)offers
                           withViewedIndex:(NSInteger)index
                              inNavigation:(UINavigationController *)navController;
@end
