//
//  OffersViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersViewController.h"
#import "VehiclesFilterCell.h"
#import "OfferCell.h"
#import "MOffer.h"
#import "NSString+Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EmptyVehicleCell.h"
#import "OffersFilterDisplayData.h"

#define kFilterCell @"VehiclesFilterCell"
#define kOfferCell @"OfferCell"
#define kEmptyCell  @"EmptyVehicleCell"

#define kOfferCellHeight    300.0f
#define kFilterCellHeight   50.0f
#define kEmptyCellHeight    150.f

@interface OffersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *offers;
@property (strong, nonatomic) NSMutableArray *filteredOffers;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) OffersFilterDisplayData *filterData;
@property (assign) BOOL isOnFiltering;

@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _filterData = [OffersFilterDisplayData new];
    [self.eventHandler getOffersSettings];
    [self setupViews];
    [self layoutByLanguage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFiltered:nil];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (!parent) {
        [self activeAllTabBarItems];
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

#pragma mark - Updating UI
- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_tableView);
    
}

- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"MENU SPECIAL OFFERS");
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20, 0.0);
    
    self.offers = @[];
    self.filteredOffers = [@[] mutableCopy];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger offersCount = self.filteredOffers ? self.filteredOffers.count : 0;
    return MAX(offersCount, 1) + 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return kFilterCellHeight;
//    } else if (!self.filteredOffers || self.filteredOffers.count == 0) {
//        return kEmptyCellHeight;
//    }
//    
//    return kOfferCellHeight;
//}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kFilterCellHeight;
    } else if (!self.filteredOffers || self.filteredOffers.count == 0) {
        return kEmptyCellHeight;
    }
    
    return kOfferCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        VehiclesFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:kFilterCell];
        cell.isOffer = YES;
        [cell.btnAllVehicles addTarget:self action:@selector(clearFilterAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.lbFilter.font = self.isOnFiltering ? [UIFont boldSystemFontOfSize:17.0] : [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        cell.lbFilterType.font = !self.isOnFiltering ? [UIFont boldSystemFontOfSize:17.0] : [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        return cell;
    } else if (!self.filteredOffers || self.filteredOffers.count == 0) {
        EmptyVehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmptyCell];
        cell.indicator.hidden = ![self.eventHandler isGettingOffers];
        cell.imvCar.hidden = [self.eventHandler isGettingOffers];
        cell.lbEmpty.hidden = [self.eventHandler isGettingOffers];
        if (![cell.indicator isAnimating]) {
            [cell.indicator startAnimating];
        }
        return cell;
    }
    
    MOffer *offer = self.filteredOffers[indexPath.row - 1];
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:kOfferCell];
    
    [cell.imvThumbnail sd_setImageWithURL:[NSURL URLWithString:[offer.thumbnailUrl toImageLink]]
                         placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
    
    NSString *title = [offer isValidString:offer.title] ? offer.title : @"";
    [cell.lbTitle setText:title];
    
    NSString *description = [offer isValidString:offer.desc] ? offer.desc : @"";
    [cell.lbDescription setText:description];
    
    NSString *currency = [offer isValidString:offer.currency] ? offer.currency : LOCALIZED(@"TEXT AED");
    NSString *price = [self.numberFormatter stringFromNumber:@(offer.price)];
    cell.lbContent.text = [NSString stringWithFormat:@"%@ %@ %@", LOCALIZED(@"TEXT STARTING AT"), currency, price];
    
    if (offer.price == 0) {
        cell.lbContent.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.eventHandler presentFilterInterfaceWithData:_filterData];
    } else if (indexPath.row == 1 && (!self.filteredOffers || self.filteredOffers.count == 0)) {
        [self reloadOffersData];
    } else {
        NSInteger index = indexPath.row - 1;
        [self.eventHandler presentOffersInterfaceWithData:self.filteredOffers
                                          withViewedIndex:index];
    }
}

- (void)reloadOffersData
{
    [self.eventHandler getOffers];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - View Interface
- (void)updateOffers:(NSArray *)offers
{
    _offers = offers ?: @[];
    _filterData.offers = _offers;
    [self updateFiltered:nil];
}

- (void)updateSettings:(NSArray *)settings
{
    _filterData.settings = settings;
    [self.eventHandler getOffers];
}

#pragma mark - Actions
- (IBAction)clearFilterAction:(id)sender
{
    DLog();
    if (_filterData) {
        _filterData.selectedCategory = nil;
        _filterData.selectedBrand = 0;
    }
    [self updateFiltered:nil];
}

- (IBAction)updateFiltered:(id)sender
{
    if (_filterData && _filterData.selectedCategory && _filterData.selectedBrand > 0) {
        NSArray *filter = [self.offers linq_where:^BOOL(MOffer *item) {
            return item.category && ![item.category isEqual:[NSNull null]] && [item.category isEqualToString:_filterData.selectedCategory] && item.brandId == _filterData.selectedBrand;
        }];
        
        [self.filteredOffers removeAllObjects];
        [self.filteredOffers addObjectsFromArray:filter];
        self.isOnFiltering = YES;
    } else if (_filterData) {
        [self.filteredOffers removeAllObjects];
        [self.filteredOffers addObjectsFromArray:self.offers];
        self.isOnFiltering = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - Others
- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc]init];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_numberFormatter setGroupingSeparator:@","];
        [_numberFormatter setGroupingSize:3];
    }
    
    return _numberFormatter;
}

@end
