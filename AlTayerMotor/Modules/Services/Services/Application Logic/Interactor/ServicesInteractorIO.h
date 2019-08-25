//
//  ServicesInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServicesInteractorInput <NSObject>
- (void)findRegisteredVehicles;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;
@end


@protocol ServicesInteractorOutput <NSObject>
- (void)foundRegisteredVehicles:(NSArray *)vehicles;
@end
