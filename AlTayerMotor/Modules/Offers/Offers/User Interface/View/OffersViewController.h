//
//  OffersViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "OffersViewInterface.h"
#import "OffersModuleInterface.h"

@interface OffersViewController : BaseViewController <OffersViewInterface>

@property (nonatomic, strong) id<OffersModuleInterface> eventHandler;

@end
