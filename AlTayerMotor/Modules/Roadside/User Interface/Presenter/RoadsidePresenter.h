//
//  RoadsidePresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "RoadsideModuleInterface.h"
#import "RoadsideInteractorIO.h"

@protocol RoadsideViewInterface;
@class RoadsideWireframe;

@interface RoadsidePresenter : NSObject<RoadsideInteractorOutput, RoadsideModuleInterface>

@property (nonatomic, strong) id<RoadsideInteractorInput> interactor;
@property (nonatomic, strong) BaseViewController<RoadsideViewInterface> *userInterface;
@property (nonatomic, strong) RoadsideWireframe *wireframe;

@end
