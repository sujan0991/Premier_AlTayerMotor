//
//  MBookingTestRequest.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class MBrand;
@class MVehicleModel;
@class MCity;
@class MLocation;

@interface MBookingTestRequest : MBase

@property (strong, nonatomic) MBrand *brand;
@property (strong, nonatomic) MVehicleModel *model;
@property (strong, nonatomic) MLocation *location;
@property (strong, nonatomic) NSString *otherBrand;
@property (strong, nonatomic) NSString *otherModel;
@property (assign, nonatomic) NSInteger year;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) MCity *city;
@property (assign, nonatomic) BOOL isReceivedInfor;

@end
