//
//  MenuViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewUtils.h"
#import "VehiclesViewController.h"
#import "RightMenuCell.h"
#import "NSString+Color.h"
#import "UIView+Utils.h"
#import "ATMTabBarViewController.h"
#import "TabBarManager.h"

#define kButtonHeight 60
#define RightMenuCellIdentifier           @"RightMenuCell"

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic)NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UIView *englishView;
@property (weak, nonatomic) IBOutlet UIView *arabianView;
@property (weak, nonatomic) IBOutlet UIView *orangeLine;
@property (assign, nonatomic) AppLanguage appLanguage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadTexts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([ATMGlobal getAppLanguage] == AppLanguageArabian) {
        [self selectArabianAction:nil];
    } else {
        [self selectEnglishAction:nil];
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

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RightMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:RightMenuCellIdentifier];
    cell.imvIcon.image = [UIImage imageNamed:self.menuItems[indexPath.row][0]];
    cell.lbTitle.text = self.menuItems[indexPath.row][1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ATMTabBarViewController *tabbarVC = (ATMTabBarViewController *) self.mm_drawerController.centerViewController;
    switch (indexPath.row) {
        case 0:
            [tabbarVC showProfileInterface];
            //tabbarVC.tabBar.selectedItem = nil;
            [self deactiveAllTabBarItems];
            break;
            
        case 1:
            [tabbarVC showNewCarsInterface];
            [self deactiveAllTabBarItems];
            break;
            
        case 2:
            [tabbarVC showRoadsideAssistanceInterface];
            [self deactiveAllTabBarItems];
            break;
            
        case 3:
            [tabbarVC showOffersInterface];
            [self deactiveAllTabBarItems];
            break;
            
        case 4:
            [tabbarVC showEnquiryInterface];
            [self deactiveAllTabBarItems];
            break;
            
        case 5:
            [tabbarVC call800Motors];
            [self deactiveAllTabBarItems];
            break;
            
        case 6:
            [tabbarVC showAboutInterface];
            [self deactiveAllTabBarItems];
            break;
            
        default:
            break;
    }
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

#pragma mark - Actions
- (IBAction)selectEnglishAction:(id)sender {
    if (self.appLanguage == AppLanguageEnglish) {
        return;
    }
    
    self.appLanguage = AppLanguageEnglish;
    [ATMGlobal setAppLanguage:self.appLanguage];
    
    self.englishView.backgroundColor = [UIColor whiteColor];
    self.arabianView.backgroundColor = [@"#F6F6F6" representedColor];
    
    self.leftLineConstraint.constant = self.englishView.left;
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventLanguage
                            inScreenName:nil
                      withAdditionalData:@{@"newLanguage" : @"English"}];
    
    [self layoutByLanguage];
    
    // Reset the Application
    if (sender) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate startApplication];
    }
}

- (IBAction)selectArabianAction:(id)sender {
    if (self.appLanguage == AppLanguageArabian) {
        return;
    }
    
    self.appLanguage = AppLanguageArabian;
    [ATMGlobal setAppLanguage:self.appLanguage];
    
    self.englishView.backgroundColor = [@"#F6F6F6" representedColor];
    self.arabianView.backgroundColor = [UIColor whiteColor];
    
    self.leftLineConstraint.constant = self.arabianView.left;
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventLanguage
                            inScreenName:nil
                      withAdditionalData:@{@"newLanguage" : @"Arabic"}];
    
    [self layoutByLanguage];
    
    
    // Reset the application
    if (sender) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate startApplication];
    }
}

- (void)layoutByLanguage
{
    // Notify all other views update selected language
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageDidChange object:nil];
    
    [_tableView.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1)];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    [self reloadTexts];
}

- (void)reloadTexts
{
    self.menuItems = @[
                       @[@"icon_menu_profile", LOCALIZED(@"MENU PROFILE")],
                       @[@"icon_menu_new_cars", LOCALIZED(@"MENU NEW CARS")],
                       @[@"icon_menu_roadside", LOCALIZED(@"MENU ROADSIDE ASSISTANCE")],
                       @[@"icon_menu_offers", LOCALIZED(@"MENU SPECIAL OFFERS")],
                       @[@"icon_menu_enquiry", LOCALIZED(@"MENU SEND AN ENQUIRY")],
                       @[@"icon_menu_call", LOCALIZED(@"MENU CALL 800 MOTORS")],
                       @[@"icon_menu_about", LOCALIZED(@"MENU ABOUT")],
                       ];
    [self.tableView reloadData];
}

#pragma mark - Others
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
