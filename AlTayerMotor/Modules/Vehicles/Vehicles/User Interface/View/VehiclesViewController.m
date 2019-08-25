//
//  VehiclesViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesViewController.h"
#import "PWParallaxScrollView.h"
#import "DGActivityIndicatorView.h"
#import "CustomWebViewController.h"

#import "BrandOfferCell.h"
#import "VehicleCell.h"
#import "VehiclesFilterCell.h"
#import "EmptyVehicleCell.h"
#import "LogoCell.h"

#import "VehiclesDisplayData.h"
#import "BrandOffersDisplayData.h"
#import "VehiclesFilterDisplayData.h"

#import "MPreownedBrand.h"
#import "MOffer.h"
#import "MVehicle.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "UINavigationController+StatusBarStyle.h"
#import "NSString+Color.h"
#import "NSString+Utils.h"

#define kOffersCell @"BrandOfferCell"
#define kFilterCell @"VehiclesFilterCell"
#define kVehicleCell @"VehicleCell"
#define kEmptyCell  @"EmptyVehicleCell"
#define kLogoCell  @"LogoCell"

#define kOfferCellHeight    300.0f
#define kFilterCellHeight   67.0f
#define kVehicleCellHeight  300.f
#define kEmptyCellHeight    150.f
//#define kLogoCellHeight     128.f
#define kLogoCellHeight     0.f

@interface VehiclesViewController() <UITableViewDataSource, UITableViewDelegate, BrandOfferCellDelegate, UIWebViewDelegate>

@property (nonatomic, strong) VehiclesDisplayData *vehiclesData;
@property (nonatomic, strong) BrandOffersDisplayData *offersData;
@property (nonatomic, strong) VehiclesFilterDisplayData *filterData;
@property (nonatomic, strong) VehicleModelsDisplayData *vehicleModelsData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DGActivityIndicatorView *indicatorView;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (weak, nonatomic) IBOutlet UIImageView *imvLogo;
@property (assign) BOOL isOnFiltering;
@end

@implementation VehiclesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
    NSMutableArray *offers = [@[] mutableCopy];
    self.offersData = [[BrandOffersDisplayData alloc] initWithOffers:offers];
    _vehiclesData = [[VehiclesDisplayData alloc] initWithVehicles:@[]];
    self.filterData = [VehiclesFilterDisplayData new];
    [self.eventHandler loadAllVehicleModelsInBrandId:self.brand.id];
    self.filterData.oldestYear = self.brand.oldestYear;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
}



- (void)layoutByLanguage
{
    [_tableView.layer setAffineTransform:LANGUAGE_TRANSFORM];
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
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
    self.isOnFiltering = (_filterData && _filterData.filterChanged);
    [self.eventHandler getOffers];
    [self.eventHandler getVehicles];
//    [self layoutByLanguage];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenPreowned];
    
    // Remove toolbar when back from webview
//    [self.navigationController setToolbarHidden:YES];
//    self.navigationItem.hidesBackButton = YES;
    
    // active tabbar
    [self activeAllTabBarItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self layoutByLanguage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationItem.hidesBackButton = NO;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UI
- (void)setupViews
{
    [self layoutByLanguage];
    
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = self.brand.name;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20, 0.0);
    
    self.numberFormatter = [[NSNumberFormatter alloc]init];
    [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.numberFormatter setGroupingSeparator:@","];
    [self.numberFormatter setGroupingSize:3];
}

#pragma mark - View Interface
- (void)updateVehicleModelsData:(VehicleModelsDisplayData *)data
{
    if (!self.filterData) {
        self.filterData = [VehiclesFilterDisplayData new];
        self.filterData.oldestYear = self.brand.oldestYear;
    }
    
    self.vehicleModelsData = data;
    self.filterData.modelsData = self.vehicleModelsData;
}

- (VehiclesDisplayData *)getVehiclesData
{
    if (!_vehiclesData) {
        _vehiclesData = [[VehiclesDisplayData alloc] initWithVehicles:@[]];
    }
    return _vehiclesData;
}

- (void)reloadVehiclesData
{
    [self.tableView reloadData];
}

- (NSInteger)getCurrentBrandId
{
    return self.brand.id;
}
- (VehiclesFilterDisplayData *)getFilterData
{
    return self.filterData;
}

- (MPreownedBrand *)getCurrentBrand
{
    return self.brand;
}

- (BrandOffersDisplayData *)getOffersData
{
    return self.offersData;
}

#pragma mark - TableView Delegate & Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_vehiclesData.vehicles.count ?: 1) + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        if (self.offersData && self.offersData.offers && self.offersData.offers.count > 0) {
//            return 128 + [ATMGlobal offerImageHeight];
//        } else {
//            return kLogoCellHeight;
//        }
//    } else if (indexPath.row == 1) {
        if (!_vehiclesData.vehicles.count) {
            return 51;
        }
        
        CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 32, 20000.0f);
        CGSize size;
        
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize boundingBox = [[ATMGlobal preownedDisclaimerMessage] boundingRectWithSize:constraint
                                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                                              attributes:@{NSFontAttributeName:[UIFont italicSystemFontOfSize:15]}
                                                                                 context:context].size;
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        return kFilterCellHeight + size.height;
    } else if (!_vehiclesData.vehicles.count) {
        return kEmptyCellHeight;
    } else {
        return kVehicleCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        if (self.offersData && self.offersData.offers && self.offersData.offers.count > 0) {
//            BrandOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:kOffersCell];
//            cell.delegate = self;
//            [cell setOffersData:self.offersData];
//            
//            return cell;
//        } else {
//            LogoCell *logoCell = [tableView dequeueReusableCellWithIdentifier:kLogoCell];
//            if (self.brand) {
//                [logoCell.imvLogo sd_setImageWithURL:[NSURL URLWithString:[_brand.logo toImageLink]]
//                                    placeholderImage:[UIImage imageNamed:@"first_time_logo"]];
//            }
//            return logoCell;
//        }
//        
//    } else if (indexPath.row == 1) {
        VehiclesFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:kFilterCell];
        [cell.btnAllVehicles addTarget:self action:@selector(clearFilterAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDisclaimerMsg addTarget:self action:@selector(blankAction:) forControlEvents:UIControlEventTouchUpInside];
//        cell.lbDisclaimerMsg.text = [ATMGlobal preownedDisclaimerMessage];
        cell.lbDisclaimerMsg.attributedText = [[NSAttributedString alloc]
                                               initWithString: [ATMGlobal preownedDisclaimerMessage]
                                               attributes: @{
                                                             NSFontAttributeName: [UIFont italicSystemFontOfSize:
                                                                                   [UIFont systemFontSize]]}];
        cell.disclaimerMsgHeightConstraint.constant = [self tableView:tableView heightForRowAtIndexPath:indexPath] - kFilterCellHeight;
        cell.lbFilter.font = self.isOnFiltering ? [UIFont boldSystemFontOfSize:17.0] : [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        cell.lbFilterType.font = !self.isOnFiltering ? [UIFont boldSystemFontOfSize:17.0] : [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        return cell;
    } else if (!_vehiclesData.vehicles.count) {
        EmptyVehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmptyCell];
        cell.indicator.hidden = ![self.eventHandler isLoadingAtFirstPage];
        cell.imvCar.hidden = [self.eventHandler isLoadingAtFirstPage];
        cell.lbEmpty.hidden = [self.eventHandler isLoadingAtFirstPage];
        cell.wvEmpty.hidden = [self.eventHandler isLoadingAtFirstPage];
        cell.wvEmpty.delegate = self;
        cell.wvEmpty.scrollView.scrollEnabled = NO;
        cell.wvEmpty.scrollView.bounces = NO;
        [cell.wvEmpty setBackgroundColor:[UIColor clearColor]];
        [cell.wvEmpty setOpaque:NO];
        NSString *data = [NSString stringWithFormat:@"<span style=\"font-family:'-apple-system','HelveticaNeue'; font-size: %i\">%@</span>", 15, _brand.noPreownedMessage];
        [cell.wvEmpty loadHTMLString:data baseURL:nil];
        if (![cell.indicator isAnimating]) {
            [cell.indicator startAnimating];
        }
        return cell;
    } else {
        MVehicle *vehicle = _vehiclesData.vehicles[indexPath.row - 1];
        VehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:kVehicleCell];
        cell.lbPrice.text = [NSString stringWithFormat:@"%@ %@", [vehicle getCurrency], [self.numberFormatter stringFromNumber:@(vehicle.price)]];
        cell.lbModelYear.text = [NSString stringWithFormat:@"%ld", (long)vehicle.year];
        cell.lbBrand.text = [NSString stringWithFormat:@"%@",vehicle.model];
        cell.lbMileage.text = [NSString stringWithFormat:@"%ld", (long)vehicle.mileage];
        cell.lbModelYeardt.text = [NSString stringWithFormat:@"%ld", (long)vehicle.year];
        cell.lbTrim.text = [NSString stringWithFormat:@"%@", vehicle.trim];
        cell.lbColor.text = [NSString stringWithFormat:@"%@", vehicle.color];
        
        [cell.imvVehicle sd_setImageWithURL:[NSURL URLWithString:[vehicle imageLink]]
                           placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
        
        if (indexPath.row - 1 == _vehiclesData.vehicles.count) {
            [self.eventHandler getVehicles];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {

//    } else if (indexPath.row == 1) {
        self.filterData.filterChanged = NO;
        [self.eventHandler presentFilterInterfaceWithData:self.filterData];
    } else if (!_vehiclesData.vehicles.count) {
        [self.eventHandler resetHasLoadMore];
        [self.eventHandler getVehicles];
    } else {
        MVehicle *vehicle = _vehiclesData.vehicles[indexPath.row - 1];
        [self.eventHandler presentDetailsInterfaceWithData:vehicle];
    }
}

#pragma mark - Actions
- (IBAction)clearFilterAction:(id)sender
{
    _isOnFiltering = NO;
    self.filterData = [VehiclesFilterDisplayData new];
    self.filterData.oldestYear = self.brand.oldestYear;
    self.filterData.modelsData = self.vehicleModelsData;
    self.filterData.filterChanged = YES;
    [self.vehiclesData.vehicles removeAllObjects];
    [self.tableView reloadData];
    
    [self.eventHandler resetHasLoadMore];
    [self.eventHandler getVehicles];
}

- (IBAction)blankAction:(id)sender {
    DLog(@"");
}


#pragma mark - Brand Offer Cell
- (void)brandOfferCell:(BrandOfferCell *)cell showOfferAtIndex:(NSInteger)index
{
    [self.eventHandler presentOffersInterfaceWithData:self.offersData.offers withViewedIndex:index];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (request.URL && navigationType == UIWebViewNavigationTypeLinkClicked) {
        CustomWebViewController *webVC = [[CustomWebViewController alloc] initWithURL:request.URL];
        DLog(@"%@", request.URL);
        webVC.supportedWebNavigationTools = DZNWebNavigationToolAll;
        webVC.supportedWebActions = DZNWebActionAll;
        webVC.showLoadingProgress = NO;
        webVC.allowHistory = YES;
        webVC.hideBarsWithGestures = NO;
        [self.navigationController setToolbarHidden:NO];
        [self.navigationController pushViewController:webVC
                                             animated:YES];
        
        [self deactiveAllTabBarItems];
        return NO;
    }
    
    return YES;
}

@end
