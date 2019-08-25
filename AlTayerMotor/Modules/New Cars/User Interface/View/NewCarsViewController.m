//
//  NewCarsViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarsViewController.h"
#import "NewCarCell.h"
#import "NewCarsModuleInterface.h"
#import "MBrand.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewUtils.h"
#import "NSString+Color.h"
#import "DZNWebViewController.h"
#import "NSString+Utils.h"

#define NewCarCellIdentifier                 @"NewCarCell"

@interface NewCarsViewController() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *brands;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NewCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self.eventHandler findAllBrands];
    [self layoutByLanguage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenNewCars];
    
    // Remove toolbar when back from webview
    [self.navigationController setToolbarHidden:YES];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (!parent) {
        [self activeAllTabBarItems];
    }
}

#pragma mark - Updating UI
- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_tableView);
}

- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"MENU NEW CARS");
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20, 0.0);
    
    // config gradient background
    [self.view setBackGroundGradientFromColor:[@"22416b" representedColor]
                                      toColor:[@"071f3d" representedColor]];
}

#pragma mark - View Interface
- (void)foundAllBrands:(NSArray *)brands
{
    self.brands = brands;
    [self.tableView reloadData];
}

#pragma mark - Table View Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brands.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 78.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 78)];
//    view.backgroundColor = [@"#21416A" representedColor];
//    view.backgroundColor = [UIColor clearColor];
    [view setBackGroundGradientFromColor:[@"22416b" representedColor]
                                 toColor:[@"1f3d66" representedColor]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 21, screenWidth - 30, 57)];
    [view addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                    withRadii:CGSizeMake(8, 8)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, bgView.width - 24, bgView.height)];
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    label.text = LOCALIZED(@"TEXT NEW CARS TITLE");
    label.textColor = [@"777777" representedColor];
    label.font = [UIFont systemFontOfSize:13.f];
    [bgView addSubview:label];
    
//    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, bgView.width - 24, bgView.height)];
//    imv.contentMode = UIViewContentModeScaleAspectFit;
//    imv.image = [UIImage imageNamed:@"new_cars_title"];
//    [bgView addSubview:label];
    
    AFFINE_TRANSFORM(label);
    TEXT_ALIGN(label);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewCarCell *cell = [tableView dequeueReusableCellWithIdentifier:NewCarCellIdentifier];
    MBrand *brand = self.brands[indexPath.row];
    cell.lbBrand.text = [brand.name uppercaseString];
    [cell.imvBrand sd_setImageWithURL:[NSURL URLWithString:[brand.logo toImageLink]]
                      placeholderImage:[UIImage imageNamed:@"icon_placeholder_brand"]];
    
    cell.lineView.hidden = (self.brands.count - 1 == indexPath.row);
    cell.lastRow = (self.brands.count - 1 == indexPath.row);
    cell.btnWeb.tag = indexPath.row;
    cell.btnBooking.tag = indexPath.row;
    [cell.btnBooking addTarget:self
                     action:@selector(bookingAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [cell.btnWeb addTarget:self
                        action:@selector(viewWebAction:)
              forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - Action
- (IBAction)bookingAction:(id)sender
{
    NSInteger index = [sender tag];
    MBrand *brand = self.brands[index];
    [self.eventHandler presentBookingTestWithBrand:brand];
}

- (IBAction)viewWebAction:(id)sender
{
    NSInteger index = [sender tag];
    MBrand *brand = self.brands[index];
    [self.eventHandler presentWebViewWithUrl:brand.url];
}

@end
