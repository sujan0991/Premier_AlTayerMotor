//
//  BookingConfirmationViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingConfirmationViewController.h"
#import "UIView+Border.h"
#import "NSString+Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MBookingTestRequest.h"
#import "MVehicleModel.h"
#import "MBrand.h"
#import "MLocation.h"
#import "ATMFullRowButton.h"

@interface BookingConfirmationViewController()

@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnPreOwned;
@property (weak, nonatomic) IBOutlet UILabel *lbBrand;
@property (weak, nonatomic) IBOutlet UILabel *lbBranch;
@property (weak, nonatomic) IBOutlet UIImageView *imvVehicle;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleAR;
@property (weak, nonatomic) IBOutlet UIImageView *imvThanksAR;
@property (weak, nonatomic) IBOutlet UIImageView *imvThanksEN;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@end

@implementation BookingConfirmationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup Views
    [self setupViews];
}

- (void)setupViews
{
    // Hide back buttonk
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE BOOK A TEST DRIVE");
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    [self.btnPreOwned addBorder];
    
    if (_request) {
        [_imvVehicle sd_setImageWithURL:[NSURL URLWithString:[_request.model.image toImageLink]]
                       placeholderImage:[UIImage imageNamed:@"placeholder_car"]];
        NSString *carInformation = @"";
        
        if (_request.brand && _request.brand.name && (![_request.brand.name.lowercaseString isEqualToString:@"other"] && ![_request.brand.name isEqualToString:@"آخر"])) {
            carInformation = _request.brand.name;
        } else {
            carInformation = _request.otherBrand;
        }
        if (_request.model && _request.model.model && (![_request.model.model.lowercaseString isEqualToString:@"other"] && ![_request.model.model isEqualToString:@"آخر"])) {
            carInformation = [NSString stringWithFormat:@"%@ %@", carInformation, _request.model.model];
        } else {
            carInformation = [NSString stringWithFormat:@"%@ %@", carInformation, _request.otherModel];
        }
        
        _lbBrand.text = carInformation;
        _lbBranch.text = _request.location.name;
    } else {
        _lbBrand.text = @"";
        _lbBranch.text = @"";
    }
    
    _imvTitleEN.hidden = _imvThanksEN.hidden = ![ATMGlobal isEnglish];
    _imvTitleAR.hidden = _imvThanksAR.hidden = [ATMGlobal isEnglish];
    
    // hide thanks title
    _imvThanksAR.hidden = _imvThanksEN.hidden = YES;
    
    [_btnPreOwned setImage:IMAGE_MULTIPLE_LANGUAGE(@"btn_back_to_preowned")
                  forState:UIControlStateNormal];
    _lbDescription.text = LOCALIZED(@"TEXT DESCRIPTION BOOKING TEST COMPLETION");
    
    
    AFFINE_TRANSFORM(_viewContent);
    for (UIView *subview in [self.viewContent allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
//    TEXT_ALIGN(_lbDescription);
    TEXT_ALIGN(_lbBrand);
    TEXT_ALIGN(_lbBranch);
    
}

- (IBAction)backAction:(id)sender {
    [self.eventHandler backToPreowned];
}

@end
