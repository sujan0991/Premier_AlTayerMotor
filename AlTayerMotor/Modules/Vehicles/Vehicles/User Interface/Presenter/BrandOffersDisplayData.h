//
//  BrandOfferDisplayData.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandOffersDisplayData : NSObject

@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, assign) NSTimeInterval timeStamp;

- (instancetype)initWithOffers:(NSArray *)offers;

@end
