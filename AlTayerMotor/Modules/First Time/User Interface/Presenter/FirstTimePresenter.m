//
//  FirstTimePresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FirstTimePresenter.h"
#import "FirstTimeViewInterface.h"
#import "TabBarWireframe.h"

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
#import "LocalDataManager.h"
#import "CoreDataStore.h"

@interface FirstTimePresenter() <IQActionSheetPickerViewDelegate>
@end

@implementation FirstTimePresenter

#pragma mark - FirstTime View Interface
- (void)updateView
{
    [self.firstTimeInteractor findRegisteredCars];
}

- (void)showTabBarInterface
{
    [[LocalDataManager sharedManager] setShownFirstTime];
    
    [self.firstTimeWireframe presentTabBarWireframe];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventSubmit];
}

- (void)findCities
{
    [self.firstTimeInteractor findCities];
}

- (void)findBrands
{
    [self.firstTimeInteractor findBrands];
}

- (void)findRegisteredVehicles
{
    [self.firstTimeInteractor findRegisteredCars];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    [self.firstTimeInteractor findVehicleModelsByBrand:brandId];
}

- (void)showCitySelectionAlert:(NSArray *)cities
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT CITY")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [cities enumerateObjectsUsingBlock:^(MCity *city, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:city.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectCity:city];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showSkipWarningAlertWithUser:(MUser *)user
{
    BOOL hasFirstName = user.firstName && user.firstName.length > 0;
    BOOL hasLastName = user.lastName && user.lastName.length > 0;
    BOOL hasPhoneNumber = user.phoneNumber && user.phoneNumber.length > 0;
    BOOL hasCity = user.city != nil;
    
    if (hasFirstName || hasLastName || hasPhoneNumber || hasCity) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:LOCALIZED(@"TEXT WARNING")
                                    message:LOCALIZED(@"TEXT ALL DATA YOU INPUT WILL BE CLEAR")
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction
                          actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE")
                          style:UIAlertActionStyleCancel
                          handler:^(UIAlertAction *action)
                          {
                              NSLog(@"Cancel action");
                          }]];
        
        [alert addAction:[UIAlertAction
                          actionWithTitle:LOCALIZED(@"TEXT OK")
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction *action)
                          {
                              [[CoreDataStore sharedStore] deleteAllRegisteredVehicles];
                              [self showTabBarInterface];
                          }]];
        
        [self.userInterface presentViewController:alert animated:YES completion:nil];
    } else {
        [[CoreDataStore sharedStore] deleteAllRegisteredVehicles];
        [self showTabBarInterface];
    }
    
    
}

- (void)showBrandSelectionAlert:(NSArray *)brands
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND STAR")
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
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL STAR")
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
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT MODEL YEAR STAR")
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
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:LOCALIZED(@"TEXT REGISTRATION EXPIRY STAR") delegate:self];
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
    
    if (![self.firstTimeInteractor hasAlreadyVehicle:vehicle.registrationNumber]) {
        [self.firstTimeInteractor addRegisteredCar:vehicle];
    } else {
        [self.userInterface showMessage:@"This Registration Number is belong to another vehicle!"];
    }
}

- (void)saveRegisteredVehicle:(MRegisteredVehicle *)vehicle withCurrentVehicle:(MRegisteredVehicle *)oldVehicle
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
    
    if (oldVehicle) {
        [self.firstTimeInteractor updateRegisteredVehicle:vehicle forOldNumber:oldVehicle.registrationNumber];
    } else if (![self.firstTimeInteractor hasAlreadyVehicle:vehicle.registrationNumber]) {
        [self.firstTimeInteractor addRegisteredCar:vehicle];
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
    
    vehicle.year = vehicle.year == 0 ? 2015 : vehicle.year;
    if ((vehicle.brandId > 0 || vehicle.otherBrand) &&
        (vehicle.model || vehicle.otherModel) &&
        vehicle.year > 0 &&
        vehicle.registrationNumber && vehicle.registrationNumber.length > 0 &&
        vehicle.registrationExpiry && vehicle.registrationExpiry.length > 0) {
        
        if (oldVehicle) {
            [self.firstTimeInteractor updateRegisteredVehicle:vehicle
                                        forOldNumber:oldVehicle.registrationNumber];
        } else {
            [self.firstTimeInteractor addRegisteredCar:vehicle];
        }
    }
    
    [self.firstTimeInteractor addUserInformation:user];
    
    // show tabbar interface
    [self showTabBarInterface];
}


- (void)storeUserInfo:(MUser *)user andVehicle:(MRegisteredVehicle *)vehicle
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
    
    vehicle.year = vehicle.year == 0 ? 2015 : vehicle.year;
    if (vehicle.brandId > 0 &&
        vehicle.model &&
        vehicle.year > 0 &&
        vehicle.registrationNumber && vehicle.registrationNumber.length > 0 &&
        vehicle.registrationExpiry && vehicle.registrationExpiry.length > 0) {
        
        [self.firstTimeInteractor addRegisteredCar:vehicle];
    }
    
    [self.firstTimeInteractor addUserInformation:user];
    
    // show tabbar interface
    [self showTabBarInterface];
}

- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle
{
    [self.firstTimeWireframe presentEditInterfaceWithData:registeredVehicle
                                    inNavigation:self.userInterface.navigationController];
}

- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    [self.firstTimeWireframe presentDeleteVehicleInterfaceFromNavigation:self.userInterface.navigationController
                                                  withFirstTimePresenter:self
                                                             withVehicle:vehicle];
}

#pragma mark - FirstTime Interactor Output
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


#pragma mark - THDatePicker delegate
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
    [self.firstTimeInteractor deleteRegisteredVehicleByRegistrationNumber:vehicle.registrationNumber];
    [self.firstTimeInteractor findRegisteredCars];
}

@end
