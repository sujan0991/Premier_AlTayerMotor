//
//  MInsuranceRequest.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MCity;

@interface MInsuranceRequest : MBase

@property (nonatomic, strong) UIImage *frontCard;
@property (nonatomic, strong) UIImage *backCard;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) MCity *city;
@property (nonatomic, strong) NSString *phoneCode;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSString *drivingExperience;

@end
