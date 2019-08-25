//
//  ProfileViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileModuleInterface.h"
#import "TPKeyboardAvoidingTableView.h"

#import "FTUserInformationCell.h"
#import "FTRegisterCarCell.h"
#import "FTRegisteredCarCell.h"
#import "FTContinueCell.h"

#import "ATMButton.h"
#import "NumberPadToolbar.h"

#import "NSArray+LinqExtensions.h"
#import "NSString+Color.h"
#import "NSString+Utils.h"
#import "MUser.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MRegisteredVehicle.h"
#import "MCity.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "APIEndpoints.h"


#define kTotalStaticCells 4
#define kPositionUserInfoCell 0
#define kPositionDrivingCarTitleCell 1
#define kPositionRegisterCarCell 2
#define kPositionContinueCell 3

#define kHeightUserInfoCell 380.0f
#define kHeightDrivingCarTitleCell 160.0f
#define kHeightRegisteredCarCell 123.f
#define kHeightRegisterCarCell 500.0f
#define kHeightContinueCell 80.0f

#define WelcomeCellIdentifier           @"WelcomeCell"
#define UserInfoCellIdentifier          @"UserInfoCell"
#define DrivingCarTitleCellIdentifier   @"DrivingCarTitleCell"
#define RegisteredCarCellIdentifier     @"RegisteredCarCell"
#define RegisterCarCellIdentifier       @"RegisterCarCell"
#define ContinueCellIdentifier          @"ContinueCell"

#define kPaddingTextfield 100


@interface ProfileViewController() <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, FTRegisterCarCellDelegate>

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSArray *registeredCars;
@property (strong, nonatomic) MUser *user;

@property (strong, nonatomic) MRegisteredVehicle *editingVehicle;
@property (weak, nonatomic) MBrand *selectedBrand;
@property (nonatomic, strong) NSArray *vehicleModels;
@property (nonatomic, strong) MVehicleModel *selectedModel;
@property (assign, nonatomic) NSInteger selectedYear;
@property (nonatomic, strong) NSString *selectedDate;
@property (nonatomic, strong) MCity *selectedCity;

@property (weak, nonatomic) FTUserInformationCell *userInfoCell;
@property (weak, nonatomic) FTRegisterCarCell *registerCarCell;

@end


@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.eventHandler findUserInfo];
    [self.eventHandler findCities];
    [self.eventHandler findBrands];
    
    [self setupViews];
    [self layoutByLanguage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler findRegisteredVehicles];
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
    
    [self didSelectCity:_selectedCity];
    [self didSelectBrand:_selectedBrand];
    [self didSelectDate:_selectedDate];
    [self didSelectModel:_selectedModel];
    [self didSelectYear:_selectedYear];
}

- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE PROFILE");
}

- (void)updateBrand:(MBrand *)brand {
    self.selectedBrand = brand;
    if (self.selectedBrand) {
        [self.registerCarCell.btnBrand setTitle:self.selectedBrand.name
                                       forState:UIControlStateNormal];
        [self.registerCarCell.btnBrand setTitleColor:[UIColor blackColor]
                                            forState:UIControlStateNormal];
    } else {
        [self.registerCarCell.btnBrand setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND STAR")
                                       forState:UIControlStateNormal];
        [self.registerCarCell.btnBrand setTitleColor:[@"#ABABAB" representedColor]
                                            forState:UIControlStateNormal];
    }
    
}

- (void)updateModel:(MVehicleModel *)model {
    self.selectedModel = model;
    if (model) {
        [self.registerCarCell.btnModel setTitle:self.selectedModel.model
                                       forState:UIControlStateNormal];
        [self.registerCarCell.btnModel setTitleColor:[UIColor blackColor]
                                            forState:UIControlStateNormal];
    } else {
        [self.registerCarCell.btnModel setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL STAR")
                                       forState:UIControlStateNormal];
        [self.registerCarCell.btnModel setTitleColor:[@"#ABABAB" representedColor]
                                            forState:UIControlStateNormal];
    }
}

- (void)updateYear:(NSInteger)year {
    self.selectedYear = year;
    if (year > 0) {
        [self.registerCarCell.btnYear setTitle:[NSString stringWithFormat:@"%ld", (long)self.selectedYear]
                                      forState:UIControlStateNormal];
        [self.registerCarCell.btnYear setTitleColor:[UIColor blackColor]
                                           forState:UIControlStateNormal];
    } else {
        [self.registerCarCell.btnYear setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL YEAR STAR")
                                      forState:UIControlStateNormal];
        [self.registerCarCell.btnYear setTitleColor:[@"#ABABAB" representedColor]
                                           forState:UIControlStateNormal];
    }
}

- (void)updateExpiryDate:(NSString *)expiry {
    self.selectedDate = expiry;
    if (expiry && expiry.length > 0) {
        [self.registerCarCell.btnExpiry setTitle:expiry forState:UIControlStateNormal];
        [self.registerCarCell.btnExpiry setTitleColor:[UIColor blackColor]
                                           forState:UIControlStateNormal];
    } else {
        [self.registerCarCell.btnExpiry setTitle:LOCALIZED(@"TEXT REGISTRATION EXPIRY STAR")
                                      forState:UIControlStateNormal];
        [self.registerCarCell.btnExpiry setTitleColor:[@"#ABABAB" representedColor]
                                           forState:UIControlStateNormal];
    }
}

- (void)clearVehicleForm
{
    self.editingVehicle = nil;
    [self updateBrand:nil];
    self.vehicleModels = [@[] mutableCopy];
    [self updateModel:nil];
    [self updateYear:0];
    [self updateExpiryDate:@""];
    self.registerCarCell.tfRegistrationNumber.text = @"";
}

#pragma mark - View Interface
-(void)showRegisteredCars:(NSArray *)cars
{
    DLog(@"Registered Vehicles: [%lu]", (unsigned long)cars.count);
    self.registeredCars = cars;
    [self clearVehicleForm];
    [self reloadTableView];
}

- (void) reloadTableView
{
    [self.tableView reloadData];
}

- (void)updateUserInfo:(MUser *)user
{
    if (user) {
        self.user = user;
        [self didSelectCity:self.user.city];
    }
    
    if (self.user) {
        [self reloadTableView];
    }
}

- (void)updateCities:(NSArray *)cities
{
    self.cities = cities;
}

- (void)updateBrands:(NSArray *)brands
{
    self.brands = brands;
}

- (void)updateVehicleModels:(NSArray *)models
{
    self.vehicleModels = models;
}

- (void)didSelectCity:(MCity *)city
{
    self.selectedCity = city;
    
    if (city) {
        [self.userInfoCell.btnSelectCity setTitle:city.name
                            forState:UIControlStateNormal];
        [self.userInfoCell.btnSelectCity setTitleColor:[UIColor blackColor]
                                 forState:UIControlStateNormal];
    } else {
        [self.userInfoCell.btnSelectCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                            forState:UIControlStateNormal];
        [self.userInfoCell.btnSelectCity setTitleColor:[@"#ABABAB" representedColor]
                                 forState:UIControlStateNormal];
    }
}

- (void)didSelectBrand:(MBrand *)brand
{
    // update on ui
    if (![self.selectedBrand.name isEqualToString:brand.name]) {
        [self updateModel:nil];
    }
    
    [self updateBrand:brand];
    
    self.registerCarCell.tfOtherBrand.text = @"";
    
    if ([brand.name isEqualToString:kOtherString] || [brand.name isEqualToString:kOtherStringAR]) {
        self.registerCarCell.otherBrandLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.registerCarCell.otherBrandLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        self.registerCarCell.otherBrandLayoutConstraintTop.constant = 0;
        self.registerCarCell.otherBrandLayoutConstraintHeight.constant = 0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.registerCarCell.tfOtherBrand layoutIfNeeded];
        [self.registerCarCell.tfOtherModel layoutIfNeeded];
    }];
    
    // load vehicle models by brand from database
    [self.eventHandler findVehicleModelsByBrand:self.selectedBrand.id];
}

- (void)didSelectModel:(MVehicleModel *)model
{
    [self updateModel:model];
    
    self.registerCarCell.tfOtherModel.text = @"";
    
    if ([model.model isEqualToString:kOtherString] || [model.model isEqualToString:kOtherStringAR]) {
        self.registerCarCell.otherModelLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.registerCarCell.otherModelLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        self.registerCarCell.otherModelLayoutConstraintTop.constant = 0;
        self.registerCarCell.otherModelLayoutConstraintHeight.constant = 0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.registerCarCell.tfOtherModel layoutIfNeeded];
    }];
}

- (void)didSelectYear:(NSInteger)year
{
    [self updateYear:year];
}

- (void)didSelectDate:(NSString *)date
{
    [self updateExpiryDate:date];
}

#pragma mark - TableView Delegate & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTotalStaticCells + self.registeredCars.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kPositionUserInfoCell) {
        return kHeightUserInfoCell;
    } else if (indexPath.row == kPositionDrivingCarTitleCell) {
        return kHeightDrivingCarTitleCell;
    } else if (indexPath.row == kPositionRegisterCarCell + self.registeredCars.count) {
        return kHeightRegisterCarCell + (self.registeredCars.count ? 40 : 0);
    } else if (indexPath.row == kPositionContinueCell + self.registeredCars.count) {
        return kHeightContinueCell;
    } else { // REGISTERED CARS
        return kHeightRegisteredCarCell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kPositionUserInfoCell) {
        if (!self.userInfoCell) {
            self.userInfoCell = [self.tableView dequeueReusableCellWithIdentifier:UserInfoCellIdentifier forIndexPath:indexPath];
            [self.userInfoCell.btnSelectCity addTarget:self action:@selector(openSelectCityAction:) forControlEvents:UIControlEventTouchUpInside];
            self.userInfoCell.tfFirstName.delegate = self;
            self.userInfoCell.tfLastName.delegate = self;
            self.userInfoCell.tfPhoneNumber.delegate = self;
            [self didSelectCity:_selectedCity];
            
            if (self.user) {
                self.userInfoCell.tfFirstName.text = self.user.firstName;
                self.userInfoCell.tfLastName.text = self.user.lastName;
                self.userInfoCell.tfPhoneNumber.text = self.user.phoneNumber;
                if (_user.city && _user.city.name.length > 0) {
                    [self.userInfoCell.btnSelectCity setTitle:_user.city.name
                                                     forState:UIControlStateNormal];
                    [self.userInfoCell.btnSelectCity setTitleColor:[UIColor blackColor]
                                                          forState:UIControlStateNormal];
                } else {
                    [self.userInfoCell.btnSelectCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                                                     forState:UIControlStateNormal];
                    [self.userInfoCell.btnSelectCity setTitleColor:[@"#ABABAB" representedColor]
                                                          forState:UIControlStateNormal];
                }
            }
        }
        
        return self.userInfoCell;
    } else if (indexPath.row == kPositionDrivingCarTitleCell) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DrivingCarTitleCellIdentifier forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == kPositionRegisterCarCell + self.registeredCars.count) {
        if (!self.registerCarCell) {
            self.registerCarCell = [self.tableView dequeueReusableCellWithIdentifier:RegisterCarCellIdentifier forIndexPath:indexPath];
            [self.registerCarCell.btnBrand addTarget:self action:@selector(openSelectBrandAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.registerCarCell.btnModel addTarget:self action:@selector(openSelectModelAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.registerCarCell.btnYear addTarget:self action:@selector(openSelectYearAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.registerCarCell.btnExpiry addTarget:self action:@selector(openSelectExpiryAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.registerCarCell.btnAddVehicle addTarget:self action:@selector(addCarAction:) forControlEvents:UIControlEventTouchUpInside];
            self.registerCarCell.tfRegistrationNumber.delegate = self;
            
            // for updating language
            [self didSelectBrand:_selectedBrand];
            [self didSelectDate:_selectedDate];
            [self didSelectModel:_selectedModel];
            [self didSelectYear:_selectedYear];
        }
        
        self.registerCarCell.delegate = self;
        self.registerCarCell.lbOther.hidden = !self.registeredCars.count;
        self.registerCarCell.topConstraint.constant = self.registeredCars.count ? 40 : 0;
        
        return self.registerCarCell;
    } else if (indexPath.row == kPositionContinueCell + self.registeredCars.count) {
        FTContinueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ContinueCellIdentifier forIndexPath:indexPath];
        [cell.btnContinue addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else { // REGISTERED CARS
        NSInteger index = indexPath.row - 2;
        MRegisteredVehicle *vehicle = self.registeredCars[index];
        
        FTRegisteredCarCell *cell = [self.tableView dequeueReusableCellWithIdentifier:RegisteredCarCellIdentifier forIndexPath:indexPath];
        [cell.btnEditRegisteredCar setTag:index];
        [cell.btnEditRegisteredCar addTarget:self action:@selector(editRegisteredCarAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDeleteRegisteredCar setTag:index];
        [cell.btnDeleteRegisteredCar addTarget:self action:@selector(deleteRegisteredCardAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.lbExpiryDate.text = [NSString stringWithFormat:@"%@ %@", LOCALIZED(@"TEXT EXPIRY"), [vehicle.registrationExpiry capitalizedString]];
        cell.lbRegNo.text = [NSString stringWithFormat:@"%@ %@", LOCALIZED(@"TEXT REG NO"), vehicle.registrationNumber];
        cell.lbCarType.text = vehicle.brand.name ? vehicle.brand.name : vehicle.otherBrand;
        cell.lbModel.text = [NSString stringWithFormat:@"%@ %ld", vehicle.model.model ? vehicle.model.model : vehicle.otherModel, (long)vehicle.year];
        [cell.imvModel sd_setImageWithURL:[NSURL URLWithString:[vehicle.model.image toImageLink]]
                         placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
        return cell;
    }
}

#pragma mark - Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (IBAction)continueAction:(id)sender
{
    MUser *user = [self getUserInfo];
    MRegisteredVehicle *registeredVehicle = [self getRegisteredVehicle];
    [self.eventHandler storeUserInfo:user
                          andVehicle:registeredVehicle
                      withOldVehicle:self.editingVehicle];
}

- (IBAction)editRegisteredCarAction:(id)sender
{
    NSInteger index = [sender tag];
    MRegisteredVehicle *vehicle = self.registeredCars[index];
    [self.eventHandler presentEditInterfaceWithData:vehicle];
    
//    [UIView
//     animateWithDuration:0.3f
//     delay:0.0f
//     options:UIViewAnimationOptionAllowUserInteraction
//     animations:^
//     {
//         // scroll to form cell
//         NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(kPositionRegisterCarCell + self.registeredCars.count) inSection:0];
//         [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//     }
//     completion:^(BOOL finished)
//     {
//         // populate data
//         NSInteger index = [sender tag];
//         MRegisteredVehicle *vehicle = self.registeredCars[index];
//         self.editingVehicle = vehicle;
//         [self updateBrand:vehicle.brand];
//         [self didSelectBrand:vehicle.brand];
//         [self updateModel:vehicle.model];
//         [self updateYear:vehicle.year];
//         [self updateExpiryDate:vehicle.registrationExpiry];
//         self.registerCarCell.tfRegistrationNumber.text = vehicle.registrationNumber;
//     }];
}

- (IBAction)deleteRegisteredCardAction:(id)sender {
    NSInteger index = [sender tag];
    MRegisteredVehicle *vehicle = self.registeredCars[index];
    [self.eventHandler showDeletePopupWithRegisteredVehicle:vehicle];
}

- (IBAction)openSelectCityAction:(id)sender
{
    [self hideTextfieldsKeyboard];
    [self.eventHandler showCitySelectionAlert:self.cities];
}

- (IBAction)addCarAction:(id)sender
{
    MRegisteredVehicle *registeredVehicle = [self getRegisteredVehicle];
    [self.eventHandler saveRegisteredVehicle:registeredVehicle withCurrentVehicle:self.editingVehicle];
}

- (IBAction)openSelectBrandAction:(id)sender
{
    [self hideTextfieldsKeyboard];
    [self.eventHandler showBrandSelectionAlert:self.brands];
}

- (IBAction)openSelectModelAction:(id)sender
{
    [self hideTextfieldsKeyboard];
    [self.eventHandler showVehicleModelSelectionAlert:self.vehicleModels];
    
}

- (IBAction)openSelectYearAction:(id)sender
{
//    NSArray *years = [[self.vehicleModels linq_where:^BOOL(id item) {
//        return [[item model] isEqualToString:self.selectedModel];
//    }] linq_select:^id(id item) {
//        return @([item modelYear]);
//    }];
    [self hideTextfieldsKeyboard];
    NSArray *years = [ATMGlobal yearsSelection];
    [self.eventHandler showYearSelectionAlert:years];
}

- (IBAction)openSelectExpiryAction:(id)sender
{
    [self hideTextfieldsKeyboard];
    self.selectedDate = [self.selectedDate isEqualToString:LOCALIZED(@"TEXT REGISTRATION EXPIRY STAR")] ? nil : self.selectedDate;
    [self.eventHandler showDateSelectionAlert:self.selectedDate];
}

#pragma mark -
#pragma mark - FTUserRegisterCarCellDelegate

- (void)didSetOtherBrand:(NSString *)otherBrand {
    [self.eventHandler findVehicleModelsByBrand:-1];
}

- (void)didSetOtherModel:(NSString *)otherModel {
}

#pragma mark - Others
- (MUser *)getUserInfo
{
    MUser *user = [MUser new];
    user.firstName = self.userInfoCell.tfFirstName.text;
    user.lastName = self.userInfoCell.tfLastName.text;
    user.phoneCode = @"+971";
    user.phoneNumber = self.userInfoCell.tfPhoneNumber.text;
    user.city = self.selectedCity;
    
    return user;
}

- (MRegisteredVehicle *)getRegisteredVehicle
{
    MRegisteredVehicle *registeredVehicle = [MRegisteredVehicle new];
    if (self.selectedBrand && (![self.selectedBrand.name isEqualToString:kOtherString] || ![self.selectedBrand.name isEqualToString:kOtherStringAR])) {
        registeredVehicle.brandId = self.selectedBrand.id;
    }
    
    registeredVehicle.otherBrand = self.registerCarCell.tfOtherBrand.text;
    
    if (self.selectedModel && (![self.selectedModel.model isEqualToString:kOtherString] || ![self.selectedModel.model isEqualToString:kOtherStringAR])) {
        registeredVehicle.model = self.selectedModel;
    }
    
    registeredVehicle.otherModel = self.registerCarCell.tfOtherModel.text;
    registeredVehicle.year = self.selectedYear;
    registeredVehicle.registrationExpiry = self.selectedDate;
    registeredVehicle.registrationNumber = self.registerCarCell.tfRegistrationNumber.text;
    

    return registeredVehicle;
}

- (void)hideTextfieldsKeyboard
{
    if (self.userInfoCell) {
        [self.userInfoCell.tfFirstName resignFirstResponder];
        [self.userInfoCell.tfLastName resignFirstResponder];
        [self.userInfoCell.tfPhoneNumber resignFirstResponder];
    }
    
    if (self.registerCarCell) {
        [self.registerCarCell.tfRegistrationNumber resignFirstResponder];
    }
}

@end