//
//  VehicleDetailsViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleDetailsViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "NSString+Utils.h"
#import "UILabel+Utils.h"
#import "UIView+Border.h"
#import "NSString+Color.h"

#import "MVehicle.h"
#import "MPreownedBrand.h"

#define kHeightImagesScrollView 211

@interface VehicleDetailsViewController() <UIScrollViewDelegate>
{
    NSInteger currentImagePosition;
}

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) MVehicle *vehicle;
@property (weak, nonatomic) IBOutlet UILabel *lbBrand;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnPrevious;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;


@property (weak, nonatomic) IBOutlet UIView *modelYearView;
@property (weak, nonatomic) IBOutlet UIView *trimView;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIView *mileageView;
@property (weak, nonatomic) IBOutlet UIView *fuelTypeView;

@property (weak, nonatomic) IBOutlet UILabel *lbModelYear;
@property (weak, nonatomic) IBOutlet UILabel *lbTrim;
@property (weak, nonatomic) IBOutlet UILabel *lbColor;
@property (weak, nonatomic) IBOutlet UILabel *lbMileage;
@property (weak, nonatomic) IBOutlet UILabel *lbPetrol;

@property (weak, nonatomic) IBOutlet UILabel *lbTitleModelYear;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleTrim;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleColor;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleMileage;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleFuel;

@property (weak, nonatomic) IBOutlet UILabel *lbDesc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *lbDisclaimerMsg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disclaimerMsgHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *btnEnquiry;
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
@end


@implementation VehicleDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberFormatter = [[NSNumberFormatter alloc]init];
    [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.numberFormatter setGroupingSeparator:@","];
    [self.numberFormatter setGroupingSize:3];
    
    [self setupViews];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenVehicleDetails];
    
    [self layoutByLanguage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutByLanguage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
}

- (void)layoutByLanguage
{
    [_contentScrollView.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1)];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    for (UIView *subview in [self.contentScrollView allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]] ||
            [subview isKindOfClass:[UIScrollView class]] ||
            subview == _btnNext || subview == _btnPrevious) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE VEHICLE DETAILS");
    self.lbTitleModelYear.text = LOCALIZED(@"TEXT MODEL YEAR");
    self.lbTitleTrim.text = LOCALIZED(@"TEXT TRIM");
    self.lbTitleColor.text = LOCALIZED(@"TEXT COLOR");
    self.lbTitleMileage.text = LOCALIZED(@"TEXT MILEAGE");
    self.lbTitleFuel.text = LOCALIZED(@"TEXT FUEL TYPE");
    
    [self.btnContact setImage:[UIImage imageNamed:[NSString stringWithFormat:@"contact_atm%@", [ATMGlobal isEnglish] ? @"" : @"_ar"]]
                     forState:UIControlStateNormal];
    
    self.lbBrand.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbModel.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbPrice.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbDesc.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    [self updateNavigationButtons];
    [self updateUI];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    // remove old subviews
    [_imagesScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // add new view
    if (_vehicle && _vehicle.images && _vehicle.images.count > 0) {
        [_vehicle.images enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth*idx, 0, screenWidth, kHeightImagesScrollView)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[imageUrl toImageLink]]
                         placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [@"f6f5f5" representedColor];
            [self.imagesScrollView addSubview:imageView];
        }];
        [self.imagesScrollView setContentSize:CGSizeMake(screenWidth*_vehicle.images.count, kHeightImagesScrollView)];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, kHeightImagesScrollView)];
        imageView.image = [UIImage imageNamed:@"placeholder_car"];
        [self.imagesScrollView addSubview:imageView];
        [self.imagesScrollView setContentSize:CGSizeMake(screenWidth, kHeightImagesScrollView)];
    }
    
    // show/hide navigation button
    [self currentImagePosition:0];
    
    // description and content height
    // calculate view height
    CGFloat descriptionHeight = [self.lbDesc getLabelHeight] + 100;
    self.descHeightConstraint.constant = descriptionHeight;
    
    CGFloat disclaimerMsgHeight = [self.lbDisclaimerMsg getLabelHeight] + 10;
    self.disclaimerMsgHeightConstraint.constant = disclaimerMsgHeight;
    
    self.contentHeightConstraint.constant = 620 + descriptionHeight + disclaimerMsgHeight;
    [self.contentScrollView setContentSize:CGSizeMake(screenWidth, self.contentHeightConstraint.constant)];
    
    
}

#pragma mark - Update UI

- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE VEHICLE DETAILS");
    
    self.navigationItem.hidesBackButton = YES;
    [self addLeftMenuWithAction:@selector(backAction:) inController:self];
    
    [@[_modelYearView, _trimView, _colorView, _mileageView, _fuelTypeView] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.layer.cornerRadius = 4;
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    }];
    
    [self.btnContact addBorder];
    [self.btnEnquiry addBorder];
    
    [self.btnEnquiry setImage:IMAGE_MULTIPLE_LANGUAGE(@"send_an_enquiry")
                     forState:UIControlStateNormal];
    [self.btnContact setImage:IMAGE_MULTIPLE_LANGUAGE(@"contact_dealer")
                     forState:UIControlStateNormal];
}

- (void)updateUI
{
    if (self.vehicle) {
        self.lbBrand.text = [(self.vehicle.brand && [self.vehicle.brand isValidString:self.vehicle.brand.name]) ?  self.vehicle.brand.name : @"" uppercaseString];
        self.lbModel.text = [[self.vehicle isValidString:self.vehicle.model] ? self.vehicle.model : @"" uppercaseString];
        self.lbModelYear.text = self.vehicle.year > 0 ? [NSString stringWithFormat:@"%ld", (long)self.vehicle.year] : @"";
        self.lbTrim.text = [[self.vehicle isValidString:self.vehicle.trim] ? self.vehicle.trim : @"" uppercaseString];
        self.lbColor.text = [self.vehicle isValidString:self.vehicle.color] ? [self.vehicle.color uppercaseString] : @"";
        self.lbMileage.text = [NSString stringWithFormat:@"%@KM", [self.numberFormatter stringFromNumber:@(self.vehicle.mileage)]];
        self.lbPetrol.text = [[self.vehicle isValidString:self.vehicle.fuelType] ? self.vehicle.fuelType : @"" uppercaseString];
        if ([self.vehicle isValidString:self.vehicle.desc]) {
            NSString *html = [self.vehicle.desc stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                       self.lbDesc.font.fontName,
                                                                       self.lbDesc.font.pointSize]];
            NSError *err = nil;
            NSAttributedString * attrStr =
            [[NSAttributedString alloc]
             initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]
             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
             documentAttributes: nil
             error: &err];
            self.lbDesc.attributedText = attrStr;
        } else {
            self.lbDesc.text =@"";
        }
        
        self.lbDisclaimerMsg.text = [ATMGlobal preownedDisclaimerMessage];
        
        if ([ATMGlobal isEnglish]) {
            self.lbPrice.text = [NSString stringWithFormat:@"%@ %@ %@", LOCALIZED(@"TEXT SELLING AT"), [self.vehicle getCurrency], [self.numberFormatter stringFromNumber:@(self.vehicle.price)]];
        } else {
            self.lbPrice.text = [NSString stringWithFormat:@"%@: %@ %@",LOCALIZED(@"TEXT SELLING AT"), [self.numberFormatter stringFromNumber:@(self.vehicle.price)], [self.vehicle getCurrency]];
        }
    }
}

- (void)currentImagePosition:(NSInteger)position
{
    [self currentImagePosition:position
                 withAnimation:NO];
}

- (void)currentImagePosition:(NSInteger)position withAnimation:(BOOL)animation
{
    currentImagePosition = position;
    [self updateNavigationButtons];
    [self scrollToCurrentImageWithAnimation:animation];
}

- (void)updateNavigationButtons
{
    if (self.vehicle.images.count == 0) {
        self.btnPrevious.hidden = YES;
        self.btnNext.hidden = YES;
    } else {
        self.btnPrevious.hidden = [ATMGlobal isEnglish] ? (currentImagePosition == 0) : (currentImagePosition == self.vehicle.images.count - 1);
        self.btnNext.hidden = [ATMGlobal isEnglish] ? (currentImagePosition == self.vehicle.images.count - 1) : (currentImagePosition == 0);
    }
}

- (void)scrollToCurrentImageWithAnimation:(BOOL)animation
{
    CGRect frame = _imagesScrollView.frame;
    frame.origin.x = frame.size.width * currentImagePosition;
    frame.origin.y = 0;
    [_imagesScrollView scrollRectToVisible:frame animated:animation];
}

#pragma mark - View Interface
- (void)setVehicle:(MVehicle *)vehicle
{
    _vehicle = vehicle;
    [self updateUI];
}

#pragma mark - Actions
- (IBAction)goPreviousAction:(id)sender {
    [self currentImagePosition:([ATMGlobal isEnglish] ? --currentImagePosition : ++currentImagePosition)
                 withAnimation:YES];
}

- (IBAction)goNextAction:(id)sender {
    [self currentImagePosition:([ATMGlobal isEnglish] ? ++currentImagePosition : --currentImagePosition)
                 withAnimation:YES];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _imagesScrollView) {
        CGFloat pageWidth = _imagesScrollView.frame.size.width;
        float fractionalPage = _imagesScrollView.contentOffset.x / pageWidth;
        currentImagePosition = lround(fractionalPage);
        [self updateNavigationButtons];
    }
}

- (IBAction)sendEnquiryAction:(id)sender {
    [self.eventHandler presentSendEnquiryInterfaceWittData:self.vehicle.brand
                                                  andModel:self.vehicle.modelId];
 
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventSubmit];
}

- (IBAction)doContactAction:(id)sender {
    [ATMGlobal callDealer];
}

@end
