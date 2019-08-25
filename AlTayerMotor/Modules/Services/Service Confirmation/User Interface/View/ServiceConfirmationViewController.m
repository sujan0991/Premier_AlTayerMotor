//
//  ServiceConfirmationViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServiceConfirmationViewController.h"
#import "UIView+Border.h"
#import "NSString+Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MServiceRequest.h"
#import "MVehicleModel.h"
#import "MBrand.h"
#import "MLocation.h"

@interface ServiceConfirmationViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbModel;
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imvVehicle;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleAR;
@property (weak, nonatomic) IBOutlet UIImageView *imvThanksEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvThanksAR;
@property (weak, nonatomic) IBOutlet UIImageView *imvDescriptionEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvDescriptionAR;
@end

@implementation ServiceConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // ScrollView
    CGRect sizeRect = [UIScreen mainScreen].bounds;
    [self.scrollView setContentSize:CGSizeMake(sizeRect.size.width, 526)];
    DLog(@"%@", NSStringFromCGSize(self.scrollView.contentSize));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupViews
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE SERVICE");
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    [self.btnBack addBorder];
    
    if (_serviceRequest) {
        [_imvVehicle sd_setImageWithURL:[NSURL URLWithString:[_serviceRequest.model.image toImageLink]]
                       placeholderImage:[UIImage imageNamed:@"placeholder_car"]];

        NSString *carInformation = @"";
        
        if (_serviceRequest.brand && _serviceRequest.brand.name && (![_serviceRequest.brand.name.lowercaseString isEqualToString:@"other"] && ![_serviceRequest.brand.name isEqualToString:@"آخر"])) {
            carInformation = _serviceRequest.brand.name;
        } else {
            carInformation = _serviceRequest.otherBrand;
        }
        if (_serviceRequest.model && _serviceRequest.model.model && (![_serviceRequest.model.model.lowercaseString isEqualToString:@"other"] && ![_serviceRequest.model.model isEqualToString:@"آخر"])) {
            carInformation = [NSString stringWithFormat:@"%@ %@", carInformation, _serviceRequest.model.model];
        } else {
            carInformation = [NSString stringWithFormat:@"%@ %@", carInformation, _serviceRequest.otherModel];
        }
        
        _lbModel.text = [NSString stringWithFormat:@"%@ %ld", carInformation, (long)_serviceRequest.year];
        
        _lbLocation.text = _serviceRequest.location.name;
    } else {
        _lbModel.text = @"";
        _lbLocation.text = @"";
    }
    
    // Languages
    _imvTitleEN.hidden = _imvThanksEN.hidden = _imvDescriptionEN.hidden = ![ATMGlobal isEnglish];
    _imvTitleAR.hidden = _imvThanksAR.hidden = _imvDescriptionAR.hidden = [ATMGlobal isEnglish];
    
    _imvThanksAR.hidden = _imvThanksEN.hidden = YES;
    
    [_btnBack setImage:IMAGE_MULTIPLE_LANGUAGE(@"btn_back_to_preowned")
                  forState:UIControlStateNormal];
}

- (IBAction)backAction:(id)sender {
    [self.eventHandler backToPreowned];
}

@end
