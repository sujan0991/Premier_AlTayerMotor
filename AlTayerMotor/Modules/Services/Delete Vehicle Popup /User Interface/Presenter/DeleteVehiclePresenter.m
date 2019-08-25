//
//  DeleteVehiclePresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DeleteVehiclePresenter.h"
#import "DeleteVehicleWireframe.h"

@implementation DeleteVehiclePresenter

- (void)cancelAction
{
    [self.wireframe dismissDeleteInterfaceWithCompletion:^{
        [self.delegate deleteVehicleDidCancelAction];
    }];
    
}

- (void)submitAction
{
    [self.wireframe dismissDeleteInterfaceWithCompletion:^{
        [self.delegate deleteVehicleDidSubmitActionWithVehicle:self.vehicle];
    }];
}

@end
