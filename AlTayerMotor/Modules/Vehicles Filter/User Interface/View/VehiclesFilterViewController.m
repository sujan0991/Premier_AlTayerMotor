//
//  VehiclesFilterViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesFilterViewController.h"
#import "VFSlidersCell.h"
#import "VFCategoriesCell.h"
#import "VFBrandCell.h"
#import "VFBlankCell.h"
#import "VehiclesFilterDisplayData.h"
#import "VehicleModelsDisplayData.h"
#import "MPreownedVehicleModel.h"
#import "NSArray+LinqExtensions.h"
#import "UIView+Border.h"
#import "UIView+Roundify.h"
#import "NSString+Color.h"
#import "ViewUtils.h"
#import "NMRangeSlider.h"
#import "DateManager.h"

#define SlidersCellIdentifier               @"VFSlidersCell"
#define CategoriesCellIdentifier            @"VFCategoriesCell"
#define BrandCellIdentifier                 @"VFBrandCell"
#define BlankCellIdentifier                 @"VFBlankCell"

#define kSlidersCellHeight                  450
#define kCategoriesCellHeight               128
#define kBrandCellHeight                    58
#define kDefaultMileage                     200000
@interface VehiclesFilterViewController () <VehicleCategoryDelegate>
{
    NSString *currentCateogy;
}
@property (nonatomic, strong) NSArray *vehicleModels;
@property (nonatomic, strong) VFSlidersCell *slidersCell;
@property (nonatomic, strong) VFCategoriesCell *categoriesCell;

@property (nonatomic, assign) NSInteger lowerPrice;
@property (nonatomic, assign) NSInteger upperPrice;
@property (nonatomic, assign) NSInteger mileage;
@property (nonatomic, assign) NSInteger lowerYear;
@property (nonatomic, assign) NSInteger upperYear;
@property (nonatomic, strong) MPreownedVehicleModel *selectedModel;

@end

@implementation VehiclesFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.vehicleModels = self.data.modelsData.models;
    self.selectedModel = self.data.selectedModel;
    
    self.lowerPrice = MAX(self.data.lowerPrice, 0);
    self.upperPrice = MIN(self.data.upperPrice, 300);
    
    self.mileage = self.data.upperMileage > 0 ? self.data.upperMileage : kDefaultMileage;
    
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
    NSInteger currentMonth = [components month];
    NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
    NSInteger currentYear = [yearString integerValue] + (currentMonth > 3 ? 1 : 0);
    NSInteger minYear = self.data.oldestYear == 0 ? currentYear - 30 : self.data.oldestYear;
    
    self.lowerYear = MAX(minYear, self.data.lowerYear);
    self.upperYear = MIN(currentYear, self.data.upperYear);
    
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE FILTER");
    
    UIBarButtonItem *btnOk = [[UIBarButtonItem alloc]
                                   initWithTitle:LOCALIZED(@"TEXT OK")
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(applyFilter:)];
    [btnOk setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20.0],
                                         NSForegroundColorAttributeName: [@"f0292a" representedColor]
                                         } forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btnOk;
    [self addLeftMenuWithAction:@selector(backAction:) inController:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateSliderLabels];
    [self updateSliderMileage];
    [self updateSLiderYear];
    [self setupViews];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_tableView);
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutByLanguage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
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
    if (_categoriesCell) {
        [@[_categoriesCell.btnAll, _categoriesCell.btnSedan, _categoriesCell.btnSuv, _categoriesCell.btnTrucks] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            [button addRightLine];
        }];
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    [self changeCagetory:nil];
}

- (void) updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    CGPoint lowerCenter;
    lowerCenter.x = (_slidersCell.sliderPrice.lowerCenter.x + _slidersCell.sliderPrice.left);
    lowerCenter.y = (_slidersCell.sliderPrice.center.y - 30.0f);
    _slidersCell.leftLowerPrice.constant = lowerCenter.x;
    _slidersCell.lbLowerPrice.text = [NSString stringWithFormat:@"%dK", (int)_slidersCell.sliderPrice.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (_slidersCell.sliderPrice.upperCenter.x + _slidersCell.sliderPrice.left);
    upperCenter.y = (_slidersCell.sliderPrice.center.y - 30.0f);
    _slidersCell.leftUpperPrice.constant = upperCenter.x;
    _slidersCell.lbUpperPrice.text = [NSString stringWithFormat:@"%dK", (int)_slidersCell.sliderPrice.upperValue];
    
    CGRect lowerFrame = _slidersCell.lbLowerPrice.frame;
    lowerFrame.origin.y = _slidersCell.lbUpperPrice.top;
    lowerFrame.origin.x = lowerCenter.x - _slidersCell.lbLowerPrice.width/2;
    
    CGRect upperFrame = _slidersCell.lbUpperPrice.frame;
    upperFrame.origin.x = upperCenter.x - _slidersCell.lbUpperPrice.width/2;
    
    BOOL intersect = CGRectIntersectsRect(lowerFrame, upperFrame);
    _slidersCell.bottomLowerPrice.constant = intersect ? 5 : 70;
    _slidersCell.sliderPrice.lowerHandle.transform = CGAffineTransformMakeRotation(intersect ? M_PI : 0);
}

- (void)updateSliderMileage
{
    CGPoint upperCenter;
    upperCenter.x = (_slidersCell.sliderMileage.upperCenter.x + _slidersCell.sliderMileage.left);
    upperCenter.y = (_slidersCell.sliderMileage.center.y - 30.0f);
    _slidersCell.leftMileage.constant = upperCenter.x;
    _slidersCell.lbMileage.text = [NSString stringWithFormat:@"%dKm", (int)_slidersCell.sliderMileage.upperValue];
    
    CGRect lowerFrame = _slidersCell.lbMileage.frame;
    lowerFrame.origin.x = upperCenter.x - _slidersCell.lbMileage.width/2;
    
    BOOL intersectMin = CGRectIntersectsRect(_slidersCell.lbMileageMin.frame, lowerFrame);
    _slidersCell.lbMileageMin.hidden = intersectMin;
    
    BOOL intersectMax = CGRectIntersectsRect(_slidersCell.lbMileageMax.frame, lowerFrame);
    _slidersCell.lbMileageMax.hidden = intersectMax;
}

- (void) updateSLiderYear
{
    CGPoint lowerCenter;
    lowerCenter.x = (_slidersCell.sliderYear.lowerCenter.x + _slidersCell.sliderYear.left);
    lowerCenter.y = (_slidersCell.sliderYear.center.y - 30.0f);
    _slidersCell.leftLowerYear.constant = lowerCenter.x;
    _slidersCell.lbLowerYear.text = [NSString stringWithFormat:@"%d", (int)_slidersCell.sliderYear.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (_slidersCell.sliderYear.upperCenter.x + _slidersCell.sliderYear.left);
    upperCenter.y = (_slidersCell.sliderYear.center.y - 30.0f);
    _slidersCell.leftUpperYear.constant = upperCenter.x;
    _slidersCell.lbUpperYear.text = [NSString stringWithFormat:@"%d", (int)_slidersCell.sliderYear.upperValue];
    
    CGRect lowerFrame = _slidersCell.lbLowerYear.frame;
    lowerFrame.origin.y = _slidersCell.lbUpperYear.top;
    lowerFrame.origin.x = lowerCenter.x - _slidersCell.lbLowerYear.width/2;
    
    CGRect upperFrame = _slidersCell.lbUpperYear.frame;
    upperFrame.origin.x = upperCenter.x - _slidersCell.lbUpperYear.width/2;
    
    BOOL intersect = CGRectIntersectsRect(lowerFrame, upperFrame);
    _slidersCell.bottomLowerYear.constant = intersect ? 5 : 70;
    _slidersCell.sliderYear.lowerHandle.transform = CGAffineTransformMakeRotation(intersect ? M_PI : 0);
}


#pragma mark - TableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.vehicleModels.count ?: 1)  + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kSlidersCellHeight;
    } else if (indexPath.row == 1) {
        return kCategoriesCellHeight;
    }
    return kBrandCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (!self.slidersCell) {
            self.slidersCell = [self.tableView dequeueReusableCellWithIdentifier:SlidersCellIdentifier];
            [self.slidersCell.sliderPrice addTarget:self action:@selector(pricesChanged:) forControlEvents:UIControlEventValueChanged];
            [self.slidersCell.sliderMileage addTarget:self action:@selector(mileageChanged:) forControlEvents:UIControlEventValueChanged];
            [self.slidersCell.sliderYear addTarget:self action:@selector(yearChanged:) forControlEvents:UIControlEventValueChanged];
            self.slidersCell.data = _data;
            
        }
        return self.slidersCell;
    } else if (indexPath.row == 1) {
        if (!_categoriesCell) {
            _categoriesCell = [self.tableView dequeueReusableCellWithIdentifier:CategoriesCellIdentifier];
            _categoriesCell.delegate = self;
        }
        
        return _categoriesCell;
    } else if (self.vehicleModels.count == 0) {
        VFBlankCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BlankCellIdentifier];
        [cell.bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                             withRadii:CGSizeMake(4, 4)];
        cell.lbBLank.text = LOCALIZED(@"TEXT NO MODEL IN CATEGORY");
        return cell;
    }
    
    VFBrandCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BrandCellIdentifier];
    if (!cell) {
        cell = [[VFBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BrandCellIdentifier];
    }
    
    MPreownedVehicleModel *model = self.vehicleModels[indexPath.row - 2];
    [cell displayModel:model shownType:([currentCateogy isEqualToString:@"all"] || [currentCateogy isEqualToString:@"others"])];
    cell.selectedModel = _selectedModel;
    cell.line.hidden = (self.vehicleModels.count == indexPath.row - 1);
    cell.lineHeight.constant = 0.5;
    
    if (self.vehicleModels.count == indexPath.row - 1) {
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
    if (indexPath.row > 1 && self.vehicleModels.count > 0) {
        self.selectedModel = self.vehicleModels[indexPath.row - 2];
    }
}

#pragma mark - Vehicle Category Delegate
- (void)changeCagetory:(NSString *)category
{
    BOOL isCategoryNil = category == nil;
    if (isCategoryNil) {
        category = @"all";
    }
    
    currentCateogy = category;
    
    // get datasource
    if ([category isEqualToString:@"all"]) {
        self.vehicleModels = self.data.modelsData.models;
    } else {
        self.vehicleModels = [self.data.modelsData.models linq_where:^BOOL(MPreownedVehicleModel *model) {
            if ([category isEqualToString:@"others"]) {
                return ![model.type.lowercaseString isEqualToString:@"sedans"] &&
                        ![model.type.lowercaseString isEqualToString:@"suvs"] &&
                ![model.type.lowercaseString isEqualToString:@"trucks"] && ![model.type.lowercaseString isEqualToString:@"sedan"] &&
                ![model.type.lowercaseString isEqualToString:@"suv"] &&
                ![model.type.lowercaseString isEqualToString:@"truck"];
            } else {
                return [model.type.lowercaseString isEqualToString:category.lowercaseString] || [model.type.lowercaseString isEqualToString:[[NSString stringWithFormat:@"%@s", category] lowercaseString]];
            }
        }];
    }
    
    [self.tableView reloadData];
    
    // get current selected
    if (self.selectedModel) {
        MPreownedVehicleModel *model = [[self.vehicleModels linq_where:^BOOL(MPreownedVehicleModel *model) {
            return model.id == _selectedModel.id && [model.type isEqualToString:_selectedModel.type];
        }] linq_firstOrNil];
        
        if (model) {
            NSInteger index = [self.vehicleModels indexOfObject:model];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(index + 2) inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    if (!isCategoryNil) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma mark - Actions

- (IBAction)pricesChanged:(NMRangeSlider *)sender
{
    _lowerPrice = sender.lowerValue;
    _upperPrice = sender.upperValue;
    [self updateSliderLabels];
}

- (IBAction)mileageChanged:(NMRangeSlider *)sender
{
    _mileage = sender.upperValue;
    [self updateSliderMileage];
}

- (IBAction)yearChanged:(NMRangeSlider *)sender
{
    _lowerYear = sender.lowerValue;
    _upperYear = sender.upperValue;
    [self updateSLiderYear];
}

- (IBAction)applyFilter:(id)sender
{
    if (self.selectedModel ||
        self.lowerPrice >= 0 || self.upperPrice > 0 ||
        self.mileage > 0 ||
        self.lowerYear > 0 || self.upperPrice > 0)
    {
        self.data.filterChanged = YES;
        
        self.data.lowerPrice = (self.lowerPrice >= 0) ? self.lowerPrice : 0;
        self.data.upperPrice = (self.upperPrice > 0) ? self.upperPrice : 300;
        
        self.data.upperMileage = (self.mileage > 0) ? self.mileage : kDefaultMileage;
        
        NSDate *currentDate = [NSDate date];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
        NSInteger currentMonth = [components month];
        NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
        NSInteger currentYear = [yearString integerValue] + (currentMonth > 3 ? 1 : 0);
        NSInteger minYear = self.data.oldestYear == 0 ? currentYear - 30 : self.data.oldestYear;
        
        self.data.lowerYear = (self.lowerYear > 0) ? self.lowerYear : minYear;
        self.data.upperYear = (self.upperYear > 0) ? self.upperYear : currentYear;
        
        if (self.selectedModel) {
            self.data.selectedModel = self.selectedModel;
        }
    } else {
        self.data.filterChanged = NO;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
