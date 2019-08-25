//
//  ServicePopupPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicePopupPresenter.h"
#import "ServicePopupWireframe.h"

@implementation ServicePopupPresenter

- (void)cancelAction
{
    [self.wireframe dismissAddInterface];
    [self.delegate servicePopupDidCancelAction];
}

- (void)submitAction
{
    DLog(@"%@", self.delegate ? @"YES" : @"NO");
    [self.wireframe dismissAddInterface];
    [self.delegate servicePopupDidSubmitAction];
}

@end
