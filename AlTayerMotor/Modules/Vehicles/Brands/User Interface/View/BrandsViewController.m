//
//  BrandsViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsViewController.h"
#import "BrandsModuleInterface.h"
#import "BrandsDisplayData.h"
#import "BrandCell.h"
#import "BrandTitleCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MPreownedBrand.h"
#import "UIView+Roundify.h"
#import "NSString+Color.h"
#import "NSString+Utils.h"
#import "ViewUtils.h"
#import "MUser.h"

#define ExplorerCellIdentifier              @"BrandTitleCell"
#define BrandCellIdentifier                 @"BrandCell"

@interface BrandsViewController()

@property (nonatomic, strong) BrandsDisplayData *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MUser *user;

@end

@implementation BrandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    [self updateNavigationTitle];
    [self.eventHandler findUserInfo];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                                object:nil];
    
    // config gradient background
    [self.view setBackGroundGradientFromColor:[@"22416b" representedColor]
                                      toColor:[@"081f3c" representedColor]];
//    [self layoutByLanguage];
}

- (void)layoutByLanguage {
    [_tableView.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1)];
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
    [self layoutByLanguage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutByLanguage];
}

- (void)updateNavigationTitle
{
    self.navigationItem.title = LOCALIZED(@"TITLE PRE-OWNED");
//    if (self.user && ![self.user.firstName isInvalid]) {
//        self.navigationItem.title = [NSString stringWithFormat:@"%@%@ %@", LOCALIZED(@"TEXT WELCOME"), ([ATMGlobal isEnglish] ? @"," : @"،"), self.user.firstName];
//    }
}

#pragma mark - User Interface
- (void)showBrandsDisplayData:(BrandsDisplayData *)data
{
    self.data = data;
    [self reloadEntries];
}

- (void)reloadEntries
{
    for (MPreownedBrand *brand in self.data.brands) {
        DLog(@"%@", brand.noPreownedMessage);
    }
    [self.tableView reloadData];
}

- (void) showUserInfo:(MUser *)user
{
    self.user = user;
    [self updateNavigationTitle];
}

#pragma mark - TableView Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.brands.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 40;
    }
    
    return 62;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BrandTitleCell * cell = [self.tableView dequeueReusableCellWithIdentifier:ExplorerCellIdentifier];
        return cell;
    }
    
    MPreownedBrand *brand = self.data.brands[indexPath.row - 1];
    BrandCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BrandCellIdentifier];
    
    [cell.imvLogo sd_setImageWithURL:[NSURL URLWithString:[brand.logo toImageLink]]
                    placeholderImage:[UIImage imageNamed:@"icon_placeholder_brand"]];
    cell.lbName.text = [brand.name uppercaseString];
    cell.lastRow = (self.data.brands.count == indexPath.row);
    cell.line.hidden = cell.lastRow;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row > 0) {
        MPreownedBrand *brand = self.data.brands[indexPath.row - 1];
        [self.eventHandler presentVehiclesInterfaceWithData:brand];
    }
}

@end
