//
//  MVehicleModel.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/29/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class VehicleModel;

@interface MVehicleModel : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *modelAR;
@property (nonatomic, assign) NSInteger modelYear;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithId:(NSInteger)Id
               withBrandId:(NSInteger)brandId
                 withModel:(NSString *)model
               withModelAR:(NSString *)modelAR
             withModelYear:(NSNumber *)modelYear
                  withType:(NSString *)type
                 withImage:(NSString *)image;
- (instancetype)initWithVehicleModel:(VehicleModel *)vehicleModel;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
