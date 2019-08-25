//
//  LoadingModuleInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoadingModuleInterface <NSObject>

- (void)showNextInterface;
- (void)showFirstTimeInterface;
- (void)showMainInterface;
- (void)generateToken;

@end
