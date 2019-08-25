//
//  MVehicle.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MPreownedBrand;

@interface MVehicle : MBase

@property (nonatomic, strong) NSString *availability;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *engine;
@property (nonatomic, strong) NSString *fuelType;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, assign) NSInteger modelId;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger seat;
@property (nonatomic, assign) NSString *category;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) MPreownedBrand *brand;
@property (nonatomic, assign) NSInteger mileage;
@property (nonatomic, strong) NSString *trim;
@property (nonatomic, strong) NSString *color;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSString *)imageLink;
- (NSString *)getCurrency;
@end
