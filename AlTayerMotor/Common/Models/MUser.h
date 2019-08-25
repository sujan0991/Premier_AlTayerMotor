//
//  MUser.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class User;
@class MCity;

@interface MUser : MBase

@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) MCity *city;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *phoneCode;

- (instancetype)initWithUser:(User *)user andCity:(MCity *)city;

@end
