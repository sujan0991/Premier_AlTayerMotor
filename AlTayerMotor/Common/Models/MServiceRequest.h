//
//  MServiceRequest.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MBrand;
@class MVehicleModel;
@class MCity;
@class MLocation;

@interface MServiceRequest : MBase

@property (strong, nonatomic) NSString *brandName;
@property (strong, nonatomic) NSString *otherBrand;
@property (strong, nonatomic) MBrand *brand;
@property (strong, nonatomic) MVehicleModel *model;
@property (strong, nonatomic) NSString *otherModel;
@property (strong, nonatomic) MCity *city;
@property (strong, nonatomic) MLocation *location;
@property (assign, nonatomic) NSInteger year;
@property (strong, nonatomic) NSString *registrationNumber;
@property (assign, nonatomic) NSInteger mileage;
@property (assign, nonatomic) NSInteger branchId;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phoneCode;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;

@end
