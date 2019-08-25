//
//  LoadingViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadingViewInterface.h"
#import "LoadingModuleInterface.h"

@interface LoadingViewController : BaseViewController<LoadingViewInterface>

@property (nonatomic, strong) id<LoadingModuleInterface> eventHandler;

@end
