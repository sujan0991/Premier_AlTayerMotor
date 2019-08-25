//
//  LoadingWireframe.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RootWireframe;
@class FirstTimeWireframe;
@class LoadingPresenter;
@class TabBarWireframe;
@interface LoadingWireframe : NSObject

@property (nonatomic, strong) LoadingPresenter *loadingPresenter;
@property (nonatomic, strong) RootWireframe *rootWireframe;
@property (nonatomic, weak) FirstTimeWireframe *firstTimeWireframe;
@property (nonatomic, strong) TabBarWireframe *tabBarWireframe;

- (void)presentListInterfaceFromWindow:(UIWindow *)window;
- (void)presentFirstTimeWireframe;
- (void)presentTabBarInteface;

@end
