//
//  MDrivingExperience.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/9/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MDrivingExperience.h"
#import "DrivingExperience.h"

@implementation MDrivingExperience

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [ super init]) {
        _key = dict[@"key"];
        _name = dict[@"name_en"];
        _nameAR = dict[@"name_ar"];
    }
    
    return self;
}

-(instancetype)initWithDatabaseObject:(DrivingExperience *)drivingExperience;
{
    if (self = [super init]) {
        _key = drivingExperience.key;
        _name = drivingExperience.name;
        _nameAR = drivingExperience.nameAr;
    }
    
    return self;
}

- (NSString *)name
{
    return  [ATMGlobal isEnglish] ? _name : _nameAR;
}

@end
