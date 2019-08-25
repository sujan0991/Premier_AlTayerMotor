//
//  MCity.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/3/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MCity.h"
#import "City.h"

@implementation MCity

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [ super init]) {
        _key = dict[@"key"];
        _name = dict[@"name_en"];
        _nameAR = dict[@"name_ar"];
    }
    
    return self;
}

-(instancetype)initWithDatabaseObject:(City *)city
{
    if (self = [super init]) {
        _Id = [city.id integerValue];
        _key = city.key;
        _name = city.name;
        _nameAR = city.nameAR;
    }
    
    return self;
}

- (NSString *)name
{
    return  [ATMGlobal isEnglish] ? _name : _nameAR;
}

@end
