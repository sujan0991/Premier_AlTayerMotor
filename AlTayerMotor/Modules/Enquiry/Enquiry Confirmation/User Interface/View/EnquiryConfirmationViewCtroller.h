//
//  EnquiryConfirmationViewCtroller.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EnquiryConfirmationModuleInterface.h"
#import "EnquiryConfirmationViewInterface.h"

@interface EnquiryConfirmationViewCtroller : BaseViewController <EnquiryConfirmationViewInterface>
@property (nonatomic, strong) id<EnquiryConfirmationModuleInterface> eventHandler;
@end
