//
//  RoadsideViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "RoadsideViewInterface.h"

@protocol RoadsideModuleInterface;

@interface RoadsideViewController : BaseViewController<RoadsideViewInterface>

@property (nonatomic, strong) id<RoadsideModuleInterface> eventHandler;

@end
