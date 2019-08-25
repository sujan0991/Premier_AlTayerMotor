//
//  MGlobalSetting.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MGlobalSetting.h"
#import "GlobalSetting.h"

@implementation MGlobalSetting

-(instancetype)initWithDict:(NSDictionary *)dict withParentKey:(NSString*)parentKey atIndex:(NSInteger)index
{
    if (self == [ super init]) {
        _key = dict[@"key"];
        _name = dict[@"name_en"];
        _nameAR = dict[@"name_ar"];
        _parentKey = parentKey ?: @"";
        _index = index;
        
        if (!_name || [_name isEqual:[NSNull null]]) {
            _name = @"";
        }
        
        if (!_nameAR || [_nameAR isEqual:[NSNull null]]) {
            _nameAR = @"";
        }
//        DLog(@"%@ - %@ - %@", _name, _key, _parentKey);
    }
    
    return self;
}

-(instancetype)initWithDatabaseObject:(GlobalSetting *)setting
{
    if (self = [super init]) {
        _key = setting.key;
        _name = setting.name;
        _nameAR = setting.nameAR;
        _parentKey = setting.parent_key;
        _index = [setting.index integerValue];
    }
    return self;
}

- (NSString *)name
{
    return  [ATMGlobal isEnglish] ? _name : _nameAR;
}
@end
