//
//  EnquiryViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryViewController.h"
#import "EnquiryModuleInterface.h"

#import "UIView+Border.h"
#import "NSString+Color.h"
#import "NSString+Utils.h"
#import "UITextView+Placeholder.h"

#import "ATMButton.h"
#import "ATMFullRowButton.h"
#import "THNotesTextView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "NumberPadToolbar.h"

#import "MBrand.h"
#import "MPreownedBrand.h"
#import "MUser.h"
#import "MEnquiryRequest.h"
#import "MGlobalSetting.h"
#import "MVehicleModel.h"
#import "MPreownedVehicleModel.h"

@interface EnquiryViewController ()<NumberPadToolbarDelegate>

@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) NSArray *preownedBrands;
@property (strong, nonatomic) NSArray *models;
@property (strong, nonatomic) NSArray *preownedModels;
@property (strong, nonatomic) MUser *user;
@property (strong, nonatomic) NSArray *enquiries;
@property (strong, nonatomic) NSArray *vehicleEnquiries;

@property (strong, nonatomic) MBrand *selectedBrand;
@property (strong, nonatomic) MPreownedBrand *selectedPreownedBrand;
@property (strong, nonatomic) MVehicleModel *selectedModel;
@property (strong, nonatomic) MPreownedVehicleModel *selectedPreownedModel;
@property (assign, nonatomic) NSInteger prefillBrandId;
@property (assign, nonatomic) NSInteger prefillModelId;
@property (strong, nonatomic) MGlobalSetting *selectedEnquiry;
@property (strong, nonatomic) MGlobalSetting *selectedType;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ATMButton *btnEnquiry;
@property (weak, nonatomic) IBOutlet ATMButton *btnType;
@property (weak, nonatomic) IBOutlet ATMButton *btnBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnModel;
@property (weak, nonatomic) IBOutlet UILabel *lbAdditionalMessage;
@property (weak, nonatomic) IBOutlet THNotesTextView *tvMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet ATMButton *btnPhoneCode;
@property (weak, nonatomic) IBOutlet UIImageView *iconQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleEnquiry;
@property (weak, nonatomic) IBOutlet UIView *viewUserInfo;
@property (weak, nonatomic) IBOutlet UIView *viewButtons;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;

@end

@implementation EnquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutByLanguage];
    [self.eventHandler findEnquiries];
    [self.eventHandler findBrands];
    [self.eventHandler findPreownedBrands];
    [self.eventHandler findUserInfo];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenSendEnquiry];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    AFFINE_TRANSFORM(_scrollView);
    
    for (UIView *subview in [_scrollView allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UITextView class]] ||
            [subview isKindOfClass:[UITextField class]]) {
            if (subview != _tvMessage.placeholderLabel) {
                AFFINE_TRANSFORM(subview);
            }
        }
    }
    AFFINE_TRANSFORM(_viewButtons);
    AFFINE_TRANSFORM(_iconQuestion);
    
    TEXT_ALIGN(_lbAdditionalMessage);
    TEXT_ALIGN(_tvMessage);
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
    
    _tfFirstName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER FIRST NAME");
    _tfLastName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER LAST NAME");
    _tfPhoneNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER PHONE NUMBER");
    _lbTitleEnquiry.text = LOCALIZED(@"TEXT TITLE HOW CAN WE HELP YOU");
    _lbInfo.text = LOCALIZED(@"TEXT TELL US ABOUT YOURSELF");
    [_btnCancel setTitle:LOCALIZED(@"TEXT CANCEL") forState:UIControlStateNormal];
    [_btnSubmit setTitle:LOCALIZED(@"TEXT SUBMIT") forState:UIControlStateNormal];
    [self.tvMessage setPlaceholder:LOCALIZED(@"TEXT ENQUIRY MESSAGE PLACEHOLDER")];
    
    [self updateBrandUI];
    [self updateModelUI];
}

- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"MENU SEND AN ENQUIRY");
    
    [@[self.lbAdditionalMessage, self.tfFirstName, self.tfLastName, self.phoneView] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addBottomLine];
    }];
    
    [@[self.btnCancel, self.btnSubmit] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addBorder];
    }];

    // NumberPad
    NumberPadToolbar *toolbar = [[NumberPadToolbar alloc] initWithTextView:self.tvMessage];
    toolbar.numberPadDelegate = self;
    self.tvMessage.inputAccessoryView = toolbar;
    
    toolbar = [[NumberPadToolbar alloc] initWithTextField:self.tfPhoneNumber];
    toolbar.numberPadDelegate = self;
    self.tfPhoneNumber.inputAccessoryView = toolbar;
    
    // Text View
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 0; // <--- indention if you need it
    paragraphStyle.firstLineHeadIndent = 0;
    
    paragraphStyle.lineSpacing = 5; // <--- magic line spacing here!
    
    NSDictionary *attrsDictionary = @{ NSParagraphStyleAttributeName: paragraphStyle }; // <-- there are many more attrs, e.g NSFontAttributeName
    
    self.tvMessage.attributedText = [[NSAttributedString alloc] initWithString:@" " attributes:attrsDictionary];
    [self.tvMessage setHorizontalLineColor:[UIColor colorWithRed:119/255.f green:119/255.f blue:119/255.f alpha:0.5]];
    [self.tvMessage setVerticalLineColor:[UIColor clearColor]];
    [self.tvMessage setFont:[UIFont systemFontOfSize:17.0]];
    [self.tvMessage setBackgroundColor:[@"#f6f5f5" representedColor]];
    [self.tvMessage setPlaceholderColor:[UIColor colorWithRed:119/255.f green:119/255.f blue:119/255.f alpha:1.0]];
    [self.tvMessage setMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tvMessage.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:attrsDictionary];
}

- (void)updateEnquiryUI:(MGlobalSetting*)enquiry
{
    self.selectedEnquiry = enquiry;
    if (self.selectedEnquiry) {
        [self.btnEnquiry setTitle:self.selectedEnquiry.name
                      forState:UIControlStateNormal];
        [self.btnEnquiry setTitleColor:[@"#777777" representedColor]
                              forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.33 animations:^{
            if ([self.selectedEnquiry.key isEqualToString:@"Vehicle Enquiry"]) {
                self.btnType.hidden = NO;
                self.btnBrand.hidden = NO;
                self.constraintMessage.constant = 165;
                self.lbAdditionalMessage.text = LOCALIZED(@"TEXT ADDITIONAL MESSAGE STAR");
                [self.tvMessage setPlaceholder:LOCALIZED(@"TEXT ENQUIRY MESSAGE PLACEHOLDER")];
            } else {
                self.btnType.hidden = YES;
                self.btnBrand.hidden = YES;
                self.constraintMessage.constant = 15;
                [self didSelectBrand:nil];
                self.lbAdditionalMessage.text = LOCALIZED(@"TEXT MESSAGE STAR");
                [self.tvMessage setPlaceholder:@""];
            }
        }];
        
    } else {
        [self.btnEnquiry setTitle:LOCALIZED(@"TEXT SELECT ENQUIRY") forState:UIControlStateNormal];
        [self.btnEnquiry setTitleColor:[@"#777777" representedColor]
                           forState:UIControlStateNormal];
    }
}

- (void)clearFormUI
{
    [self applyNewCarInformation];
    [self didSelectBrand:nil];
    self.tfFirstName.text = @"";
    self.tfLastName.text = @"";
    self.tfPhoneNumber.text = @"";
    [self updateUserInfo:self.user];
}

- (void)updateTypeUI:(MGlobalSetting *)type
{
    self.selectedType = type;
    if (self.selectedType) {
        [self.btnType setTitle:self.selectedType.name
                       forState:UIControlStateNormal];
        [self.btnType setTitleColor:[@"#777777" representedColor]
                           forState:UIControlStateNormal];
    } else {
        [self.btnType setTitle:LOCALIZED(@"TEXT SELECT TYPE") forState:UIControlStateNormal];
        [self.btnType setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    }
    
    
}

- (void)updateBrandUI
{
    if (self.selectedBrand) {
        [self.btnBrand setTitle:self.selectedBrand.name
                       forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    } else if (self.selectedPreownedBrand) {
        [self.btnBrand setTitle:self.selectedPreownedBrand.name
                       forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnBrand setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND STAR") forState:UIControlStateNormal];
        [self.btnBrand setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    }
}

- (void)updateModelUI
{
    if (self.selectedModel) {
        [self.btnModel setTitle:self.selectedModel.model
                       forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    } else if (self.selectedPreownedModel) {
        [self.btnModel setTitle:self.selectedPreownedModel.model
                       forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    } else {
        [self.btnModel setTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL") forState:UIControlStateNormal];
        [self.btnModel setTitleColor:[@"#777777" representedColor]
                            forState:UIControlStateNormal];
    }
}



- (void)applyNewCarInformation
{
    MGlobalSetting *defaultEnquiry = [[self.enquiries linq_where:^BOOL(id item) {
        return [[item key] isEqualToString:@"Vehicle Enquiry"];
    }] linq_firstOrNil];
    [self updateEnquiryUI:defaultEnquiry];
    
    MGlobalSetting *defaultVehicleEnquiry = [[self.vehicleEnquiries linq_where:^BOOL(id item) {
        return [[item key] isEqualToString:@"New Vehicle"];
    }] linq_firstOrNil];
    [self updateTypeUI:defaultVehicleEnquiry];
}

- (void)applyPreownedInformation
{
    MGlobalSetting *defaultEnquiry = [[self.enquiries linq_where:^BOOL(id item) {
        return [[item key] isEqualToString:@"Vehicle Enquiry"];
    }] linq_firstOrNil];
    [self updateEnquiryUI:defaultEnquiry];
    
    MGlobalSetting *defaultVehicleEnquiry = [[self.vehicleEnquiries linq_where:^BOOL(id item) {
        return [[item key] isEqualToString:@"Pre-Owned"];
    }] linq_firstOrNil];

    [self updateTypeUI:defaultVehicleEnquiry];
}

#pragma mark - Number Pad Delegate
- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UIView *)control
{
    [self.tvMessage resignFirstResponder];
}

#pragma mark - View Interface
- (void)updateBrands:(NSArray *)brands
{
    self.brands = brands;
    
//    if (self.prefillBrandId > 0) {
//        
//        self.selectedBrand = [[self.brands linq_where:^BOOL(id item) {
//            return [item id] == self.prefillBrandId;
//        }] linq_firstOrNil];
//        
//        [self didSelectBrand:self.selectedBrand];
//        [self applyPreownedInformation];
//        
//        self.prefillBrandId = 0;
//    }
}

- (void)updatePreownedBrands:(NSArray *)brands
{
    self.preownedBrands = brands;
    
    if (self.prefillBrandId > 0) {
        
        self.selectedPreownedBrand = [[self.preownedBrands linq_where:^BOOL(id item) {
            return [item id] == self.prefillBrandId;
        }] linq_firstOrNil];
        
        [self didSelectPreownedBrand:self.selectedPreownedBrand];
        [self applyPreownedInformation];
        
        self.prefillBrandId = 0;
    }
}

- (void)updateModels:(NSArray *)models
{
    self.models = models;
}

- (void)updatePreownedModels:(NSArray *)models
{
    self.preownedModels = models;
    
    if (self.prefillModelId > 0) {
        
        self.selectedPreownedModel = [[self.preownedModels linq_where:^BOOL(id item) {
            return [item id] == self.prefillModelId;
        }] linq_firstOrNil];
        
        [self didSelectPreownedModel:self.selectedPreownedModel];
        [self applyPreownedInformation];
        
        self.prefillModelId = 0;
    }
}

- (void)updateUserInfo:(MUser *)user
{
    self.user = user;
    
    if (self.user) {
        if (![user.firstName isInvalid]) {
            self.tfFirstName.text = user.firstName;
        }
        
        if (![user.lastName isInvalid]) {
            self.tfLastName.text = user.lastName;
        }
        
        if (![user.phoneNumber isInvalid]) {
            self.tfPhoneNumber.text = user.phoneNumber;
        }
    }
}

- (void)updateEnquiries:(NSArray *)enquiries
    andVehicleEnquiries:(NSArray *)vehicleEnquiries
{
    DLog();
    self.enquiries = enquiries;
    self.vehicleEnquiries = vehicleEnquiries;
    [self applyNewCarInformation];
}

- (void)didSelectBrand:(MBrand *)brand
{
    if (_selectedBrand && _selectedBrand.id == brand.id) {
        return;
    }
    
    self.selectedBrand = brand;
    self.selectedPreownedBrand = nil;
    self.selectedModel = nil;
    self.selectedPreownedModel = nil;
    [self updateBrandUI];
    [self updateModelUI];
    [self.eventHandler findModelsByBrand:brand.id];
}

- (void)didSelectPreownedBrand:(MPreownedBrand *)brand
{
    self.selectedBrand = nil;
    self.selectedPreownedBrand = brand;
    self.selectedModel = nil;
    self.selectedPreownedModel = nil;
    [self updateBrandUI];
    [self updateModelUI];
    [self.eventHandler findPreownedModelsByBrand:brand.id];
}

- (void)didSelectModel:(MVehicleModel *)model
{
    self.selectedModel = model;
    self.selectedPreownedModel = nil;
    [self updateModelUI];
}

- (void)didSelectPreownedModel:(MPreownedVehicleModel *)model
{
    self.selectedPreownedModel = model;
    self.selectedModel = nil;
    [self updateModelUI];
}

- (void)didSelectEnquiry:(MGlobalSetting *)enquiry
{
    [self updateEnquiryUI:enquiry];
}

- (void)didSelectType:(MGlobalSetting *)type
{
    if (_selectedType && [_selectedType.key isEqualToString:type.key]) {
        [self updateTypeUI:type];
        return;
    }
    
    [self updateTypeUI:type];
    
    _selectedBrand = nil;
    _selectedPreownedBrand = nil;
    _selectedModel = nil;
    _selectedPreownedModel = nil;
    [self updateBrandUI];
    [self updateModelUI];
    
    if ([[_selectedType.key lowercaseString] isEqualToString:@"pre-owned"]) {
        [self.eventHandler findPreownedBrands];
    } else {
        [self.eventHandler findBrands];
    }
}

- (void)didSetDefaultBrand:(NSInteger)brandId
                  andModel:(NSInteger)modelId
{
    self.prefillBrandId = brandId;
    self.prefillModelId = modelId;
}


#pragma mark - Actions
- (IBAction)selectEnquiryAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showEnquirySelectionAlert:self.enquiries];
}

- (IBAction)selectTypeAction:(id)sender {
    [self hideTextfieldsKeyboard];
    [self.eventHandler showTypeSelectionAlert:self.vehicleEnquiries];
}

- (IBAction)selectBrandAction:(id)sender {
    [self hideTextfieldsKeyboard];
    if ([[_selectedType.key lowercaseString] isEqualToString:@"pre-owned"]) {
        [self.eventHandler showPreownedBrandSelectionAlert:self.preownedBrands];
    } else {
        [self.eventHandler showBrandSelectionAlert:self.brands];
    }
    
}

- (IBAction)selectModelAction:(id)sender {
    [self hideTextfieldsKeyboard];
    if ([[_selectedType.key lowercaseString] isEqualToString:@"pre-owned"]) {
        [self.eventHandler showPreownedModelSelectionAlert:self.preownedModels];
    } else {
        [self.eventHandler showModelSelectionAlert:self.models];
    }
    
}

- (IBAction)cancelAction:(id)sender {
    [self clearFormUI];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitAction:(id)sender {
    MEnquiryRequest *request = [MEnquiryRequest new];
    request.enquiry = self.selectedEnquiry.key;
    request.type = self.selectedType.key;
    request.brand = self.selectedBrand;
    request.preownedBrand = self.selectedPreownedBrand;
    request.model = self.selectedModel;
    request.preownedModel = self.selectedPreownedModel;
    request.firstName = self.tfFirstName.text;
    request.lastName = self.tfLastName.text;
    request.phoneNumber = self.tfPhoneNumber.text;
    request.phoneCode = [self.btnPhoneCode titleForState:UIControlStateNormal];
    request.message = self.tvMessage.text;
    [self.eventHandler sendEnquiryRequest:request];
}

- (void)hideTextfieldsKeyboard
{
    [self.tfFirstName resignFirstResponder];
    [self.tfLastName resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
    [self.tvMessage resignFirstResponder];
}

@end
