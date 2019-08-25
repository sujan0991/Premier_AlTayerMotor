//
//  OffersFilterWireframe.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OffersFilterDisplayData;

@interface OffersFilterWireframe : NSObject

- (void)presentFilterInterfaceInNavigation:(UINavigationController *)nc
                                  withData:(OffersFilterDisplayData *)data;

@end
