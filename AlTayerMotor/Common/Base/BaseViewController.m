//
//  BaseViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"
#import "FRDLivelyButton.h"
#import "TabBarManager.h"
#import "MenuViewController.h"
#import "ViewUtils.h"
#import "UIViewController+EmptyBackButton.h"
#import "DGActivityIndicatorView.h"

@interface BaseViewController ()
@property (nonatomic, strong) UIBarButtonItem *btnMenu;
@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"AL TAYER MOTORS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
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

- (void)addRightMenuWithAction:(SEL)action inController:(UIViewController*)controller
{
    UIImage *image = [UIImage imageNamed:@"icon_menu"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    self.btnMenu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = self.btnMenu;
}

- (void)addLeftMenuWithAction:(SEL)action inController:(UIViewController*)controller
{
    UIImage *image = [UIImage imageNamed:@"icon_close_white"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    self.btnMenu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = self.btnMenu;
}

- (IBAction)toggleMenu:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)showMessage:(NSString *)message
{
    if (message && message.length > 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:LOCALIZED(@"TEXT OK") style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
        
    }
}

- (void)showBlankMessage:(NSString *)field {
    NSString *message = [NSString stringWithFormat:@"%@ could not be blank", field];
    [self showMessage:message];
}

- (void)showLoadingIndicator
{
    if (!_activityIndicatorView) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor] size:20.0f];
        _activityIndicatorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, screenRect.size.width, screenRect.size.height);
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.window.rootViewController.view addSubview:_activityIndicatorView];
    }
    
    [_activityIndicatorView startAnimating];
}

- (void)hideLoadingEndicator
{
    if (_activityIndicatorView) {
        [_activityIndicatorView stopAnimating];
        [_activityIndicatorView removeFromSuperview];
        _activityIndicatorView = nil;
    }
}

- (void)activeAllTabBarItems {
    NSArray * vcs = [[TabBarManager sharedManager] subViewControllers];
    
    //
    NSArray *images = @[@"tabbar_service", @"tabbar_wheel", @"tabbar_location", @"tabbar_insurance", @"tabbar_vehicle"];
    NSArray *selImages = @[@"tabbar_service_selected", @"tabbar_wheel_selected", @"tabbar_location_selected", @"tabbar_insurance_selected", @"tabbar_vehicle_selected"];
    
    [vcs enumerateObjectsUsingBlock:^(UINavigationController *nc, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *musicImage = [UIImage imageNamed:images[idx]];
        UIImage *musicImageSel = [UIImage imageNamed:selImages[idx]];
        musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nc.tabBarItem.image = musicImage;
        nc.tabBarItem.selectedImage = musicImageSel;
        [nc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}
                                     forState:UIControlStateSelected];
    }];
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
