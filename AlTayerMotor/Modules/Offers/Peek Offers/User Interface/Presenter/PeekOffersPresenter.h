//
//  PeekOffersPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeekOffersModuleInterface.h"
#import "PeekOffersViewInterface.h"
#import "PeekOffersInteractorIO.h"

@class PeekOffersWireframe;

@interface PeekOffersPresenter : NSObject<PeekOffersModuleInterface, PeekOffersInteractorOutput>

@property (nonatomic, strong) id<PeekOffersInteractorInput> interactor;
@property (nonatomic, strong) PeekOffersWireframe *wireframe;
@property (nonatomic, strong) UIViewController<PeekOffersViewInterface> *userInterface;

@end