//
//  NewCarsViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "NewCarsViewInterface.h"

@protocol NewCarsModuleInterface;

@interface NewCarsViewController : BaseViewController<NewCarsViewInterface>

@property (nonatomic, strong) id<NewCarsModuleInterface> eventHandler;

@end
