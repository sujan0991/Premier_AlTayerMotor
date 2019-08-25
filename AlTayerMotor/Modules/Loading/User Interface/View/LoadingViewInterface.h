//
//  LoadingViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoadingViewInterface <NSObject>

- (void)startLoadingIndicator;
- (void)stopLoadingIndicator;
- (void)showAlertMessage:(NSString *)message;
- (void)doEntranceAnimation;
- (void)doExitAnimation;

@end
