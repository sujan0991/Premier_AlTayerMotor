//
//  ServicesModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;

@protocol ServicesModuleInterface <NSObject>
- (void)findRegisteredVehicles;
- (void)showBookingServiceByNavigationController:(UINavigationController *)navigationController withRegisteredVehicle:(MRegisteredVehicle *)vehicle;
- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle;

@end
