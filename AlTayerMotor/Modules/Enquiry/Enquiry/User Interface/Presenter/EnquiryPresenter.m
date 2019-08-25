//
//  EnquiryPresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryPresenter.h"
#import "EnquiryViewInterface.h"
#import "EnquiryWireframe.h"
#import "MBrand.h"
#import "Brand.h"
#import "MPreownedBrand.h"
#import "PreownedBrand.h"
#import "MVehicleModel.h"
#import "VehicleModel.h"
#import "MPreownedVehicleModel.h"
#import "PreownedVehicleModel.h"
#import "MEnquiryRequest.h"
#import "MGlobalSetting.h"
#import "NSString+Utils.h"

@implementation EnquiryPresenter

#pragma mark - Module interface
- (void)findBrands
{
    [self.interactor findBrands];
}

- (void)findPreownedBrands
{
    [self.interactor findPreownedBrands];
}

- (void)findModelsByBrand:(NSInteger)brandId
{
    [self.interactor findModelsByBrand:brandId];
}

- (void)findPreownedModelsByBrand:(NSInteger)brandId
{
    [self.interactor findPreownedModelsByBrand:brandId];
}


- (void)findUserInfo
{
    [self.interactor findUserInfo];
}

- (void)findEnquiries
{
    [self.interactor findEnquiries];
}

- (void)showEnquirySelectionAlert:(NSArray *)enquiries
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT SELECT ENQUIRY")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [enquiries enumerateObjectsUsingBlock:^(MGlobalSetting *enquiry, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:enquiry.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectEnquiry:enquiry];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showTypeSelectionAlert:(NSArray *)vehicleEnquiries
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT SELECT TYPE")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [vehicleEnquiries enumerateObjectsUsingBlock:^(MGlobalSetting *enquiry, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:enquiry.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectType:enquiry];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showBrandSelectionAlert:(NSArray *)brands
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [brands enumerateObjectsUsingBlock:^(MBrand *brand, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:brand.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectBrand:brand];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showPreownedBrandSelectionAlert:(NSArray *)brands
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [brands enumerateObjectsUsingBlock:^(MPreownedBrand *brand, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:brand.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectPreownedBrand:brand];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showModelSelectionAlert:(NSArray *)models
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [models enumerateObjectsUsingBlock:^(MVehicleModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:model.model style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectModel:model];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showPreownedModelSelectionAlert:(NSArray *)models
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [models enumerateObjectsUsingBlock:^(MPreownedVehicleModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:model.model style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectPreownedModel:model];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)sendEnquiryRequest:(MEnquiryRequest *)request
{
    if (!request.enquiry || request.enquiry.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE AN ENQUIRY")];
        return;
    }
    
    if ([request.enquiry isEqualToString:@"Vehicle Enquiry"]) {
        if (!request.type || request.type.length == 0) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A TYPE")];
            return;
        } else if ([[request.type lowercaseString] isEqualToString:@"pre-owned"] && !request.preownedBrand) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
            return;
        } else if (![[request.type lowercaseString] isEqualToString:@"pre-owned"] && !request.brand) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
            return;
        }
    }
    
    if (!request.message || request.message.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT MESSAGE")];
        return;
    }
    
    if (!request.firstName || request.firstName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT FIRST NAME")];
        return;
    }
    if (!request.lastName || request.lastName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT LAST NAME")];
        return;
    }
    
    if (!request.phoneNumber || request.phoneNumber.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT PHONE NUMBER")];
        return;
    }
    
    if (![[NSString stringWithFormat:@"%@%@",request.phoneCode,request.phoneNumber] validatePhoneNumber]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PHONE NUMBER IS INVALID")];
        return;
    }
    
    [self.userInterface showLoadingIndicator];
    [self.interactor postEnquiry:request];
    
    
}

#pragma mark - Interactor
- (void)foundBrands:(NSArray *)brands
{
    // Convert from Brand to MBrand
    NSArray *mBrands = [brands linq_select:^id(Brand *brand) {
        return [[MBrand alloc] initWithId:[brand.id integerValue]
                                 withName:brand.name
                               withNameAR:brand.name_ar
                                 withLogo:brand.logo
                                  withUrl:brand.url
                             withRoadside:brand.roadside];
    }];
    [self.userInterface updateBrands:mBrands];
}

- (void)foundPreownedBrands:(NSArray *)brands
{
    [self.userInterface updatePreownedBrands:brands];
}

- (void)foundModels:(NSArray *)models
{
    // Convert from VehicleModel to MVehicleModel
    NSArray *mModels = [models linq_select:^id(VehicleModel *model) {
        return [[MVehicleModel alloc] initWithVehicleModel:model];
    }];
    
    [self.userInterface updateModels:mModels];
}


- (void)foundPreownedModels:(NSArray *)models
{
    // Convert from VehicleModel to MVehicleModel
//    NSArray *mModels = [models linq_select:^id(PreownedVehicleModel *model) {
//        return [[MPreownedVehicleModel alloc] initWithVehicleModel:model];
//    }];
    
    [self.userInterface updatePreownedModels:models];
}

- (void)foundUserInfo:(MUser *)user
{
    [self.userInterface updateUserInfo:user];
}

- (void)foundEnquiries:(NSArray *)enquiries andVehicleEnquiries:(NSArray *)vehicleEnquiries
{
    [self.userInterface updateEnquiries:enquiries
                    andVehicleEnquiries:vehicleEnquiries];
}

#pragma mark - network
- (void)postEnquiryFailed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface hideLoadingEndicator];
        [self.userInterface showMessage:LOCALIZED(@"TEXT SEND REQUEST NOT SUCCESSFULLY")];
    });
}

- (void)postEnquirySuccessWithRequest:(MEnquiryRequest *)request
{
    // Navigation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       [self.userInterface hideLoadingEndicator];
                       [self.wireframe presentConfirmationIntefaceInNavigationController:self.userInterface.navigationController];
                   });
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventSubmit
                            inScreenName:kScreenSendEnquiry];
}

@end
