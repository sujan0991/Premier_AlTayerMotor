//
//  MBranch.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBranch.h"
@implementation MBranch

- (instancetype)initWithId:(NSInteger)id withName:(NSString *)name withOpeningHours:(NSString *)openingHours withType:(NSString *)type withLatitude:(NSNumber*)latitude withLongitude:(NSNumber*)longigtude;
{
    MBranch *brand = [MBranch new];
    brand.id = id;
    brand.name = name;
    brand.openingHours = openingHours;
    brand.type = type;
    brand.latitude = [latitude floatValue];
    brand.longitude = [longigtude floatValue];
    
    return brand;
}

@end
