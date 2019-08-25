//
//  MOffer.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MBrand;

@interface MOffer : MBase

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, strong) MBrand *brand;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, assign) NSInteger price;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
