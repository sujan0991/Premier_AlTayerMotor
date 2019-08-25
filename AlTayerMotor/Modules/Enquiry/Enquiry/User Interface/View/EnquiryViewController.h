//
//  EnquiryViewController.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "EnquiryViewInterface.h"

@protocol EnquiryModuleInterface;

@interface EnquiryViewController : BaseViewController <EnquiryViewInterface>

@property (nonatomic, strong) id<EnquiryModuleInterface> eventHandler;

@end
