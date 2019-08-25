//
//  TutorialWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "TutorialWireframe.h"
#import "TutorialViewController.h"
#import "AppDelegate.h"

static NSString *TutorialViewControllerIdentifier = @"TutorialViewController";

@interface TutorialWireframe()

@property (nonatomic, strong) TutorialViewController *tutorialVC;

@end

@implementation TutorialWireframe

- (void)presentTutorialInParentViewController:(UIViewController*)viewController
{
    TutorialViewController *tutorialVC = [self tutorialViewControllerFromStoryboard];
    self.tutorialVC = tutorialVC;
//    [viewController.view addSubview:self.tutorialVC.view];
//    [viewController addChildViewController:self.tutorialVC];
    [viewController presentViewController:tutorialVC animated:NO completion:nil];
//    [self.tutorialVC didMoveToParentViewController:viewController];
}

- (void)presentTutorialinWindow:(UIWindow *)window BeforeDrawController:(MMDrawerController *)drawerController {
    TutorialViewController *tutorialVC = [self tutorialViewControllerFromStoryboard];
    self.tutorialVC = tutorialVC;
    self.tutorialVC.window = window;
    tutorialVC.drawerController = drawerController;
    
    window.rootViewController = tutorialVC;
}

- (TutorialViewController *)tutorialViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    TutorialViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:TutorialViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}
@end
