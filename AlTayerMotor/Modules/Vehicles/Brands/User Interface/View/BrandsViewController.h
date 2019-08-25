//
//  BrandsViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "BrandsViewInterface.h"
#import "BrandsModuleInterface.h"

@protocol BrandsModuleInterface;

@interface BrandsViewController : BaseViewController <BrandsViewInterface>

@property (nonatomic, strong) id<BrandsModuleInterface> eventHandler;

@end
