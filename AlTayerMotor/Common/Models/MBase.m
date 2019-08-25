//
//  MBase.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@implementation MBase

- (BOOL)isDictionary:(id)dict
{
    return dict && ![dict isEqual:[NSNull null]] && [dict isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArray:(id)array
{
    return array && ![array isEqual:[NSNull null]] && [array isKindOfClass:[NSArray class]];
}

- (BOOL)isValidString:(id)field
{
    return field && ![field isEqual:[NSNull null]] && [field isKindOfClass:[NSString class]];
}


@end
