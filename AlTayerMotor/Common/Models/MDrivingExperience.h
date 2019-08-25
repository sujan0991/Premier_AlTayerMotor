//
//  MDrivingExperience.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class DrivingExperience;

@interface MDrivingExperience : MBase

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameAR;
@property (strong, nonatomic) NSString *key;

-(instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)initWithDatabaseObject:(DrivingExperience *)drivingExperience;

@end
