//
//  PeekOffersViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "PeekOffersViewInterface.h"
#import "PeekOffersModuleInterface.h"

@protocol PeekOffersModuleInterface;

@interface PeekOffersViewController : BaseViewController <PeekOffersViewInterface>

@property (nonatomic, strong) id<PeekOffersModuleInterface> eventHandler;

@end