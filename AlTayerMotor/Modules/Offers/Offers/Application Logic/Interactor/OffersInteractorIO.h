//
//  OffersInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OffersInteractorInput <NSObject>
- (void)getOffers;
- (void)getOffersSettings;
@end

@protocol OffersInteractorOutput <NSObject>
- (void)didGetOffersSettings:(NSArray *)settings;
- (void)didGetOffers:(NSArray*)offers;
- (void)didGetError:(NSError *)error;
@end