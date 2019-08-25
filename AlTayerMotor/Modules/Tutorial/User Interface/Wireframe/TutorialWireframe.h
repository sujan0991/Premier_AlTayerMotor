//
//  TutorialWireframe.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface TutorialWireframe : NSObject

- (void)presentTutorialInParentViewController:(UIViewController*)viewController;
- (void)presentTutorialinWindow:(UIWindow *)window BeforeDrawController:(MMDrawerController *)drawerController;

@end
