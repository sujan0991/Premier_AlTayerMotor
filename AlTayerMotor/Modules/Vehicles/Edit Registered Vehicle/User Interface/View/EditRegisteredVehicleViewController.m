//
//  EditRegisteredVehicleViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "EditRegisteredVehicleViewController.h"
#import "EditRegisteredVehicleModuleInterface.h"


#import "UIView+Border.h"
#import "ATMButton.h"

#import "NSArray+LinqExtensions.h"
#import "NSString+Color.h"

#import "MBrand.h"
#import "MVehicleModel.h"
#import "MRegisteredVehicle.h"

#define kOtherString                    @"Other"
#define kOtherStringAR                  @"آخر"
#define kOtherLayoutConstraintHeight    30
#define kOtherLayoutConstraintTop       20


@interface EditRegisteredVehicleViewController()
@property (nonatomic, strong)MRegisteredVehicle *registeredVehicle;

@property (weak, nonatomic) IBOutlet ATMButton *btnBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnModel;
@property (weak, nonatomic) IBOutlet ATMButton *btnYear;
@property (weak, nonatomic) IBOutlet UITextField *tfRegistrationNumber;
@property (weak, nonatomic) IBOutlet ATMButton *btnExpiry;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherBrand;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutConstraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutConstraintHeight;

@property (strong, nonatomic) NSArray *brands;
@property (weak, nonatomic) MBrand *selectedBrand;
@property (nonatomic, strong) NSArray *vehicleModels;
@property (nonatomic, strong) MVehicleModel *selectedModel;
@property (assign, nonatomic) NSInteger selectedYear;
@property (nonatomic, strong) NSString *selectedDate;

@end


@implementation EditRegisteredVehicleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.eventHandler findBrands];
    
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.otherBrandLayoutConstraintTop.constant = 0;
    self.otherBrandLayoutConstraintHeight.constant = 0;
    self.otherModelLayoutConstraintTop.constant = 0;
    self.otherModelLayoutConstraintHeight.constant = 0;
    
    if (_registeredVehicle) {
        if (_registeredVehicle.brand && _registeredVehicle.brand.name) {
            [self updateBrand:_registeredVehicle.brand];
        } else if (_registeredVehicle.otherBrand && _registeredVehicle.otherBrand.length > 0) {
            [self.btnBrand setTitle:kOtherString
                           forState:UIControlStateNormal];
            [self.btnBrand setTitleColor:[UIColor blackColor]
                                forState:UIControlStateNormal];
            self.tfOtherBrand.text = _registeredVehicle.otherBrand;
            self.otherBrandLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
            self.otherBrandLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
        } else {
            [self.btnBrand setTitle:@"Select Brand*" forState:UIControlStateNormal];
            [self.btnBrand setTitleColor:[@"#ABABAB" representedColor]
                                forState:UIControlStateNormal];
        }
        
//        [self didSelectBrand:_registeredVehicle.brand];
        
        if (_registeredVehicle.model && _registeredVehicle.model.model) {
            [self updateModel:_registeredVehicle.model];
        } else if (_registeredVehicle.otherModel && _registeredVehicle.otherModel.length > 0) {
            [self.btnModel setTitle:kOtherString
                           forState:UIControlStateNormal];
            [self.btnModel setTitleColor:[UIColor blackColor]
                                forState:UIControlStateNormal];
            self.tfOtherModel.text = _registeredVehicle.otherModel;
            self.otherModelLayoutConstraintTop.constant = kOtherLayoutConstraintTop;
            self.otherModelLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
        } else {
            [self.btnModel setTitle:@"Select Brand*" forState:UIControlStateNormal];
            [self.btnModel setTitleColor:[@"#ABABAB" representedColor]
                                forState:UIControlStateNormal];
        }
        
        [self updateYear:_registeredVehicle.year];
        [self updateExpiryDate:_registeredVehicle.registrationExpiry];
        self.tfRegistrationNumber.text = _registeredVehicle.registrationNumber;
    }
}

#pragma mark - Updating UI
- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = @"Edit Vehicle";
    
    UIBarButtonItem *btnOk = [[UIBarButtonItem alloc]
                              initWithTitle:@"Save"
                              style:UIBarButtonItemStylePlain
                              target:self
                              action:@selector(saveRegisteredVehicle:)];
    [btnOk setTitleTextAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:18.0],
                                     NSForegroundColorAttributeName: [@"ef6c05" representedColor] }
                         forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btnOk;
    
    [self.tfRegistrationNumber addBottomLine];
    
    [self.tfOtherBrand addBottomLine];
    [self.tfOtherModel addBottomLine];
    
    self.tfOtherBrand.placeholder = LOCALIZED(@"TEXT OTHER BRAND");
    self.tfOtherModel.placeholder = LOCALIZED(@"TEXT OTHER MODEL");
    
    
    [_tfOtherBrand addTarget:self
                      action:@selector(otherBrandDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    [_tfOtherModel addTarget:self
                      action:@selector(otherModelDidChange:)
            forControlEvents:UIControlEventEditingChanged];
}

- (void)updateBrand:(MBrand *)brand {
    self.selectedBrand = brand;
    if (self.selectedBrand) {
        [self.btnBrand setTitle:self.selectedBrand.name
                                       forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[UIColor blackColor]
                                            forState:UIControlStateNormal];
    } else {
        [self.btnBrand setTitle:@"Select Brand*" forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#ABABAB" representedColor]
                                            forState:UIControlStateNormal];
    }
    
}

- (void)updateModel:(MVehicleModel *)model {
    self.selectedModel = model;
    if (model) {
        [self.btnModel setTitle:self.selectedModel.model
                                       forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[UIColor blackColor]
                                            forState:UIControlStateNormal];
    } else {
        [self.btnModel setTitle:@"Select Model*"
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
        [self.btnYear setTitle:@"Select Model Year*"
                                      forState:UIControlStateNormal];
        [self.btnYear setTitleColor:[@"#ABABAB" representedColor]
                                           forState:UIControlStateNormal];
    }
}

- (void)updateExpiryDate:(NSString *)expiry {
    self.selectedDate = expiry;
    if (expiry && expiry.length > 0) {
        [self.btnExpiry setTitle:expiry forState:UIControlStateNormal];
        [self.btnExpiry setTitleColor:[UIColor blackColor]
                                             forState:UIControlStateNormal];
    } else {
        [self.btnExpiry setTitle:@"Registration Expiry*"
                                        forState:UIControlStateNormal];
        [self.btnExpiry setTitleColor:[@"#ABABAB" representedColor]
                                             forState:UIControlStateNormal];
    }
}

#pragma mark - View Interface
- (void)setRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    _registeredVehicle = vehicle;
}

- (void)updateBrands:(NSArray *)brands
{
    self.brands = brands;
}

- (void)updateVehicleModels:(NSArray *)models
{
    self.vehicleModels = models;
}

- (IBAction)otherBrandDidChange:(id)sender
{
    if (_tfOtherBrand.text.length > 0) {
        [self.eventHandler findVehicleModelsByBrand:-1];
    }
}

- (IBAction)otherModelDidChange:(id)sender {
}

- (void)didSelectBrand:(MBrand *)brand
{
    // update on ui
    if (![self.selectedBrand.name isEqualToString:brand.name]) {
        [self updateModel:nil];
        self.otherModelLayoutConstraintTop.constant = 0;
        self.otherModelLayoutConstraintHeight.constant = 0;
    }
    
    [self updateBrand:brand];
    
    // reset other brand
    _tfOtherBrand.text = @"";
    if ([brand.name isEqualToString:kOtherString]) {
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
        self.otherModelLayoutConstraintHeight.constant = kOtherLayoutConstraintHeight;
    } else {
        self.otherModelLayoutConstraintTop.constant = 0;
        self.otherModelLayoutConstraintHeight.constant = 0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.tfOtherModel layoutIfNeeded];
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

#pragma mark - Actions
- (IBAction)saveRegisteredVehicle:(id)sender
{
    DLog();
    MRegisteredVehicle *registeredVehicle = [MRegisteredVehicle new];
    if (self.selectedBrand && (![self.selectedBrand.name isEqualToString:kOtherString] || ![self.selectedBrand.name isEqualToString:kOtherStringAR])) {
        registeredVehicle.brandId = self.selectedBrand.id;
    }
    
    registeredVehicle.otherBrand = self.tfOtherBrand.text;
    
    if (self.selectedModel && (![self.selectedModel.model isEqualToString:kOtherString] || ![self.selectedModel.model isEqualToString:kOtherString])) {
        registeredVehicle.model = self.selectedModel;
    }
    
    registeredVehicle.otherModel = self.tfOtherModel.text;
    registeredVehicle.year = self.selectedYear;
    registeredVehicle.registrationExpiry = self.selectedDate;
    registeredVehicle.registrationNumber = self.tfRegistrationNumber.text;
    
    [self.eventHandler saveRegisteredVehicle:registeredVehicle withCurrentVehicle:_registeredVehicle];
}

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

- (IBAction)selectExpiryAction:(id)sender {
    [self hideTextfieldsKeyboard];
    self.selectedDate = [self.selectedDate isEqualToString:@"Registration Expiry*"] ? nil : self.selectedDate;
    [self.eventHandler showDateSelectionAlert:self.selectedDate];
}


#pragma mark - Other
- (void)hideTextfieldsKeyboard
{
    [self.tfRegistrationNumber resignFirstResponder];
}

@end
