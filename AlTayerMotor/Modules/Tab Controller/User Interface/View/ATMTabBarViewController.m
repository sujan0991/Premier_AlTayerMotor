//
//  ATMTabBarViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMTabBarViewController.h"
#import "ATMGlobal.h"
#import "CoreDataStore.h"
#import "TabBarManager.h"

#import "TutorialWireframe.h"
#import "ProfileWireframe.h"
#import "NewCarsWireframe.h"
#import "EnquiryWireframe.h"
#import "RoadsideWireframe.h"
#import "OffersWireframe.h"

#import "AboutViewController.h"
#import "ProfileViewController.h"
#import "NewCarsViewController.h"
#import "EnquiryViewController.h"
#import "RoadsideViewController.h"
#import "OffersViewController.h"
#import "ServicesViewController.h"
#import "LatestOffersViewController.h"
#import "InsuranceViewController.h"
#import "LocationViewController.h"
#import "BookingTestViewController.h"
#import "ServicesViewController.h"
#import "CustomWebViewController.h"
#import <Crashlytics/Crashlytics.h>


static NSString *AboutViewControllerIdentifier = @"AboutViewController";

@interface ATMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation ATMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // Test Crashlystic work
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(20, 50, 100, 30);
//    [button setTitle:@"Crash" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (IBAction)crashButtonTapped:(id)sender {
    [[Crashlytics sharedInstance] crash];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutByLanguage
{
    self.viewControllers = [ATMGlobal isEnglish] ? [[TabBarManager sharedManager] subViewControllers] : [[TabBarManager sharedManager] reversedSubViewControllers];
    for (UINavigationController *nc in self.viewControllers) {
        UIViewController *rootVC = [[nc viewControllers] firstObject];
        if ([rootVC isKindOfClass:[LatestOffersViewController class]]) {
            nc.tabBarItem.title = LOCALIZED(@"TAB PRE-OWNED");
        } else if ([rootVC isKindOfClass:[InsuranceViewController class]]) {
            nc.tabBarItem.title = LOCALIZED(@"TAB INSURANCE");
        } else if ([rootVC isKindOfClass:[LocationViewController class]]) {
            nc.tabBarItem.title = LOCALIZED(@"TAB LOCATIONS");
        } else if ([rootVC isKindOfClass:[BookingTestViewController class]]) {
            nc.tabBarItem.title = LOCALIZED(@"TAB TEST DRIVE");
        } else if ([rootVC isKindOfClass:[ServicesViewController class]]) {
            nc.tabBarItem.title = LOCALIZED(@"TAB SERVICES");
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showProfileInterface
{
    UINavigationController *nc = [self activeNavigationController];
    ProfileWireframe *wireframe = [ProfileWireframe new];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[ProfileViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [wireframe presentProfileInterfaceFromViewController:nc];
        
        [self deactiveAllTabBarItems];
    }];
}

- (void)showNewCarsInterface
{
    UINavigationController *nc = [self activeNavigationController];
    NewCarsWireframe *wireframe = [NewCarsWireframe new];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[NewCarsViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [wireframe presentNewCarsInterfaceFromViewController:nc];
        
        [self deactiveAllTabBarItems];
    }];
}

- (void)showRoadsideAssistanceInterface
{
    UINavigationController *nc = [self activeNavigationController];
    RoadsideWireframe *wireframe = [RoadsideWireframe new];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[RoadsideViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [wireframe presentRoadsideInterfaceFromViewController:nc];
        
        [self deactiveAllTabBarItems];
    }];
}

- (void)showOffersInterface
{
    UINavigationController *nc = [self activeNavigationController];
    OffersWireframe *wireframe = [OffersWireframe new];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[OffersViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [wireframe presentOffersInterfaceInNavigation:nc];
        
        [self deactiveAllTabBarItems];
    }];
}

- (void)showEnquiryInterface
{
    UINavigationController *nc = [self activeNavigationController];
    EnquiryWireframe *wireframe = [EnquiryWireframe new];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[EnquiryViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [wireframe presentEnquiryInterfaceFromViewController:nc];
        
        [self deactiveAllTabBarItems];
    }];
}

- (void)call800Motors
{
//    [ATMGlobal callPhoneNumber:kContact800];
    [ATMGlobal callDealer];
}

- (void)showAboutInterface
{
    AboutViewController *aboutVC = [self aboutViewControllerFromStoryboard];
    UINavigationController *nc = [self activeNavigationController];
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        if ([nc.visibleViewController isKindOfClass:[AboutViewController class]]) {
            return;
        }
        
        [self removeOverlayScreens];
        
        [nc pushViewController:aboutVC animated:YES];
        
        [self deactiveAllTabBarItems];
    }];
}

- (UINavigationController *)activeNavigationController
{
    return self.viewControllers[self.selectedIndex];
}

- (AboutViewController *)aboutViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    AboutViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:AboutViewControllerIdentifier];
    
    return viewController;
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if (tabBarController.selectedIndex == 0) {
        UINavigationController *navigationControllers = (UINavigationController *)viewController;
        if (navigationControllers.viewControllers.count == 2) {
            NSArray *registeredVehicles = [[CoreDataStore sharedStore] fetchAllRegisteredVehicles];
            if (registeredVehicles.count == 0) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self removeOverlayScreens];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    UINavigationController *nc = self.viewControllers[self.selectedIndex];
//    [nc popToRootViewControllerAnimated:NO];
}

#pragma mark - Others
#pragma mark - Others
- (void)removeOverlayScreens
{
    UINavigationController *nc = [self activeNavigationController];
    while ([nc.visibleViewController isKindOfClass:[ProfileViewController class]] ||
           [nc.visibleViewController isKindOfClass:[AboutViewController class]] ||
           [nc.visibleViewController isKindOfClass:[EnquiryViewController class]] ||
           [nc.visibleViewController isKindOfClass:[RoadsideViewController class]] ||
           [nc.visibleViewController isKindOfClass:[OffersViewController class]] ||
           [nc.visibleViewController isKindOfClass:[NewCarsViewController class]] ||
           [nc.visibleViewController isKindOfClass:[CustomWebViewController class]]
           ) {
        [nc popViewControllerAnimated:NO];
    }
}

- (UINavigationController *)getPreownedTab;
{
    [self setSelectedIndex:([ATMGlobal isEnglish] ? 4 : 0)];
    return [ATMGlobal isEnglish] ? self.viewControllers[4] : self.viewControllers[0];
}

- (void)deactiveAllTabBarItems {
    NSArray * vcs = [[TabBarManager sharedManager] subViewControllers];
    
    //
    NSArray *images = @[@"tabbar_service", @"tabbar_wheel", @"tabbar_location", @"tabbar_insurance", @"tabbar_vehicle"];
    
    [vcs enumerateObjectsUsingBlock:^(UINavigationController *nc, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *musicImage = [UIImage imageNamed:images[idx]];
        UIImage *musicImageSel = [UIImage imageNamed:images[idx]];
        musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nc.tabBarItem.image = musicImage;
        nc.tabBarItem.selectedImage = musicImage;
        [nc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.7 alpha:0.8]}
                                     forState:UIControlStateSelected];
    }];
}

@end
