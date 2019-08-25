//
//  VehicleDetailsViewInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVehicle;

@protocol VehicleDetailsViewInterface <NSObject>
- (void)setVehicle:(MVehicle *)vehicle;
@end
