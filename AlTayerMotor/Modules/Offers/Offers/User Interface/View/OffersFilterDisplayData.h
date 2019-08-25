//
//  OffersFilterDisplayData.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OffersFilterDisplayData : NSObject
@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, strong) NSArray *settings;
@property (nonatomic, strong) NSString *selectedCategory;
@property (nonatomic, assign) NSInteger selectedBrand;
@end
