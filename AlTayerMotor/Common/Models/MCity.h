//
//  MCity.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/3/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class City;

@interface MCity : MBase
@property (assign, nonatomic) NSInteger Id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameAR;
@property (strong, nonatomic) NSString *key;

-(instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)initWithDatabaseObject:(City *)city;

@end
