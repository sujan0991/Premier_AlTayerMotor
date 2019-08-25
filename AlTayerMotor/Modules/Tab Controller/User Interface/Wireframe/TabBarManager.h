//
//  TabBarManager.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuViewController;

@interface TabBarManager : NSObject

@property (nonatomic, strong) NSMutableArray *subViewControllers;
@property (nonatomic, strong) NSMutableArray *reversedSubViewControllers;
@property (nonatomic, strong) MenuViewController *menuVC;

+ (id)sharedManager;

@end
