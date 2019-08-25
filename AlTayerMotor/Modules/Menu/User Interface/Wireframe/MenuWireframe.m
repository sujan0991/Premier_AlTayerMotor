//
//  MenuWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MenuWireframe.h"
#import "MenuViewController.h"
#import "TabBarManager.h"

static NSString *MenuViewControllerIdentifier = @"MenuViewController";

@implementation MenuWireframe

- (void)initMenuViewController
{
    MenuViewController *menuVC = [self menuViewControllerFromStoryboard];
    [[TabBarManager sharedManager] setMenuVC:menuVC];
}

- (MenuViewController *)menuViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    MenuViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:MenuViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
