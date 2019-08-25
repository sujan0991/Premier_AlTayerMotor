//
//  LatestOffersInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LatestOffersInteractorInput <NSObject>
- (void)getLatestOffers;
@end

@protocol LatestOffersInteractorOutput <NSObject>
- (void)didGetOffers:(NSArray*)offers;
- (void)didGetOffersError:(NSError *)error;
@end
