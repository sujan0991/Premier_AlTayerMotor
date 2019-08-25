//
//  InsuranceViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceViewController.h"
#import "ATMButton.h"
#import "ATMFullRowButton.h"
#import "UIView+Border.h"
#import "NSString+Color.h"
#import "MUser.h"
#import "MInsuranceRequest.h"
#import "MCity.h"
#import "MDrivingExperience.h"

#import "NumberPadToolbar.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "DateManager.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface InsuranceViewController() <NumberPadToolbarDelegate> {
    
}

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *drivingExperiences;
@property (strong, nonatomic) MUser *user;

@property (strong, nonatomic) MDrivingExperience *drivingExperience;
@property (strong, nonatomic) MCity *city;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIImage *frontCard;
@property (strong, nonatomic) UIImage *backCard;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scanFrontView;
@property (weak, nonatomic) IBOutlet UIView *scanBackView;
@property (weak, nonatomic) IBOutlet UIImageView *imvScanFront;
@property (weak, nonatomic) IBOutlet UIImageView *imvScanBack;
@property (weak, nonatomic) IBOutlet UIButton *btnScanFront;
@property (weak, nonatomic) IBOutlet UIButton *btnScanBack;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet ATMButton *btnBirthday;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet ATMButton *btnSelectCity;
@property (weak, nonatomic) IBOutlet ATMButton *btnDrivingExperience;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnSubmit;
@property (weak, nonatomic) IBOutlet ATMButton *btnPhoneCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbHeadline;
@property (weak, nonatomic) IBOutlet UILabel *lbScanHeadline;
@property (weak, nonatomic) IBOutlet UILabel *lbAboutHeadline;
@property (weak, nonatomic) IBOutlet UIView *viewButtons;


@end

@implementation InsuranceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViews];
    [self layoutByLanguage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler findCities];
    [self.eventHandler findDrivingExperiences];
    [self.eventHandler findUserInfo];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad inScreenName:kScreenRenewInsurance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)layoutByLanguage
{
    // Navigation
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE RENEW INSURANCE");
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    // ScrollView
    AFFINE_TRANSFORM(_scrollView);
    for (UIView *subview in [_scrollView allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UITextField class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    AFFINE_TRANSFORM(_btnBirthday.rightImage);
    AFFINE_TRANSFORM(_btnScanBack);
    AFFINE_TRANSFORM(_btnScanFront);
    AFFINE_TRANSFORM(_viewButtons);
    
    TEXT_ALIGN(_tfFirstName);
    TEXT_ALIGN(_tfLastName);
    TEXT_ALIGN(_tfPhoneNumber);
    
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
    
    [_btnCancel setTitle:LOCALIZED(@"TEXT CANCEL") forState:UIControlStateNormal];
    [_btnSubmit setTitle:LOCALIZED(@"TEXT SUBMIT") forState:UIControlStateNormal];
    _lbHeadline.text = LOCALIZED(@"TEXT RENEW INSURANCE HEADLINE");
    _lbScanHeadline.text = LOCALIZED(@"TEXT TITLE SCAN VEHICLE");
    _lbAboutHeadline.text = LOCALIZED(@"TEXT TELL US ABOUT YOURSELF");
    self.tfFirstName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER FIRST NAME");
    self.tfLastName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER LAST NAME");
    self.tfPhoneNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER PHONE NUMBER");
    
    [self didSelectBirthday:_birthday];
    [self didSelectCity:_city];
    [self didSelectDrivingExperience:_drivingExperience];
}

- (void)setupViews
{
    // Navigation
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // View
    [self.scanFrontView addBorder];
    [self.scanBackView addBorder];
    [self.btnSubmit addBorder];
    [self.btnCancel addBorder];
    [@[self.tfFirstName, self.tfLastName, self.btnBirthday, self.phoneView, self.btnSelectCity, self.btnDrivingExperience] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addBottomLine];
    }];
    
    // NumberPad
    NumberPadToolbar *toolbar = [[NumberPadToolbar alloc] initWithTextField:self.tfPhoneNumber];
    toolbar.numberPadDelegate = self;
    self.tfPhoneNumber.inputAccessoryView = toolbar;
    
    [self setDefaultValue];
}

- (void)setDefaultValue
{
    [self.btnScanBack setImage:IMAGE_MULTIPLE_LANGUAGE(@"card_back")
                      forState:UIControlStateNormal];
    [self.btnScanBack setBackgroundColor:[UIColor clearColor]];
    
    [self.btnScanFront setImage:IMAGE_MULTIPLE_LANGUAGE(@"card_front")
                       forState:UIControlStateNormal];
    [self.btnScanFront setBackgroundColor:[UIColor clearColor]];
    
    self.frontCard = nil;
    self.imvScanFront.image = nil;
    
    self.backCard = nil;
    self.imvScanBack.image = nil;
    
    [self.tfFirstName setText:@""];
    [self.tfLastName setText:@""];
    [self.tfPhoneNumber setText:@""];
    
    [self.btnBirthday setTitle:LOCALIZED(@"TEXT SELECT DATE OF BIRTH STAR")
                      forState:UIControlStateNormal];
    [self.btnBirthday setTitleColor:[@"#ABABAB" representedColor]
                           forState:UIControlStateNormal];
    
    [self.btnSelectCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                        forState:UIControlStateNormal];
    [self.btnSelectCity setTitleColor:[@"#ABABAB" representedColor]
                             forState:UIControlStateNormal];
    
    [self.btnDrivingExperience setTitle:LOCALIZED(@"TEXT SELECT PREFERRED CALL TIME")
                               forState:UIControlStateNormal];
    [self.btnDrivingExperience setTitleColor:[@"#ABABAB" representedColor]
                                    forState:UIControlStateNormal];
    
    [self.btnPhoneCode setTitle:@"+971"
                       forState:UIControlStateNormal];
    
    
}

#pragma mark - Actions
- (IBAction)selectBirthdayAction:(id)sender {
    [self hideTextfieldsKeyboard];
    
    [self.eventHandler showBirthdaySelectionAlert:self.birthday];
}

- (IBAction)selectCityAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showCitySelectionAlert:self.cities];
}

- (IBAction)selectDrivingExperienceAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showDrivingExperienceSelectionAlert:self.drivingExperiences];
}

- (IBAction)selectCardFrontAction:(id)sender {
    if (self.frontCard) {
        [self.eventHandler deleteCardSide:CardSideFront];
    } else {
        [self.eventHandler takePhoto:CardSideFront];
    }
}

- (IBAction)selectCardBackAction:(id)sender {
    if (self.backCard) {
        [self.eventHandler deleteCardSide:CardSideBack];
    } else {
        [self.eventHandler takePhoto:CardSideBack];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self.eventHandler clearForm];
}

- (IBAction)submitAction:(id)sender {
    MInsuranceRequest *request = [MInsuranceRequest new];
    request.frontCard = self.frontCard;
    request.backCard = self.backCard;
    request.firstName = self.tfFirstName.text;
    request.lastName = self.tfLastName.text;
    request.birthday = self.birthday;
    request.phoneCode = [self.btnPhoneCode titleForState:UIControlStateNormal];
    request.phoneNumber= self.tfPhoneNumber.text;
    request.city = self.city;
    request.drivingExperience = self.drivingExperience.key;
    
    [self.eventHandler submitRequest:request];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventSubmit inScreenName:kScreenRenewInsuranceSubmit];
}

#pragma mark - Number Pad Delegate

- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark - View Interface
- (void)updateCities:(NSArray *)cities
{
    self.cities = cities;
}

- (void)updateDrivingExperiences:(NSArray *)drivingExperiences
{
    self.drivingExperiences = drivingExperiences;
}

- (void)updateUserInfo:(MUser *)user
{
    if (user) {
        self.user = user;
    }
    
    if (self.user) {
        self.tfFirstName.text = user.firstName;
        self.tfLastName.text = user.lastName;
        [self didSelectCity:user.city];
        self.tfPhoneNumber.text = user.phoneNumber;
    }
}

- (void)didSelectBirthday:(NSDate *)birthday
{
    self.birthday = birthday;
    if (self.birthday) {
        NSString *birthdayStr = [[[DateManager sharedManager] presentedDateFormatter] stringFromDate:self.birthday];
        [self.btnBirthday setTitle:birthdayStr
                          forState:UIControlStateNormal];
        [self.btnBirthday setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
    } else {
        [self.btnBirthday setTitle:LOCALIZED(@"TEXT SELECT DATE OF BIRTH STAR")
                          forState:UIControlStateNormal];
        [self.btnBirthday setTitleColor:[@"#ABABAB" representedColor]
                               forState:UIControlStateNormal];
    }
}

- (void)didSelectCity:(MCity *)city
{
    self.city = city;
    if (self.city && self.city.name) {
        [self.btnSelectCity setTitle:self.city.name
                          forState:UIControlStateNormal];
        [self.btnSelectCity setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
    } else {
        [self.btnSelectCity setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                            forState:UIControlStateNormal];
        [self.btnSelectCity setTitleColor:[@"#ABABAB" representedColor]
                                 forState:UIControlStateNormal];
    }
}

- (void)didSelectDrivingExperience:(MDrivingExperience *)exp
{
    self.drivingExperience = exp;
    if (self.drivingExperience) {
        [self.btnDrivingExperience setTitle:self.drivingExperience.name
                                   forState:UIControlStateNormal];
        [self.btnDrivingExperience setTitleColor:[UIColor blackColor]
                                        forState:UIControlStateNormal];
    } else {
        [self.btnDrivingExperience setTitle:LOCALIZED(@"TEXT SELECT PREFERRED CALL TIME")
                                   forState:UIControlStateNormal];
        [self.btnDrivingExperience setTitleColor:[@"#ABABAB" representedColor]
                                        forState:UIControlStateNormal];
    }
}

- (void)didTakenPhoto:(UIImage *)image forSide:(CardSide)cardSide
{
    if (cardSide == CardSideFront) {
        self.frontCard = image;
        self.imvScanFront.image = self.frontCard;
        [self.btnScanFront setImage:[UIImage imageNamed:@"icon_delete"]
                           forState:UIControlStateNormal];
        [self.btnScanFront setBackgroundColor:[@"#00000099" representedColor]];
    } else {
        self.backCard = image;
        self.imvScanBack.image = self.backCard;
        [self.btnScanBack setImage:[UIImage imageNamed:@"icon_delete"]
                          forState:UIControlStateNormal];
        [self.btnScanBack setBackgroundColor:[@"#00000099" representedColor]];
    }
}

- (void)didDeleteCardSide:(CardSide)cardSide
{
    if (cardSide == CardSideFront) {
        self.frontCard = nil;
        self.imvScanFront.image = nil;
        [self.btnScanFront setImage:IMAGE_MULTIPLE_LANGUAGE(@"card_front")
                           forState:UIControlStateNormal];
        [self.btnScanFront setBackgroundColor:[UIColor clearColor]];
    } else {
        self.backCard = nil;
        self.imvScanBack.image = nil;
        [self.btnScanBack setImage:IMAGE_MULTIPLE_LANGUAGE(@"card_back")
                          forState:UIControlStateNormal];
        [self.btnScanBack setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)didClearForm
{
    [self setDefaultValue];
    [self updateUserInfo:nil];
}

- (void)hideTextfieldsKeyboard
{
    [self.tfFirstName resignFirstResponder];
    [self.tfLastName resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
}

@end
