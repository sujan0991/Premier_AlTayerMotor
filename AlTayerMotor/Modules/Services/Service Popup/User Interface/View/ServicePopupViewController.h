//
//  ServicePopupViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "ServicePopupModuleInterface.h"

@interface ServicePopupViewController : BaseViewController

@property (nonatomic, strong) id<ServicePopupModuleInterface> eventHandler;
@property (nonatomic, strong) UIView *transitioningBackgroundView;

@end
