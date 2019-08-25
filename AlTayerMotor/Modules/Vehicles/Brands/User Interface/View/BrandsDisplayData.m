//
//  BrandsDisplayData.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsDisplayData.h"

@interface BrandsDisplayData()
@property (nonatomic, copy) NSArray *brands;
@end

@implementation BrandsDisplayData

+ (instancetype)displayDataWithBrands:(NSArray *)brands
{
    BrandsDisplayData *data = [BrandsDisplayData new];
    data.brands = brands;
    
    return data;
}

@end
