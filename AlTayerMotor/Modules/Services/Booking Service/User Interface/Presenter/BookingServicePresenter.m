//
//  BookingServicePresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServicePresenter.h"
#import "BookingServiceViewInterface.h"

#import "MResponse.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "Brand.h"
#import "MServiceRequest.h"
#import "MRegisteredVehicle.h"
#import "MCity.h"
#import "MLocation.h"

#import "NSString+Utils.h"

@interface BookingServicePresenter()
@property (strong, nonatomic) MServiceRequest *currentRequest;;
@end

@implementation BookingServicePresenter

#pragma mark - Module Interface
- (void)findBrands
{
    [self.bookingServiceInteractor findBrands];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    [self.bookingServiceInteractor findVehicleModelsByBrand:brandId];
}

- (void)findUserInfo
{
    [self.bookingServiceInteractor findUserInfo];
}

- (void)findCities
{
    [self.bookingServiceInteractor findCities];
}

- (void)findLocations
{
    [self.bookingServiceInteractor findLocations];
}

- (void)showCitySelectionAlert:(NSArray *)cities
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [cities enumerateObjectsUsingBlock:^(MCity *city, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:city.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectCity:city];
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
    MBrand *brand = [[MBrand alloc] initWithId:0 withName:@"Other" withNameAR:@"آخر" withLogo:nil withUrl:nil withRoadside:nil];
    [actionSheet addAction:[UIAlertAction actionWithTitle:brand.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.userInterface didSelectBrand:brand];
    }]];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showVehicleModelSelectionAlert:(NSArray *)models
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
    
    MVehicleModel *model = [[MVehicleModel alloc] initWithId:0 withBrandId:0 withModel:@"Other" withModelAR:@"آخر" withModelYear:nil withType:nil withImage:nil];
    [actionSheet addAction:[UIAlertAction actionWithTitle:model.model style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.userInterface didSelectModel:model];
    }]];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showYearSelectionAlert:(NSArray *)models
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL YEAR")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [models enumerateObjectsUsingBlock:^(NSNumber *year, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@", year] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectYear:[year integerValue]];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showLocationSelectionAlert:(NSArray *)locations
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRANCH")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [locations enumerateObjectsUsingBlock:^(MLocation *location, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:location.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectLocation:location];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)submitRequest:(MServiceRequest *)request
{
    self.currentRequest = nil;
    MRegisteredVehicle *currentVehicle = [_userInterface getRegisteredVehicle];
    
    if ((!request.brand && [request.otherBrand isInvalid]) || (!request.model && [request.otherModel isInvalid])) {
        if (!request.brand && [request.otherBrand isInvalid]) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")]; return;
        } else if (!request.model && [request.otherModel isInvalid]) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A MODEL")]; return;
        }
    } else if (request.year == -1) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A YEAR")]; return;
    } else if ([request.registrationNumber isInvalid]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION NUMBER")]; return;
    }else if (request.mileage == -1) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT MILEAGE")]; return;
    } else if ([request.firstName isInvalid]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT FIRST NAME")]; return;
    } else if ([request.lastName isInvalid]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT LAST NAME")]; return;
    } else if ([request.phoneNumber isInvalid]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT PHONE NUMBER")]; return;
//    } else if (!request.city) {
//        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A CITY")]; return;
//    } else if (!request.location) {
//        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A LOCATION")]; return;
    } else if ([request.email isInvalid]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT EMAIL")]; return;
    } else if (![request.email validateEmail]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE EMAIL IS INVALID")]; return;
    } else if (![[NSString stringWithFormat:@"%@%@",request.phoneCode, request.phoneNumber] validatePhoneNumber]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PHONE NUMBER IS INVALID")];
        return;
    }
    
    self.currentRequest = request;
    
    MRegisteredVehicle *newVehicle = [MRegisteredVehicle new];
    newVehicle.brandId = self.currentRequest.brand.id;
    newVehicle.otherBrand = self.currentRequest.otherBrand;
    newVehicle.otherModel = self.currentRequest.otherModel;
    newVehicle.model = self.currentRequest.model;
    newVehicle.year = self.currentRequest.year;
    newVehicle.registrationExpiry = @"";
    newVehicle.registrationNumber = self.currentRequest.registrationNumber;
    
    if (currentVehicle && [currentVehicle hasChanged:newVehicle] && [request.otherBrand isInvalid]) {
        if (![currentVehicle.registrationNumber isEqualToString:newVehicle.registrationNumber] && [self.bookingServiceInteractor hasAlreadyVehicle:request.registrationNumber]) {
            [self.userInterface showMessage:@"This registration number belongs to another vehicle"];
        } else {
            [self.bookingServiceWireframe presentServicePopupInterfaceWithPresenter:self];
        }
    } else if ([self.bookingServiceInteractor hasAlreadyVehicle:request.registrationNumber]) {
        // Send request
        [self sendServiceRequest];
    } else {
        [self.bookingServiceWireframe presentServicePopupInterfaceWithPresenter:self];
    }
    
}

#pragma mark - Interactor
- (void)foundBrands:(NSArray *)brands
{
    [self.userInterface updateBrands:brands];
}

- (void)foundVehicleModels:(NSArray *)vehicleModels
{
    NSArray *models = [vehicleModels linq_select:^id(VehicleModel *model) {
        return [[MVehicleModel alloc] initWithVehicleModel:model];
    }];
    [self.userInterface updateVehicleModels:models];
}

- (void)foundUserInfo:(MUser *)user
{
    [self.userInterface updateUserInfo:user];
}

- (void)foundCities:(NSArray *)cities
{
    [self.userInterface updateCities:cities];
}

- (void)foundLocations:(NSArray *)locations
{
    [self.userInterface updateLocations:locations];
}

- (void)postBookingServiceFailed:(MResponse *)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface hideLoadingEndicator];
        if (response && response.message && response.message.length > 0) {
            [self.userInterface showMessage:response.message];
        } else {
            [self.userInterface showMessage:LOCALIZED(@"TEXT SEND REQUEST NOT SUCCESSFULLY")];
        }
        
    });
}

- (void)postBookingServiceSuccessWithRequest:(MServiceRequest *)request
{
    // Navigation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       [self.userInterface hideLoadingEndicator];
                       [self.bookingServiceWireframe pushConfirmationInterfaceToController:self.userInterface.navigationController
                                                                               withRequest:request];
                   });
    
    // Log Event
    NSDictionary *data = @{
                           @"formName" : @"Book Service",
                           @"car" : @{ @"brand" : [request.otherBrand isInvalid] ? request.brand.name : request.otherBrand,
                                       @"model" : [request.otherBrand isInvalid] ? request.model.model : @"",
                                       @"model-year": @(request.year)
                                       }
                           };
    [[GTMHelper sharedInstance] logEvent:kEventFormSubmitted inScreenName:nil withAdditionalData:data];
}

#pragma mark - Popup Delegate
- (void)servicePopupDidCancelAction
{
    // Send request
    [self sendServiceRequest];
}

- (void)servicePopupDidSubmitAction
{
    // Save registered vehicle
    if (self.currentRequest) {
        MRegisteredVehicle *currentVehicle = [_userInterface getRegisteredVehicle];
        
        MRegisteredVehicle *vehicle = [MRegisteredVehicle new];
        vehicle.brandId = self.currentRequest.brand.id;
        vehicle.otherBrand = self.currentRequest.otherBrand;
        vehicle.otherModel = self.currentRequest.otherModel;
        vehicle.model = self.currentRequest.model;
        vehicle.year = self.currentRequest.year;
        vehicle.registrationExpiry = @"";
        vehicle.registrationNumber = self.currentRequest.registrationNumber;
        
        if (currentVehicle) {
            [self.bookingServiceInteractor updateRegisteredVehicle:vehicle
                                                      forOldNumber:currentVehicle.registrationNumber];
        } else {
            [self.bookingServiceInteractor addRegisteredCar:vehicle];
        }
    }
    
    // Send request
    [self sendServiceRequest];
}

#pragma mark - Network
- (void)sendServiceRequest {
    //TODO: send booking service request to server
    [self.userInterface showLoadingIndicator];
    [self.bookingServiceInteractor postBookingService:self.currentRequest];
}

@end
