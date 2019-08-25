//
//  ReminderWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ReminderWireframe.h"
#import "ReminderViewController.h"

static NSString *ReminderViewControllerIdentifier = @"ReminderViewController";

@interface ReminderWireframe()
@property (nonatomic, strong) ReminderViewController *reminderVC;
@end

@implementation ReminderWireframe

- (void)presentReminderInParentViewController:(UIViewController*)viewController withDate:(NSString *)dateStr
{
    ReminderViewController *reminderVC = [self tutorialViewControllerFromStoryboard];
    reminderVC.dateStr = dateStr;
    self.reminderVC = reminderVC;
    [viewController.view addSubview:self.reminderVC.view];
    [viewController addChildViewController:self.reminderVC];
    [self.reminderVC didMoveToParentViewController:viewController];
}

- (ReminderViewController *)tutorialViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    ReminderViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ReminderViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
