//
//  OffersViewInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OffersViewInterface <NSObject>

- (void)updateOffers:(NSArray *)offers;
- (void)updateSettings:(NSArray *)settings;
@end
