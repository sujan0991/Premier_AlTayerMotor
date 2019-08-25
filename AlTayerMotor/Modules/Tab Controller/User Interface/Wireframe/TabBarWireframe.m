//
//  TabbarWireframe.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "TabBarWireframe.h"
#import "TabBarManager.h"
#import "MMDrawerController.h"

#import "ATMTabBarViewController.h"
#import "ATMGlobal.h"
#import "AppDelegate.h"
#import "CoreDataStore.h"
#import "DateManager.h"

#import "MenuViewController.h"
#import "MMDrawerVisualState.h"

#import "VehiclesViewController.h"
#import "VehiclesWireframe.h"
#import "VehiclesPresenter.h"
#import "VehiclesInteractor.h"
#import "VehiclesDataManager.h"

#import "BookingTestWireframe.h"
#import "BookingServiceWireframe.h"
#import "InsuranceWireframe.h"
#import "LocationWireframe.h"
#import "MenuWireframe.h"
#import "TutorialWireframe.h"
#import "ReminderWireframe.h"
#import "ServicesWireframe.h"
#import "LatestOffersWireframe.h"
#import "RegisteredVehicle.h"
#import "BrandsWireframe.h"

static NSString *MenuViewControllerIdentifier = @"MenuViewController";

@interface TabBarWireframe()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation TabBarWireframe

- (void)presentTabbarInterfaceFromWindow:(UIWindow *)window
{
    [[[TabBarManager sharedManager] subViewControllers] removeAllObjects];
    [[[TabBarManager sharedManager] reversedSubViewControllers] removeAllObjects];
    
    MenuWireframe *menuWireframe = [MenuWireframe new];
    [menuWireframe initMenuViewController];
    
    // SERVICE
//    BookingServiceWireframe *bookingServiceWireframe = [BookingServiceWireframe new];
//    [bookingServiceWireframe initBookingServiceViewController];
    ServicesWireframe *servicesWireframe = [ServicesWireframe new];
    [servicesWireframe initServicesViewController];
    
    // BOOKING TEST
    BookingTestWireframe *bookingTestWireframe = [BookingTestWireframe new];
    [bookingTestWireframe initBookingTestViewController];
    
    // LOCATION
    LocationWireframe *locationWireframe = [LocationWireframe new];
    [locationWireframe initLocationViewController];
    
    // INSURANCE
    InsuranceWireframe *insuranceWireframe = [InsuranceWireframe new];
    [insuranceWireframe initInsuranceViewController];
    
    // PRE-OWNED
    BrandsWireframe *latestOffersWireframe = [BrandsWireframe new];
    [latestOffersWireframe initInsuranceViewController];
    
    NSArray *reversed = [[[[TabBarManager sharedManager] subViewControllers] reverseObjectEnumerator] allObjects];
    [[[TabBarManager sharedManager] reversedSubViewControllers] addObjectsFromArray:reversed];
    
    ATMTabBarViewController *tabbarVC = [ATMTabBarViewController new];
    tabbarVC.viewControllers = [ATMGlobal isEnglish] ? [[TabBarManager sharedManager] subViewControllers] : [[TabBarManager sharedManager] reversedSubViewControllers];
    tabbarVC.selectedIndex = [ATMGlobal isEnglish] ? 4 : 0;
    
    // MENU
    MenuViewController *menuVC = [self menuViewControllerFromStoryboard];
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:tabbarVC
                             leftDrawerViewController:nil
                             rightDrawerViewController:menuVC];
    
    [self.drawerController setShowsShadow:NO];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [self.drawerController setMaximumRightDrawerWidth:(screenWidth - 50.f)];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setShowsStatusBarBackgroundView:NO];
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock visualStateBlock = [MMDrawerVisualState slideVisualStateBlock];
         visualStateBlock(drawerController, drawerSide, percentVisible);
         drawerController.centerViewController.view.alpha = MAX(0.1, 1.0 - percentVisible);
     }];

    if (![ATMGlobal hasShownTutorial]) {
        TutorialWireframe *tutorialWireframe = [TutorialWireframe new];
        [tutorialWireframe presentTutorialinWindow:window BeforeDrawController:self.drawerController];
        [ATMGlobal setShownTutorial];
    } else {
        window.rootViewController = self.drawerController;
    }

    // REMINDER LOGIC
    NSArray* registeredVehicles = [[CoreDataStore sharedStore] expiredRegisteredVehicles];
    if (registeredVehicles.count > 0) {
        RegisteredVehicle *vehicle = registeredVehicles[0];
        ReminderWireframe *reminderWireframe = [ReminderWireframe new];
        [reminderWireframe presentReminderInParentViewController:tabbarVC withDate:vehicle.registration_expiry];
    }
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
