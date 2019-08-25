//
//  BookingServiceViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServiceViewController.h"
#import "BookingServiceModuleInterface.h"
#import "ATMButton.h"
#import "ATMFullRowButton.h"
#import "NumberPadToolbar.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIView+Border.h"
#import "NSString+Color.h"
#import "CoreDataStore.h"

#import "MRegisteredVehicle.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MUser.h"
#import "MServiceRequest.h"
#import "MLocation.h"
#import "MCity.h"
#import "ATMTextField.h"

#define kOtherString                    @"Other"
#define kOtherStringAR                  @"آخر"
#define kOtherLayoutConstraintHeight    30
#define kOtherLayoutConstraintTop       20

@interface BookingServiceViewController() <NumberPadToolbarDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *vehicleModels;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) MUser *user;

@property (nonatomic, weak) MBrand *selectedBrand;
@property (nonatomic, strong) MVehicleModel *selectedModel;
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, strong) MCity *selectedCity;
@property (nonatomic, weak) MLocation *selectedLocation;


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet ATMButton *btnBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnModel;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnYear;
@property (weak, nonatomic) IBOutlet UITextField *tfRegistrationNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfMileage;
@property (weak, nonatomic) IBOutlet ATMButton *btnBranch;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherModel;

@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet ATMButton *btnCity;
@property (weak, nonatomic) IBOutlet ATMButton *btnPhoneCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleVehicle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleAbout;
@property (weak, nonatomic) IBOutlet ATMTextField *tfEmail;


@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnCancel;
@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnSubmit;


@property (weak, nonatomic) IBOutlet UIView *viewVehicleInfo;
@property (weak, nonatomic) IBOutlet UIView *viewUserInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imvIconCar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutContraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutConstraintTop;

@end

@implementation BookingServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.otherBrandLayoutConstraintTop.constant = 0;
    self.otherBrandLayoutConstraintHeight.constant = 0;
    self.otherModelLayoutConstraintTop.constant = 0;
    self.otherModelLayoutContraintHeight.constant = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
    [self setupViews];
}


- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(_viewUserInfo);
    AFFINE_TRANSFORM(_viewVehicleInfo);
    AFFINE_TRANSFORM(_imvIconCar);

    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
        }
    }
    
    for (UIView *subview in [_viewUserInfo allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]] ||
            [subview isKindOfClass:[UITextField class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
        }
    }
    
    for (UIView *subview in [_viewVehicleInfo allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]] ||
            [subview isKindOfClass:[UITextField class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
        }
    }
    
    TEXT_ALIGN(self.tfOtherBrand);
    TEXT_ALIGN(self.tfOtherModel);
    
    if (![ATMGlobal isEnglish]) {
        [_phoneView.layer setAffineTransform:CGAffineTransformMakeScale(-1,1)];
        [_tfPhoneNumber.layer setAffineTransform:CGAffineTransformMakeScale(1,1)];
        for (UIView *subview in [_btnPhoneCode allSubviews]) {
            if ([subview isKindOfClass:[UILabel class]] ||
                [subview isKindOfClass:[UIImageView class]] ||
                [subview isKindOfClass:[UITextField class]]) {
                [subview.layer setAffineTransform:CGAffineTransformMakeScale(1,1)];
            }
        }
    }
    
    
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE SERVICE");
    _lbTitleAbout.text = LOCALIZED(@"TEXT TELL US ABOUT YOURSELF");
    _lbTitleVehicle.text = LOCALIZED(@"TEXT TITLE WHICH VEHICLE IS IN NEED OF SERVICE");
    self.tfMileage.placeholder = LOCALIZED(@"TEXT PLACEHOLDER MILEAGE KM");
    self.tfRegistrationNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER REGISTRATION NUMBER");
    self.tfFirstName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER FIRST NAME");
    self.tfLastName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER LAST NAME");
    self.tfPhoneNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER PHONE NUMBER");
    self.tfOtherBrand.placeholder = LOCALIZED(@"TEXT OTHER BRAND");
    self.tfEmail.placeholder = LOCALIZED(@"TEXT PLACEHOLDER EMAIL");
    self.tfOtherModel.placeholder = LOCALIZED(@"TEXT OTHER MODEL");
    [_btnCancel setTitle:LOCALIZED(@"TEXT CLEAR") forState:UIControlStateNormal];
    [_btnSubmit setTitle:LOCALIZED(@"TEXT SUBMIT") forState:UIControlStateNormal];
    
    [@[_tfFirstName, _tfLastName, _tfMileage, _tfPhoneNumber, _tfRegistrationNumber, _tfOtherBrand] enumerateObjectsUsingBlock:^(UITextField *tf, NSUInteger idx, BOOL * _Nonnull stop) {
        tf.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    }];
    
    [self updateBrand:_selectedBrand];
    [self updateModel:_selectedModel];
    [self updateLocation:_selectedLocation];
    [self updateCity:_selectedCity];
    [self updateYear:_selectedYear];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *registeredVehicles = [[CoreDataStore sharedStore] fetchAllRegisteredVehicles];
    self.navigationItem.hidesBackButton = (registeredVehicles.count == 0);
    
    [self.eventHandler findBrands];
    [self.eventHandler findUserInfo];
    [self.eventHandler findCities];
    [self.eventHandler findLocations];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenBookService];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // ScrollView
    CGRect sizeRect = [UIScreen mainScreen].bounds;
    [self.scrollView setContentSize:CGSizeMake(sizeRect.size.width, 1050)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    // Navigation
//    self.navigationItem.title = @"Services";
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // Bottom lines
    NSArray *views = @[self.tfEmail, self.tfOtherBrand, self.tfOtherModel, self.tfRegistrationNumber, self.btnBrand, self.btnBranch, self.btnModel, self.btnYear, self.tfMileage,
                       self.tfFirstName, self.tfLastName, self.phoneView, self.btnCity];
    for (UIView *view in views) {
        [view addBottomLine];
    }
    
    // Delegate
    self.tfRegistrationNumber.delegate = self;
    self.tfFirstName.delegate = self;
    self.tfLastName.delegate = self;
    
    // NumberPad
    NumberPadToolbar *toolbar = [[NumberPadToolbar alloc] initWithTextField:self.tfMileage];
    toolbar.numberPadDelegate = self;
    self.tfMileage.inputAccessoryView = toolbar;
    
    // PhonePad
    NumberPadToolbar *phoneToolbar = [[NumberPadToolbar alloc] initWithTextField:self.tfPhoneNumber];
    phoneToolbar.numberPadDelegate = self;
    self.tfPhoneNumber.inputAccessoryView = phoneToolbar;
    
    // Prepost data
    if (self.registeredVehicle) {
        if (self.registeredVehicle.brand && (![self.registeredVehicle.brand.name isEqualToString:kOtherString] || ![self.registeredVehicle.brand.name isEqualToString:kOtherStringAR]) && self.registeredVehicle.brand.name.length > 0) {
            [self updateBrand:self.registeredVehicle.brand];
        } else {
            [self updateOtherbrand:self.registeredVehicle.otherBrand];
        }
        if (self.registeredVehicle.model && (![self.registeredVehicle.model.model isEqualToString:kOtherString] || ![self.registeredVehicle.model.model isEqualToString:kOtherStringAR]) && self.registeredVehicle.model.model.length > 0) {
            [self updateModel:self.registeredVehicle.model];
        } else {
            [self updateOtherModel:self.registeredVehicle.otherModel];
        }
        
        [self updateYear:self.registeredVehicle.year];
        self.tfRegistrationNumber.text = self.registeredVehicle.registrationNumber;
    }
    
    // Buttons
    [self.btnCancel addBorder];
    [self.btnSubmit addBorder];
    
    //
    [_tfOtherBrand addTarget:self
                      action:@selector(otherBrandDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    [_tfOtherModel addTarget:self
                      action:@selector(otherModelDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    
}

- (void)updateCity:(MCity *)city {
    self.selectedCity = city;
    if (self.selectedCity) {
        [self.btnCity setTitle:self.selectedCity.name forState:UIControlStateNormal];
        [self.btnCity setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                      forState:UIControlStateNormal];
        [self.btnCity setTitleColor:[@"#ABABAB" representedColor]
                            forState:UIControlStateNormal];
    }
    
}

- (void)updateBrand:(MBrand *)brand {
    self.selectedBrand = brand;
    if (brand) {
        [self.btnBrand setTitle:self.selectedBrand.name forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnBrand setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND STAR")
                       forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#ABABAB" representedColor]
                                            forState:UIControlStateNormal];
    }
}

- (void)updateOtherbrand:(NSString *)otherBrand {
    if (otherBrand) {
        [self.btnBrand setTitle:kOtherString forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
        self.tfOtherBrand.text = otherBrand;
        self.otherBrandLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.otherBrandLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        [self.btnBrand setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND STAR")
                       forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#ABABAB" representedColor]
                            forState:UIControlStateNormal];
    }
}

- (void)updateModel:(MVehicleModel *)model {
    self.selectedModel = model;
    if (self.selectedModel) {
        [self.btnModel setTitle:self.selectedModel.model forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnModel setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL STAR")
                       forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[@"#ABABAB" representedColor]
                            forState:UIControlStateNormal];
    }
}

- (void)updateOtherModel:(NSString *)otherModel {
    if (otherModel) {
        [self.btnModel setTitle:kOtherString forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
        self.tfOtherModel.text = otherModel;
        self.otherModelLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.otherModelLayoutContraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        [self.btnModel setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL STAR")
                       forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[@"#ABABAB" representedColor]
                            forState:UIControlStateNormal];
    }
}

- (void)updateYear:(NSInteger)year {
    self.selectedYear = year;
    if (year > 0) {
        [self.btnYear setTitle:[NSString stringWithFormat:@"%ld", (long)self.selectedYear]
                      forState:UIControlStateNormal];
        [self.btnYear setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnYear setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL YEAR STAR")
                      forState:UIControlStateNormal];
        [self.btnYear setTitleColor:[@"#ABABAB" representedColor]
                            forState:UIControlStateNormal];
    }
}

- (void)updateLocation:(MLocation *)location
{
    self.selectedLocation = location;
    if (self.selectedLocation) {
        [self.btnBranch setTitle:self.selectedLocation.name
                      forState:UIControlStateNormal];
        [self.btnBranch setTitleColor:[UIColor blackColor]
                           forState:UIControlStateNormal];
    } else {
        [self.btnBranch setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRANCH")
                      forState:UIControlStateNormal];
        [self.btnBranch setTitleColor:[@"#ABABAB" representedColor]
                           forState:UIControlStateNormal];
    }
}

#pragma mark - Number Pad Delegate
- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark - Actions
- (IBAction)selectBrandAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showBrandSelectionAlert:self.brands];
}

- (IBAction)selectModelAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showVehicleModelSelectionAlert:self.vehicleModels];
}

- (IBAction)selectYearAction:(id)sender {
    [self hideTextfieldsKeyboard];
    NSArray *years = [ATMGlobal yearsSelection];
    [self.eventHandler showYearSelectionAlert:years];
}

- (IBAction)selectBranchAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showLocationSelectionAlert:self.locations];
}

- (IBAction)selectCityAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showCitySelectionAlert:self.cities];
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)otherBrandDidChange:(id)sender
{
    if (_tfOtherBrand.text.length > 0) {
        [self.eventHandler findVehicleModelsByBrand:-1];
    }
}

- (IBAction)otherModelDidChange:(id)sender {
}

- (IBAction)submitAction:(id)sender {
    MServiceRequest *request = [MServiceRequest new];
    if (self.selectedBrand && (![self.selectedBrand.name.lowercaseString isEqualToString:@"other"] && ![self.selectedBrand.name isEqualToString:@"آخر"])) {
        request.branchId = self.selectedBrand.id;
        request.brandName = self.selectedBrand.name;
        request.brand = self.selectedBrand;
    }
    
    if (self.selectedModel && (![self.selectedModel.model.lowercaseString isEqualToString:@"other"] && ![self.selectedModel.model isEqualToString:@"آخر"])) {
        request.model = self.selectedModel;
    }
    
    request.otherBrand = self.tfOtherBrand.text;
    request.otherModel = self.tfOtherModel.text;
    request.year = self.selectedYear;
    request.registrationNumber = self.tfRegistrationNumber.text;
    request.mileage = self.tfMileage.text.length == 0 ? -1 : [self.tfMileage.text integerValue];

    request.firstName = self.tfFirstName.text;
    request.lastName = self.tfLastName.text;
    request.phoneCode = @"+971";
    request.phoneNumber = self.tfPhoneNumber.text;
    request.city = self.selectedCity;
    request.location = self.selectedLocation;
    request.email = self.tfEmail.text;
    [self.eventHandler submitRequest:request];
}

#pragma mark - View Interface
- (void)updateBrands:(NSArray *)brands
{
    self.brands = brands;
}

- (void)updateVehicleModels:(NSArray *)models
{
    self.vehicleModels = models;
}

- (void)updateUserInfo:(MUser *)user
{
    self.user = user;
    
    if (self.user) {
        if ([self.user isValidString:self.user.firstName]) {
            self.tfFirstName.text = self.user.firstName;
        }
        
        if ([self.user isValidString:self.user.lastName]) {
            self.tfLastName.text = self.user.lastName;
        }
        
        if ([self.user isValidString:self.user.phoneNumber]) {
            self.tfPhoneNumber.text = self.user.phoneNumber;
        }
        
        if (self.user.phoneCode && self.user.phoneCode.length > 0) {
            [self.btnPhoneCode setTitle:self.user.phoneCode forState:UIControlStateNormal];
        } else {
            [self.btnPhoneCode setTitle:@"+971" forState:UIControlStateNormal];
        }
        
        if (self.user.city && self.user.city.name) {
            [self updateCity:self.user.city];
        }
        
    }
}

- (void)updateCities:(NSArray *)cities
{
    self.cities = cities;
}

- (void)updateLocations:(NSArray *)locations
{
    self.locations = locations;
}

- (void)didSelectCity:(id)city
{
    [self updateCity:city];
}

- (void)didSelectBrand:(MBrand *)brand
{
    // update on ui
    if (![self.selectedBrand.name isEqualToString:brand.name]) {
        [self updateModel:nil];
        self.otherModelLayoutConstraintTop.constant = 0;
        self.otherModelLayoutContraintHeight.constant = 0;
    }
    
    // update value for brand
    [self updateBrand:brand];
    
    // reset other brand
    _tfOtherBrand.text = @"";
    if ([brand.name isEqualToString:kOtherString] || [brand.name isEqualToString:kOtherStringAR]) {
        self.otherBrandLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.otherBrandLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        self.otherBrandLayoutConstraintTop.constant = 0;
        self.otherBrandLayoutConstraintHeight.constant = 0;
    }    
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.tfOtherBrand layoutIfNeeded];
        [self.tfOtherModel layoutIfNeeded];
    }];
    
    // load vehicle models by brand from database
    [self.eventHandler findVehicleModelsByBrand:self.selectedBrand.id];
}

- (void)didSelectModel:(MVehicleModel *)model
{
    [self updateModel:model];
    
    _tfOtherModel.text = @"";
    
    if ([model.model isEqualToString:kOtherString] || [model.model isEqualToString:kOtherStringAR]) {
        self.otherModelLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
        self.otherModelLayoutContraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        self.otherModelLayoutConstraintTop.constant = 0;
        self.otherModelLayoutContraintHeight.constant = 0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.tfOtherModel layoutIfNeeded];
    }];
}

- (void)didSelectYear:(NSInteger)year
{
    [self updateYear:year];
}

- (void)didSelectLocation:(MLocation *)location {
    [self updateLocation:location];
}

- (void)didClearForm
{
    
}

- (MRegisteredVehicle *)getRegisteredVehicle
{
    return _registeredVehicle;
}

- (void)hideTextfieldsKeyboard
{
    [self.tfMileage resignFirstResponder];
    [self.tfRegistrationNumber resignFirstResponder];
    [self.tfFirstName resignFirstResponder];
    [self.tfLastName resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
    [self.tfOtherBrand resignFirstResponder];
    [self.tfEmail resignFirstResponder];
}

#pragma mark - Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
