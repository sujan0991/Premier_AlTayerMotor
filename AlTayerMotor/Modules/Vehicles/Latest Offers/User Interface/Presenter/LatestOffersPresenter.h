//
//  LatestOffersPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "LatestOffersWireframe.h"
#import "LatestOffersModuleInterface.h"
#import "LatestOffersInteractorIO.h"

@protocol LatestOffersViewInterface;

@interface LatestOffersPresenter : NSObject <LatestOffersModuleInterface, LatestOffersInteractorOutput>

@property (nonatomic, strong) id<LatestOffersInteractorInput> interactor;
@property (nonatomic, strong) LatestOffersWireframe *wireframe;
@property (nonatomic, weak) BaseViewController<LatestOffersViewInterface> *userInterface;

@end
