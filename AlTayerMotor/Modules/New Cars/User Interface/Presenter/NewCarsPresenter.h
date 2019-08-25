//
//  NewCarsPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "NewCarsModuleInterface.h"
#import "NewCarsInteractorIO.h"

@protocol NewCarsViewInterface;
@class NewCarsWireframe;

@interface NewCarsPresenter : NSObject<NewCarsInteractorOutput, NewCarsModuleInterface>

@property (nonatomic, strong) id<NewCarsInteractorInput> interactor;
@property (nonatomic, strong) BaseViewController<NewCarsViewInterface> *userInterface;
@property (nonatomic, strong) NewCarsWireframe *wireframe;

@end