//
//  ServicePopupModuleDelegateInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServicePopupModuleDelegate <NSObject>

- (void)servicePopupDidCancelAction;
- (void)servicePopupDidSubmitAction;

@end