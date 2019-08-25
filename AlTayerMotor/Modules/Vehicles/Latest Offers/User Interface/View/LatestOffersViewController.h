//
//  LatestOffersViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "LatestOffersViewInterface.h"

@protocol LatestOffersModuleInterface;

@interface LatestOffersViewController : BaseViewController<LatestOffersViewInterface>
@property (nonatomic, strong) id<LatestOffersModuleInterface> eventHandler;
@end