//
//  VehiclesFilterWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesFilterWireframe.h"
#import "VehiclesFilterViewController.h"

static NSString *VehiclesFilterViewControllerIdentifier = @"VehiclesFilterViewController";

@implementation VehiclesFilterWireframe

- (void)presentFilterInController:(UINavigationController *)nc withData:(VehiclesFilterDisplayData *)data
{
    VehiclesFilterViewController *vc = [self filterViewControllerFromStoryboard];
    vc.data = data;
    [nc pushViewController:vc animated:YES];
}

- (VehiclesFilterViewController *)filterViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    VehiclesFilterViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:VehiclesFilterViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vehicles"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
