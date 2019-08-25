//
//  VehiclesViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "VehiclesViewInterface.h"
#import "VehiclesModuleInteface.h"
#import "PWParallaxScrollView.h"

@class MPreownedBrand;

@interface VehiclesViewController : BaseViewController<VehiclesViewInterface>

@property (nonatomic, strong) id<VehiclesModuleInteface> eventHandler;
@property (nonatomic, strong) MPreownedBrand *brand;

@end
