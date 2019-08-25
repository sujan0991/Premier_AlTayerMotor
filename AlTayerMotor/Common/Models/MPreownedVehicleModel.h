//
//  MPreownedVehicleModel.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class PreownedVehicleModel;

@interface MPreownedVehicleModel : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, assign) NSInteger modelYear;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithId:(NSInteger)Id withBrandId:(NSInteger)brandId withModel:(NSString *)model withModelYear:(NSNumber *)modelYear withType:(NSString *)type withImage:(NSString *)image;
- (instancetype)initWithVehicleModel:(PreownedVehicleModel *)vehicleModel;
- (instancetype)initWithDict:(NSDictionary *)dict andCategory:(NSString*)category;

@end
