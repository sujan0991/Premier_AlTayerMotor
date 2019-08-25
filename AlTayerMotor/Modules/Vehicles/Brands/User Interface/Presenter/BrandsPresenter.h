//
//  BrandsPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandsModuleInterface.h"
#import "BrandsViewInterface.h"
#import "BrandsInteractorIO.h"

@class BrandsWireframe;

@interface BrandsPresenter : NSObject<BrandsModuleInterface, BrandsInteractorOutput>

@property (nonatomic, strong) id<BrandsInteractorInput> interactor;
@property (nonatomic, strong) BrandsWireframe *wireframe;
@property (nonatomic, strong) UIViewController<BrandsViewInterface> *userInterface;

@end
