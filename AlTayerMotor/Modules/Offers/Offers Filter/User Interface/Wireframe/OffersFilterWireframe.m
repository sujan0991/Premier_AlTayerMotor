//
//  OffersFilterWireframe.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersFilterWireframe.h"
#import "OffersFilterViewController.h"

static NSString *OffersFilterViewControllerIdentifier = @"OffersFilterViewController";

@implementation OffersFilterWireframe

- (void)presentFilterInterfaceInNavigation:(UINavigationController *)nc
                                  withData:(OffersFilterDisplayData *)data
{
    OffersFilterViewController *vc = [self filterViewControllerFromStoryboard];
    vc.data = data;
    [nc pushViewController:vc animated:YES];
}

- (OffersFilterViewController *)filterViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    OffersFilterViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:OffersFilterViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Offers"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
