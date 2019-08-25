//
//  MRegisterCar.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MRegisteredVehicle.h"
#import "MVehicleModel.h"

@implementation MRegisteredVehicle

- (BOOL)hasChanged:(MRegisteredVehicle*)newInfo
{
    return _brandId != newInfo.brandId ||
    _model.id != newInfo.model.id ||
    _year != newInfo.year ||
    ![_registrationExpiry isEqualToString:newInfo.registrationExpiry] ||
    ![_registrationNumber isEqualToString:newInfo.registrationNumber];
}
@end
