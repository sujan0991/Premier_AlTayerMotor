//
//  DeleteVehicleViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "DeleteVehicleModuleInterface.h"

@interface DeleteVehicleViewController : BaseViewController

@property (nonatomic, strong) id<DeleteVehicleModuleInterface> eventHandler;
@property (nonatomic, strong) UIView *transitioningBackgroundView;

@end
