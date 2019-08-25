//
//  NewCarsPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarsPresenter.h"
#import "NewCarsViewInterface.h"
#import "ATMTabBarViewController.h"
#import "BookingTestViewController.h"
#import "CustomWebViewController.h"

@implementation NewCarsPresenter

#pragma mark - Module Interface
- (void)findAllBrands
{
    [self.interactor findAllBrands];
}

- (void)presentWebViewWithUrl:(NSString *)brandUrl
{
    NSURL *url = [NSURL URLWithString:kURLHttpDomain];
    if (brandUrl && brandUrl.length > 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@%@", [ATMGlobal getImageLink], brandUrl]];
    }
    
    CustomWebViewController *webVC = [[CustomWebViewController alloc] initWithURL:url];
    webVC.supportedWebNavigationTools = DZNWebNavigationToolAll;
    webVC.supportedWebActions = DZNWebActionAll;
    webVC.showLoadingProgress = NO;
    webVC.allowHistory = YES;
    webVC.hideBarsWithGestures = NO;
    webVC.navigationItem.hidesBackButton = YES;
    [self.userInterface.navigationController setToolbarHidden:NO];
    
    [self.userInterface.navigationController pushViewController:webVC
                                                       animated:YES];
}

-(void)presentBookingTestWithBrand:(MBrand *)brand
{
    // Change tab
    ATMTabBarViewController *tabBarController = (ATMTabBarViewController *) self.userInterface.tabBarController;
    [tabBarController setSelectedIndex:[ATMGlobal isEnglish] ? 1 : 3];
    
    UINavigationController *navController =  tabBarController.viewControllers[[ATMGlobal isEnglish] ? 1 : 3];
    [navController popToRootViewControllerAnimated:NO];
    BookingTestViewController *viewController = (BookingTestViewController *)navController.viewControllers.firstObject;
    if ([viewController isKindOfClass:[BookingTestViewController class]]) {
        [viewController didClearForm];
        [viewController setInitializeBrand:brand]; // For case booking form is not initialized
        [viewController didSelectBrand:brand];
    }
    
    // reset this insurance
    [self.userInterface.navigationController popViewControllerAnimated:NO];
}

#pragma mark - View Interface
- (void)foundAllBrands:(NSArray *)brands
{
    [self.userInterface foundAllBrands:brands];
}

@end
