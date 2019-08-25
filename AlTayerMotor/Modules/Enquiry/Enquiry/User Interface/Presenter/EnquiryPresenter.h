//
//  EnquiryPresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EnquiryModuleInterface.h"
#import "EnquiryInteractorIO.h"

@protocol EnquiryViewInterface;
@class EnquiryWireframe;


@interface EnquiryPresenter : NSObject <EnquiryInteractorOutput, EnquiryModuleInterface>

@property (nonatomic, strong) EnquiryWireframe *wireframe;
@property (nonatomic, strong) BaseViewController<EnquiryViewInterface> *userInterface;
@property (nonatomic, strong) id<EnquiryInteractorInput> interactor;

@end
