//
//  BookingTestViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestViewController.h"
#import "BookingTestModuleInterface.h"
#import "UINavigationController+StatusBarStyle.h"
#import "TPKeyboardAvoidingScrollView.h"

#import "ATMCircleView.h"
#import "ATMButton.h"
#import "ATMTextField.h"
#import "NumberPadToolbar.h"
#import "DateManager.h"

#import "UIView+Border.h"
#import "NSString+Utils.h"
#import "ViewUtils.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MUser.h"
#import "MBookingTestRequest.h"
#import "MCity.h"
#import "MLocation.h"

typedef void (^HandlingBlock)();

@interface BookingTestViewController() <UITextFieldDelegate, NumberPadToolbarDelegate>

@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *vehicleModels;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) MUser *user;

@property (strong, nonatomic) MBrand *selectedBrand;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) MVehicleModel *selectedModel;
@property (strong, nonatomic) MLocation *selectedLocation;
@property (strong, nonatomic) MCity *selectedCity;
@property (strong, nonatomic) NSDate *birthday;
@property (assign, nonatomic) BOOL isReceivedInfor;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ATMCircleView *dotBrand;
@property (weak, nonatomic) IBOutlet ATMCircleView *dotModel;
@property (weak, nonatomic) IBOutlet ATMCircleView *dotBranch;
@property (weak, nonatomic) IBOutlet ATMButton *btnBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnModel;
@property (weak, nonatomic) IBOutlet ATMButton *btnBranch;


@property (weak, nonatomic) IBOutlet ATMTextField *tfFirstName;
@property (weak, nonatomic) IBOutlet ATMTextField *tfLastName;
@property (weak, nonatomic) IBOutlet ATMButton *btnBirthday;
@property (weak, nonatomic) IBOutlet ATMTextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet ATMButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnReceiveInfor;
@property (weak, nonatomic) IBOutlet UIButton *btnSendEnquiry;
@property (weak, nonatomic) IBOutlet UIButton *btnContactDealer;
@property (weak, nonatomic) IBOutlet ATMTextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imvReceiveInfo;


@property (weak, nonatomic) IBOutlet UILabel *lbCarInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleAboutYourself;

@end

@implementation BookingTestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    self.tfFirstName.tag = 1001;
    
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(self.navigationController.navigationBar);
    AFFINE_TRANSFORM(_scrollView);
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }

    for (UIView *subview in [_scrollView allSubviews]) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
        }
    }
    
    AFFINE_TRANSFORM(_lbCarInfo);
    AFFINE_TRANSFORM(_lbTitleAboutYourself);
    
    [@[_btnBrand, _btnModel, _btnBranch, _btnCity, _btnBirthday] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UIView *subview in [view allSubviews]) {
            if ([subview isKindOfClass:[UILabel class]]) {
                AFFINE_TRANSFORM(subview);
            }
        }
    }];

    [_btnReceiveInfor.layer setAffineTransform:LANGUAGE_TRANSFORM];
    
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE BOOK A TEST DRIVE");
    self.lbCarInfo.text = LOCALIZED(@"TEXT WHAT WOULD YOU LIKE TO TEST DRIVE");
    self.lbTitleAboutYourself.text = LOCALIZED(@"TEXT TELL US ABOUT YOURSELF");
    self.tfEmail.placeholder = LOCALIZED(@"TEXT PLACEHOLDER EMAIL");
    self.tfFirstName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER FIRST NAME");
    self.tfLastName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER LAST NAME");
    self.tfPhoneNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER PHONE NUMBER");
    
    [self updateBrand:_selectedBrand];
    [self updateModel:_selectedModel];
    [self updateLocation:_selectedLocation];
    [self updateBirthday:_birthday];
    [self updateCity:_selectedCity];
    
    self.imvReceiveInfo.image = [UIImage imageNamed:[NSString stringWithFormat:@"text_receive_infor%@", ([ATMGlobal isEnglish] ? @"" : @"_ar")]];
    self.imvReceiveInfo.contentMode = [ATMGlobal isEnglish] ? UIViewContentModeLeft : UIViewContentModeRight;
    
    [self.btnContactDealer setImage:[UIImage imageNamed:[NSString stringWithFormat:@"contact_atm%@", [ATMGlobal isEnglish] ? @"" : @"_ar"]]
                           forState:UIControlStateNormal];
    
    [self.btnSendEnquiry setImage:[UIImage imageNamed:[NSString stringWithFormat:@"send_an_enquiry%@", [ATMGlobal isEnglish] ? @"" : @"_ar"]]
                           forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.selectedBrand) {
        [self didSelectBrand:self.selectedBrand];
    }
    
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
    
    [self.eventHandler findBrands];
    [self.eventHandler findUserInfo];
    [self.eventHandler findCities];
    [self.eventHandler findLocations];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenBookTestDrive];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideTextfieldsKeyboard];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self animating:^{
        [@[self.tfFirstName, self.tfLastName, self.tfPhoneNumber] enumerateObjectsUsingBlock:^(UITextField *tf, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_down"]];
            imageView.frame = CGRectMake(tf.width - 20, (tf.height - 17) / 2, 17, 17);
            imageView.tag = 1000;
            imageView.hidden = YES;
            [tf addSubview:imageView];
        }];
    } completion:^{
        [self layoutByLanguage];
    }];
}

- (void)setupViews
{
    // Navigation View
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE BOOK A TEST DRIVE");
    
    // Form
    [@[self.tfFirstName, self.tfLastName, self.tfPhoneNumber, self.tfEmail] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setDelegate:self];
    }];
    
    [[self.tfFirstName rightButton] addTarget:self
                                       action:@selector(clearFirstNameAction:)
                             forControlEvents:UIControlEventTouchUpInside];
    
    [[self.tfLastName rightButton] addTarget:self
                                       action:@selector(clearLastNameAction:)
                             forControlEvents:UIControlEventTouchUpInside];
    
    [[self.tfPhoneNumber rightButton] addTarget:self
                                       action:@selector(clearPhoneNumberAction:)
                             forControlEvents:UIControlEventTouchUpInside];
    
    [[self.tfEmail rightButton] addTarget:self
                                   action:@selector(clearEmailAction:)
                               forControlEvents:UIControlEventTouchUpInside];
    
    self.dotBrand.isBig = YES;
    self.btnModel.hidden = YES;
    self.btnBranch.hidden = YES;
    
    [self.btnBrand addTarget:self action:@selector(selectBrandAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnModel addTarget:self action:@selector(selectModelAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBranch addTarget:self action:@selector(selectLocationAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCity addTarget:self action:@selector(selectCityAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBirthday addTarget:self action:@selector(selectBirthdayAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // NumberPad
    NumberPadToolbar *toolbar = [[NumberPadToolbar alloc] initWithTextField:self.tfPhoneNumber];
    toolbar.numberPadDelegate = self;
    self.tfPhoneNumber.inputAccessoryView = toolbar;
    
    // Border Buttons
    [@[self.btnReceiveInfor, self.btnSendEnquiry, self.btnContactDealer] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addBorder];
    }];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(checkReceiveInforAction:)];
    tapGesture1.numberOfTapsRequired = 1;
    [self.imvReceiveInfo setUserInteractionEnabled:YES];
    [self.imvReceiveInfo addGestureRecognizer:tapGesture1];
}


- (void)updateCity:(MCity *)city {
    self.selectedCity = city;
    if (city) {
        [self.btnCity setTitle:self.selectedCity.name forState:UIControlStateNormal];
    } else {
        [self.btnCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY") forState:UIControlStateNormal];
    }
}

- (void)updateBrand:(MBrand *)brand {
    self.selectedBrand = brand;
    if (brand) {
        [self.btnBrand setTitle:self.selectedBrand.name forState:UIControlStateNormal];
        [self.btnBrand setSelectedState:YES];
    } else {
        [self.btnBrand setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND") forState:UIControlStateNormal];
        [self.btnBrand setSelectedState:NO];
    }
}

- (void)updateModel:(MVehicleModel *)model {
    self.selectedModel = model;
    if (model) {
        [self.btnModel setTitle:self.selectedModel.model forState:UIControlStateNormal];
        [self.btnModel setSelectedState:YES];
    } else {
        [self.btnModel setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL") forState:UIControlStateNormal];
        [self.btnModel setSelectedState:NO];
    }
}

- (void)updateLocation:(MLocation *)location {
    self.selectedLocation = location;
    if (location) {
        [self.btnBranch setTitle:self.selectedLocation.name forState:UIControlStateNormal];
        [self.btnBranch setSelectedState:YES];
    } else {
        [self.btnBranch setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRANCH") forState:UIControlStateNormal];
        [self.btnBranch setSelectedState:NO];
    }
}

- (void)updateBirthday:(NSDate *)birthday {
    self.birthday = birthday;
    if (birthday) {
//        NSDate* now = [NSDate date];
//        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
//                                           components:NSCalendarUnitYear
//                                           fromDate:birthday
//                                           toDate:now
//                                           options:0];
//        NSInteger age = [ageComponents year];
//        NSString *yearsOld = [NSString stringWithFormat:@"%ld %@", (long)age, LOCALIZED(@"TEXT YEARS OLD")];
        NSString *dob = [[[DateManager sharedManager] presentedDateFormatter] stringFromDate:birthday];
        [self.btnBirthday setTitle:dob forState:UIControlStateNormal];
    } else {
        [self.btnBirthday setTitle:LOCALIZED(@"TEXT SELECT DATE OF BIRTH STAR") forState:UIControlStateNormal];
    }
}

- (void) showDotModel:(BOOL)isBig
{
    self.dotModel.isBig = isBig;
    [self.dotModel setNeedsLayout];
    self.btnModel.hidden = !isBig;
}

- (void) showDotBranch:(BOOL)isBig
{
    self.dotBranch.isBig = isBig;
    [self.dotBranch setNeedsLayout];
    self.btnBranch.hidden = !isBig;
}


#pragma mark - Actions
- (void)selectBrandAction:(id)sender withEvent:(UIEvent *)event
{
    [self hideTextfieldsKeyboard];
    UITouch *touch = [[event touchesForView:self.btnBrand] anyObject];
    CGPoint location = [touch locationInView:self.btnBrand];
    BOOL rightImageTouched = CGRectContainsPoint(CGRectInset([self.btnBrand rightImageFrame], -10, -10), location);
    if ([self.btnBrand isSelectedState] && rightImageTouched) {
        [self updateBrand:nil];
        self.vehicleModels = nil;
        [self updateModel:nil];
        [self showDotModel:NO];
    } else {
        [self.eventHandler showBrandSelectionAlert:self.brands];
    }
    
}

- (void)selectModelAction:(id)sender withEvent:(UIEvent *)event {
    [self hideTextfieldsKeyboard];
    UITouch *touch = [[event touchesForView:self.btnModel] anyObject];
    CGPoint location = [touch locationInView:self.btnModel];
    BOOL rightImageTouched = CGRectContainsPoint(CGRectInset([self.btnModel rightImageFrame], -10, -10), location);
    if ([self.btnModel isSelectedState] && rightImageTouched) {
        [self updateModel:nil];
        [self.btnModel setSelectedState:NO];
//        [self updateLocation:nil];
//        [self.btnBranch setSelectedState:NO];
//        [self showDotBranch:NO];
    } else {
        [self.eventHandler showVehicleModelSelectionAlert:self.vehicleModels];
    }
}

- (void)selectLocationAction:(id)sender withEvent:(UIEvent *)event {
    [self hideTextfieldsKeyboard];
    UITouch *touch = [[event touchesForView:self.btnBranch] anyObject];
    CGPoint location = [touch locationInView:self.btnBranch];
    BOOL rightImageTouched = CGRectContainsPoint(CGRectInset([self.btnBranch rightImageFrame], -10, -10), location);
    if ([self.btnBranch isSelectedState] && rightImageTouched) {
        [self updateLocation:nil];
    } else {
        NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:0];
        if (_selectedBrand) {
            [self.locations enumerateObjectsUsingBlock:^(MLocation  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DLog(@"%@", obj.name);  
                if ([obj.brandids containsObject:@(_selectedBrand.id)]) {
                    [tmpArr addObject:obj];
                }
            }];
        } else {
            tmpArr = [NSMutableArray arrayWithArray:self.locations];
        }
        
        [self.eventHandler showLocationSelectionAlert:tmpArr];
    }
}

- (void)selectCityAction:(id)sender withEvent:(UIEvent *)event {
    [self hideTextfieldsKeyboard];
    UITouch *touch = [[event touchesForView:self.btnCity] anyObject];
    CGPoint location = [touch locationInView:self.btnCity];
    BOOL rightImageTouched = CGRectContainsPoint(CGRectInset([self.btnCity rightImageFrame], -10, -10), location);
    if ([self.btnCity isSelectedState] && rightImageTouched) {
        [self updateCity:nil];
        [self.btnCity setSelectedState:NO];
    } else {
        [self.eventHandler showCitySelectionAlert:self.cities];
    }
}

- (void)selectBirthdayAction:(id)sender withEvent:(UIEvent *)event {
    [self hideTextfieldsKeyboard];
    UITouch *touch = [[event touchesForView:self.btnBirthday] anyObject];
    CGPoint location = [touch locationInView:self.btnBirthday];
    BOOL rightImageTouched = CGRectContainsPoint(CGRectInset([self.btnBirthday rightImageFrame], -10, -10), location);
    if ([self.btnBirthday isSelectedState] && rightImageTouched) {
        [self updateBirthday:nil];
        [self.btnBirthday setSelectedState:NO];
    } else {
        [self.eventHandler showBirthdaySelectionAlert:self.birthday];
    }
}

- (void)animating:(HandlingBlock)animation completion:(HandlingBlock)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        // handle completion here
        completion();
    }];
    animation();
    [CATransaction commit];
}

- (void)clearFirstNameAction:(id)sender
{
    [self animating:^{
        [self.tfFirstName setText:@""];
    } completion:^{
        [self.tfFirstName becomeFirstResponder];
    }];
}

- (void)clearLastNameAction:(id)sender
{
    [self animating:^{
        [self.tfLastName setText:@""];
    } completion:^{
        [self.tfLastName becomeFirstResponder];
    }];
}

- (void)clearPhoneNumberAction:(id)sender
{
    [self animating:^{
        [self.tfPhoneNumber setText:@""];
    } completion:^{
        [self.tfPhoneNumber becomeFirstResponder];
    }];
}

- (void)clearEmailAction:(id)sender
{
    [self animating:^{
        [self.tfEmail setText:@""];
    } completion:^{
        self.tfEmail.text = @"";
        [self.tfEmail becomeFirstResponder];
    }];
}

- (IBAction)checkReceiveInforAction:(id)sender {
    self.isReceivedInfor = !self.isReceivedInfor;
    [self.btnReceiveInfor setImage:(self.isReceivedInfor ? [UIImage imageNamed:@"icon_check"] : nil)
                           forState:UIControlStateNormal];
}

- (IBAction)sendEnquiryAction:(id)sender {
    MBookingTestRequest *booking = [MBookingTestRequest new];
    booking.brand = self.selectedBrand;
    booking.model = self.selectedModel;
    booking.location = self.selectedLocation;
    booking.firstName = self.tfFirstName.text;
    booking.lastName = self.tfLastName.text;
    booking.phoneNumber = self.tfPhoneNumber.text;
    booking.birthday = self.birthday;
    booking.city = self.selectedCity;
    booking.isReceivedInfor = self.isReceivedInfor;
    booking.email = self.tfEmail.text;
    
    [self.eventHandler sendBookingTestRequest:booking];
}

- (IBAction)contactDealerAction:(id)sender {
    [ATMGlobal callDealer];
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
        if (![user.firstName isInvalid]) {
            self.tfFirstName.text = user.firstName;
            [self.tfFirstName setSelectedState:YES];
        }
        
        if (![user.lastName isInvalid]) {
            self.tfLastName.text = user.lastName;
            [self.tfLastName setSelectedState:YES];
        }
        
        if (![user.phoneCode isInvalid] || ![user.phoneNumber isInvalid]) {
            NSString *phoneCode = [user.phoneCode isInvalid] || !user.phoneCode ? @"" : user.phoneCode;
            NSString *phoneNumber = [user.phoneNumber isInvalid] || !user.phoneNumber ? @"" : user.phoneNumber;
            if (phoneCode.length > 0 && phoneNumber.length > 0) {
                self.tfPhoneNumber.text = [NSString stringWithFormat:@"%@ %@", phoneCode, phoneNumber];
            }
            [self.tfPhoneNumber setSelectedState:YES];
        }
        
        if (user.city && user.city.name) {
            [self updateCity:user.city];
            [self.btnCity setSelectedState:YES];
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

- (void)setInitializeBrand:(MBrand *)brand
{
    self.selectedBrand = brand;
}

- (void)didSelectCity:(id)city
{
    [self updateCity:city];
    [self.btnCity setSelectedState:YES];
}

- (void)didSelectBrand:(MBrand *)brand
{
    // update on ui
    if (![self.selectedBrand.name isEqualToString:brand.name]) {
        [self updateModel:nil];
    }
    
    [self updateBrand:brand];
    
    // load vehicle models by brand from database
    [self.eventHandler findVehicleModelsByBrand:self.selectedBrand.id];
    
    // Show model selection
    [self showDotModel:YES];
}

- (void)didSelectModel:(MVehicleModel *)model
{
    [self updateModel:model];
    [self.btnModel setSelectedState:YES];
    
    // Show year selection
    [self showDotBranch:YES];
}

- (void)didSelectLocation:(MLocation *)location
{
    [self updateLocation:location];
    [self.btnBranch setSelectedState:YES];
}

- (void)didSelectBirthday:(NSDate *)birthday
{
    [self updateBirthday:birthday];
    [self.btnBirthday setSelectedState:YES];
}

- (void)didClearForm
{
    // Clear Form
    [self updateBrand:nil];
    [self.btnBrand setSelectedState:NO];
    
    [self updateModel:nil];
    [self showDotModel:NO];
    [self.btnModel setSelectedState:NO];
    
    [self updateLocation:nil];
    [self showDotBranch:NO];
    [self.btnBranch setSelectedState:NO];
    
    _tfFirstName.text = @"";
    [_tfFirstName setSelectedState:NO];
    
    _tfLastName.text = @"";
    [_tfLastName setSelectedState:NO];
    
    _tfPhoneNumber.text = @"";
    [_tfPhoneNumber setSelectedState:NO];
    
    _tfEmail.text = @"";
    [_tfEmail setSelectedState:NO];
    
    [self updateBirthday:nil];
    [self.btnBirthday setSelectedState:NO];
    
    [self updateCity:nil];
    [self.btnCity setSelectedState:NO];
    
    self.isReceivedInfor = NO;
    [self.btnReceiveInfor setImage:nil
                          forState:UIControlStateNormal];
    
    // Update User Info
    [self updateUserInfo:nil];
    
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _tfFirstName) {
        [_tfFirstName setSelectedState:NO];
    } else if (textField == _tfLastName) {
        [_tfLastName setSelectedState:NO];
    } else if (textField == _tfPhoneNumber) {
        [_tfPhoneNumber setSelectedState:NO];
    } else if (textField == _tfEmail) {
        [_tfEmail setSelectedState:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _tfFirstName && _tfFirstName.text.length > 0) {
        [_tfFirstName setSelectedState:YES];
    } else if (textField == _tfLastName && _tfLastName.text.length > 0) {
        [_tfLastName setSelectedState:YES];
    } else if (textField == _tfPhoneNumber && _tfPhoneNumber.text.length > 0) {
        [_tfPhoneNumber setSelectedState:YES];
    } else if (textField == _tfEmail && _tfEmail.text.length > 0) {
        [_tfEmail setSelectedState:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)hideTextfieldsKeyboard
{
    [self.tfEmail resignFirstResponder];
    [self.tfFirstName resignFirstResponder];
    [self.tfLastName resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
}


#pragma mark - Number Pad Delegate

- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UITextField *)textField
{
    [textField resignFirstResponder];
}

@end
