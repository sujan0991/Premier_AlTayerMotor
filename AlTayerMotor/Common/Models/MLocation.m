//
//  MLocation.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/3/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MLocation.h"
#import "Location.h"
#import "CoreDataStore.h"
#import "MCity.h"

@implementation MLocation

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _Id = [dict[@"id"] integerValue];
        _name = dict[@"name"];
        _city = dict[@"city"];
        _latitude = [dict[@"latitude"] floatValue];
        _longitude = [dict[@"longitude"] floatValue];
        NSArray *type = dict[@"type"];
        if ([self isArray:type]) {
            _isBodyShop = [type containsObject:@"bodyshop"];
            _isServiceCenter = [type containsObject:@"service centre"];
            _isShowRoom = [type containsObject:@"showroom"];
        }
        
        _brandids = [dict objectForKey:@"brands"];
        DLog(@"%d %@ %@", _Id, _name, _brandids);
        
        NSString *lang = dict[@"lang"];
        if (lang && [lang isEqualToString:@"en"]) {
            _lang = AppLanguageEnglish;
        } else {
            _lang = AppLanguageArabian;
        }
//        DLog(@"%ld", _lang);
        
        _phoneNumber = dict[@"phone_number"];
        _openHourTitle1 = [self isValidString:dict[@"openingHourTitle1"]] ? dict[@"openingHourTitle1"] : @"";
        _openHourTitle2 = [self isValidString:dict[@"openingHourTitle2"]] ? dict[@"openingHourTitle2"] : @"";
        _openHourTitle3 = [self isValidString:dict[@"openingHourTitle3"]] ? dict[@"openingHourTitle3"] : @"";
        _openHourValue1 = [self isValidString:dict[@"openingHourValue1"]] ? dict[@"openingHourValue1"] : @"";
        _openHourValue2 = [self isValidString:dict[@"openingHourValue2"]] ? dict[@"openingHourValue2"] : @"";
        _openHourValue3 = [self isValidString:dict[@"openingHourValue3"]] ? dict[@"openingHourValue3"] : @"";
    }
    
    return self;
}

- (instancetype)initWithDatabaseObject:(Location *)location
{
    if (self = [super init]) {
        _Id = [location.id integerValue];
        _name = location.name;
        _brandids = [NSKeyedUnarchiver unarchiveObjectWithData:location.brandids];        
        _city = [[[CoreDataStore sharedStore] getCityByKey:location.city] name];;
        _latitude = [location.latitude floatValue];
        _longitude = [location.longitude floatValue];
        _isBodyShop = [location.isBodyShop boolValue];
        _isServiceCenter = [location.isServiceCenter boolValue];
        _isShowRoom = [location.isShowRoom boolValue];
        _lang = [location.lang integerValue];
        _openHourValue1 = location.openHourValue1;
        _openHourValue2 = location.openHourValue2;
        _openHourValue3 = location.openHourValue3;
        _openHourTitle1 = location.openHourTitle1;
        _openHourTitle2 = location.openHourTitle2;
        _openHourTitle3 = location.openHourTitle3;
        _phoneNumber = location.phoneNumber;
    }
    
    return self;
}

@end
