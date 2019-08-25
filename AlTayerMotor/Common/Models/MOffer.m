//
//  MOffer.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MOffer.h"

@implementation MOffer

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _Id = [dict[@"id"] integerValue];
        _brandId = [dict[@"brand_id"] integerValue];
        _posterUrl = dict[@"poster_image_url"];
        _thumbnailUrl = dict[@"thumbnail_image_url"];
        _title = dict[@"title"];
        _desc = dict[@"description"];
        _category = dict[@"Offer_category"];
        _currency = dict[@"currency"];
        _price = [dict[@"starting_price"] integerValue];
    }
    
    return self;
}

@end
