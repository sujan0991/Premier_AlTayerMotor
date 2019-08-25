//
//  OffersPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "OffersModuleInterface.h"
#import "OffersViewInterface.h"
#import "OffersInteractorIO.h"

@class OffersWireframe;

@interface OffersPresenter : NSObject <OffersModuleInterface, OffersInteractorOutput>

@property (nonatomic, strong) id<OffersInteractorInput> interactor;
@property (nonatomic, strong) OffersWireframe *wireframe;
@property (nonatomic, strong) BaseViewController<OffersViewInterface> *userInterface;

@end
