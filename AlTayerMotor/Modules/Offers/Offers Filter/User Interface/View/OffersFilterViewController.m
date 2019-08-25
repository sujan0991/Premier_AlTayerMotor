//
//  OffersFilterViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersFilterViewController.h"
#import "OffersFilterDisplayData.h"
#import "NSArray+LinqExtensions.h"
#import "UIView+Roundify.h"
#import "NSString+Color.h"
#import "OFCategoriesCell.h"
#import "OFBrandCell.h"
#import "MOffer.h"
#import "MBrand.h"
#import "MGlobalSetting.h"
#import "UIView+Border.h"
#import "CoreDataStore.h"
#import "Brand.h"

#define CategoriesCellIdentifier            @"OFCategoriesCell"
#define BrandCellIdentifier                 @"OFBrandCell"

#define kCategoriesCellHeight               128
#define kBrandCellHeight                    58

@interface OffersFilterViewController() <OfferCategoryDelegate, OFBrandCellDelegate>
@property (nonatomic, strong) OFCategoriesCell *categoriesCell;
@property (nonatomic, strong) NSArray *filteredBrands;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *tabNewTitle;
@property (nonatomic, strong) NSString *tabPreownedTitle;
@property (nonatomic, strong) NSString *tabServiceTitle;

@property (nonatomic, strong) MBrand *selectedBrandObj;

@end

@implementation OffersFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedBrand = _data.selectedBrand;
    _selectedCategory = _data.selectedCategory;
    [self layoutByLanguage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupViews];
    [self layoutByLanguage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_data.settings) {
        MGlobalSetting *setting = [[_data.settings linq_where:^BOOL(MGlobalSetting *setting) {
            return [setting.key isEqualToString:kOfferCatNew];
        }] linq_firstOrNil];
        
        if (setting) {
            _tabNewTitle = [ATMGlobal isEnglish] ? setting.name : setting.nameAR;
        }
        
        setting = [[_data.settings linq_where:^BOOL(MGlobalSetting *setting) {
            return [setting.key isEqualToString:kOfferCatPreowned];
        }] linq_firstOrNil];
        
        if (setting) {
            _tabPreownedTitle = [ATMGlobal isEnglish] ? setting.name : setting.nameAR;
        }
        
        setting = [[_data.settings linq_where:^BOOL(MGlobalSetting *setting) {
            return [setting.key isEqualToString:kOfferCatService];
        }] linq_firstOrNil];
        
        if (setting) {
            _tabServiceTitle = [ATMGlobal isEnglish] ? setting.name : setting.nameAR;
        }
    }
    
    [self changeCagetory:kOfferCatNew];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - UI
- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_tableView);
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
}

- (void)setupViews
{
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE FILTER");
    
    self.navigationItem.hidesBackButton = YES;
    [self addLeftMenuWithAction:@selector(backAction:) inController:self];
    
    UIBarButtonItem *btnOk = [[UIBarButtonItem alloc]
                              initWithTitle:LOCALIZED(@"TEXT OK")
                              style:UIBarButtonItemStylePlain
                              target:self
                              action:@selector(applyFilter:)];
    [btnOk setTitleTextAttributes:@{
                                    NSFontAttributeName: [UIFont fontWithName:[ATMGlobal isEnglish] ? @"Helvetica-Bold" : @"Helvetica"
                                                                         size:20.0],
                                    NSForegroundColorAttributeName: [@"ef6c05" representedColor]
                                    } forState:UIControlStateNormal];
//    Remove button OK
//    self.navigationItem.rightBarButtonItem = btnOk;
    
    if (_categoriesCell) {
        if ([ATMGlobal isEnglish]) {
            [@[_categoriesCell.btnNew, _categoriesCell.btnPreOwned] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
                [button addRightLine];
            }];
        } else {
            [@[_categoriesCell.btnService, _categoriesCell.btnPreOwned] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
                [button addRightLine];
            }];
        }
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    [self changeCagetory:nil];
}


#pragma mark - Actions
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)applyFilter:(id)sender {
    _data.selectedBrand = _selectedBrand;
    _data.selectedCategory = _selectedCategory;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Offer Categories 
- (void)changeCagetory:(NSString *)offerCategory
{
    offerCategory = offerCategory ?: kOfferCatNew;
    
//    if (_data && _data.offers) {
//        _filteredBrands = [[[_data.offers linq_where:^BOOL(MOffer *offer) {
//            return offer.brand && offer.brand.offerCategory && [offer.brand.offerCategory isEqualToString:offerCategory];
//        }] linq_select:^id(MOffer *offer) {
//            return offer.brand;
//        }] linq_distinct:^id(MBrand *brand) {
//            return @(brand.id);
//        }];
//    } else {
//        _filteredBrands = @[];
//    }
    
    _filteredBrands = [[[CoreDataStore sharedStore] fetchAllBrands] linq_select:^id(Brand *brand) {
        MBrand *mbrand = [[MBrand alloc] initWithId:[brand.id integerValue]
                                          withName:brand.name
                                        withNameAR:brand.name_ar
                                          withLogo:brand.logo
                                           withUrl:brand.url
                                      withRoadside:brand.roadside];
        mbrand.offerCategory = offerCategory;
        return mbrand;
    }];
    
    [self.tableView reloadData];
    
    // get current selected
    // Commented out because of removing check mark system
//    if (_selectedCategory && _selectedBrand) {
//        MBrand *brand = [[_filteredBrands linq_where:^BOOL(MBrand *item) {
//            return item.id == _selectedBrand && [item.offerCategory isEqualToString:_selectedCategory];
//        }] linq_firstOrNil];
//        
//        if (brand) {
//            NSInteger index = [_filteredBrands indexOfObject:brand];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(index + 1) inSection:0];
//            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        }
//    }
}

#pragma mark - Brand Cell Delegate
- (void)didSelectBrand:(MBrand *)brand
{
    _selectedBrandObj = brand;
    _selectedCategory = _selectedBrandObj.offerCategory;
    _selectedBrand = _selectedBrandObj.id;
    
    [self applyFilter:nil];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_filteredBrands.count ?: 0)  + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kCategoriesCellHeight;
    }
    return kBrandCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (!_categoriesCell) {
            _categoriesCell = [self.tableView dequeueReusableCellWithIdentifier:CategoriesCellIdentifier];
            _categoriesCell.delegate = self;
        }
        
        [_categoriesCell.btnNew setTitle:[(_tabNewTitle ?: kOfferCatNew) uppercaseString]
                                forState:UIControlStateNormal];
        
        [_categoriesCell.btnPreOwned setTitle:[(_tabPreownedTitle ?: kOfferCatPreowned) uppercaseString]
                                     forState:UIControlStateNormal];
        
        [_categoriesCell.btnService setTitle:[(_tabServiceTitle ?: kOfferCatService) uppercaseString]
                                    forState:UIControlStateNormal];
        
        return _categoriesCell;
    }
    
    MBrand *brand = self.filteredBrands[indexPath.row - 1];
    OFBrandCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BrandCellIdentifier];
    cell.delegate = self;
    [cell displayBrand:brand];
    cell.line.hidden = (_filteredBrands.count == indexPath.row);
    cell.lineHeight.constant = 0.5;
    
    if (_filteredBrands.count == indexPath.row) {
        [cell.bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                             withRadii:CGSizeMake(4, 4)];
    } else {
        [cell.bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                             withRadii:CGSizeMake(0, 0)];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
