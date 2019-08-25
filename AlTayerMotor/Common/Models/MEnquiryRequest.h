//
//  MEnquiryRequest.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"
@class MBrand;
@class MPreownedBrand;
@class MVehicleModel;
@class MPreownedVehicleModel;


@interface MEnquiryRequest : MBase
@property(nonatomic, strong) NSString *enquiry;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) MBrand *brand;
@property(nonatomic, strong) MPreownedBrand *preownedBrand;
@property(nonatomic, strong) MVehicleModel *model;
@property(nonatomic, strong) MPreownedVehicleModel *preownedModel;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *phoneCode;
@property(nonatomic, strong) NSString *phoneNumber;
@end
