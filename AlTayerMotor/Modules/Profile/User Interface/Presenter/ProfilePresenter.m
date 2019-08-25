//
//  ProfilePresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ProfilePresenter.h"
#import "ProfileViewInterface.h"
#import "ProfileWireframe.h"
#import "IQActionSheetPickerView.h"
#import "DateManager.h"
#import "NSString+Utils.h"

#import "NSArray+LinqExtensions.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MRegisteredVehicle.h"
#import "MUser.h"
#import "VehicleModel.h"
#import "Brand.h"
#import "MCity.h"

@interface ProfilePresenter() <IQActionSheetPickerViewDelegate>
@end

@implementation ProfilePresenter

#pragma mark - FirstTime View Interface
- (void)updateView
{
    [self.interactor findRegisteredCars];
}

- (void)findUserInfo
{
    [self.interactor findUserInfo];
}

- (void)findCities
{
    [self.interactor findCities];
}

- (void)findBrands
{
    [self.interactor findBrands];
}

- (void)findRegisteredVehicles
{
    [self.interactor findRegisteredCars];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    [self.interactor findVehicleModelsByBrand:brandId];
}

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
{
    [self.wireframe presentEditInterfaceWithData:registeredVehicle
                                    inNavigation:self.userInterface.navigationController];
}

- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    [self.wireframe presentDeleteVehicleInterfaceFromNavigation:self.userInterface.navigationController
                                           withProfilePresenter:self
                                                    withVehicle:vehicle];
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

- (void)showDateSelectionAlert:(NSString *)currentDate
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    [picker setTag:6];
    [picker setBackgroundColor:[UIColor whiteColor]];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker setMinimumDate:[NSDate date]];
    if (currentDate) {
        NSDate *date = [[[DateManager sharedManager] presentedDateFormatter]
                        dateFromString:currentDate];
        [picker setDate:date];
    }
    [picker show];
}

- (void)addRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    if (vehicle.brandId == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
        return;
    } else if (!vehicle.model) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A MODEL")];
        return;
    } else if (vehicle.year == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A YEAR")];
        return;
    } else if (!vehicle.registrationNumber || vehicle.registrationNumber.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION NUMBER")];
        return;
    } else if (!vehicle.registrationExpiry || vehicle.registrationExpiry.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION EXPIRY")];
        return;
    }
    
    if (![self.interactor hasAlreadyVehicle:vehicle.registrationNumber]) {
        [self.interactor addRegisteredCar:vehicle];
    } else {
        [self.userInterface showMessage:@"This Registration Number is belong to another vehicle!"];
    }
}

- (void)saveRegisteredVehicle:(MRegisteredVehicle *)vehicle withCurrentVehicle:(MRegisteredVehicle *)oldVehicle
{
    if (vehicle.brandId == 0 && !vehicle.otherBrand) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
        return;
    } else if (!vehicle.model && !vehicle.otherModel) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A MODEL")];
        return;
    } else if (vehicle.year == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A YEAR")];
        return;
    } else if (!vehicle.registrationNumber || vehicle.registrationNumber.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION NUMBER")];
        return;
    } else if (!vehicle.registrationExpiry || vehicle.registrationExpiry.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION EXPIRY")];
        return;
    }
    
    if (oldVehicle) {
        [self.interactor updateRegisteredVehicle:vehicle forOldNumber:oldVehicle.registrationNumber];
    } else if (![self.interactor hasAlreadyVehicle:vehicle.registrationNumber]) {
        [self.interactor addRegisteredCar:vehicle];
    } else {
        [self.userInterface showMessage:@"This Registration Number is belong to another vehicle!"];
    }
}

- (void)storeUserInfo:(MUser *)user
           andVehicle:(MRegisteredVehicle *)vehicle
       withOldVehicle:(MRegisteredVehicle *)oldVehicle
{
    if (!user.firstName || user.firstName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT FIRST NAME")];
        return;
    } else if (!user.lastName || user.lastName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT LAST NAME")];
        return;
    } else if (!user.phoneNumber || user.phoneNumber.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT PHONE NUMBER")];
        return;
    } else if (!user.city) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A CITY")];
        return;
    } else if (![[NSString stringWithFormat:@"%@%@",user.phoneCode,user.phoneNumber] validatePhoneNumber]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PHONE NUMBER IS INVALID")];
        return;
    }
    
    
    if (vehicle.brandId > 0 ||
        vehicle.model ||
        vehicle.year > 0 ||
        (vehicle.registrationNumber && vehicle.registrationNumber.length > 0) ||
        (vehicle.registrationExpiry && vehicle.registrationExpiry.length > 0)) {
        
        if (vehicle.brandId == 0 && !vehicle.otherBrand) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
            return;
        } else if (!vehicle.model && !vehicle.otherModel) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A MODEL")];
            return;
        } else if (vehicle.year == 0) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A YEAR")];
            return;
        } else if (!vehicle.registrationNumber || vehicle.registrationNumber.length == 0) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION NUMBER")];
            return;
        } else if (!vehicle.registrationExpiry || vehicle.registrationExpiry.length == 0) {
            [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT REGISTRATION EXPIRY")];
            return;
        }
        
        if ([self.interactor hasAlreadyVehicle:vehicle.registrationNumber]) {
            [self.userInterface showMessage:@"This Registration Number is belong to another vehicle!"];
            return;
        }
    }
    
//    vehicle.year = vehicle.year == 0 ? 2015 : vehicle.year;
    if ((vehicle.brandId > 0 || (vehicle.otherBrand && vehicle.otherBrand.length > 0)) &&
        (vehicle.model  || (vehicle.otherModel && vehicle.otherModel.length > 0)) &&
        vehicle.year > 0 &&
        vehicle.registrationNumber && vehicle.registrationNumber.length > 0 &&
        vehicle.registrationExpiry && vehicle.registrationExpiry.length > 0) {
        
        if (oldVehicle) {
            [self.interactor updateRegisteredVehicle:vehicle
                                        forOldNumber:oldVehicle.registrationNumber];
        } else {
            [self.interactor addRegisteredCar:vehicle];
        }
    }
    
    [self.interactor addUserInformation:user];
    [self.userInterface showMessage:LOCALIZED(@"TEXT SAVED SUCCESSFULLY")];
}

#pragma mark - FirstTime Interactor Output
- (void)foundUserInfo:(MUser *)user
{
    [self.userInterface updateUserInfo:user];
}

- (void)foundRegisteredCars:(NSArray *)cars
{
    [self.userInterface showRegisteredCars:cars];
}

- (void)foundCities:(NSArray *)cities
{
    [self.userInterface updateCities:cities];
}

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

- (void)foundVehicleModels:(NSArray *)vehicleModels
{
    NSArray *models = [vehicleModels linq_select:^id(VehicleModel *model) {
        return [[MVehicleModel alloc] initWithVehicleModel:model];
    }];
    [self.userInterface updateVehicleModels:models];
}


#pragma mark - DatePicker delegate
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    NSString *selectedDateStr = [[[DateManager sharedManager] presentedDateFormatter]
                                 stringFromDate:date];
    [self.userInterface didSelectDate:selectedDateStr];
}

#pragma mark - Delete Vehicles
- (void)deleteVehicleDidCancelAction
{
    DLog();
}

- (void)deleteVehicleDidSubmitActionWithVehicle:(MRegisteredVehicle *)vehicle
{
    DLog();
    [self.interactor deleteRegisteredVehicleByRegistrationNumber:vehicle.registrationNumber];
    [self.interactor findRegisteredCars];
}

@end
