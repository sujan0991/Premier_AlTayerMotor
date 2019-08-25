//
//  EditRegisteredVehiclePresenter.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "EditRegisteredVehiclePresenter.h"
#import "EditRegisteredVehicleViewInterface.h"
#import "EditRegisteredVehicleWireframe.h"
#import "IQActionSheetPickerView.h"
#import "DateManager.h"

#import "NSArray+LinqExtensions.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MRegisteredVehicle.h"
#import "MUser.h"
#import "VehicleModel.h"
#import "Brand.h"
#import "MCity.h"

@interface EditRegisteredVehiclePresenter() <IQActionSheetPickerViewDelegate>
@end

@implementation EditRegisteredVehiclePresenter

- (void)findBrands
{
    [self.interactor findBrands];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    [self.interactor findVehicleModelsByBrand:brandId];
}


- (void)showBrandSelectionAlert:(NSArray *)brands
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT PLACEHOLDER SELECT BRAND")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
    } else if (![vehicle.registrationNumber isEqualToString:oldVehicle.registrationNumber] &&
               [self.interactor hasAlreadyVehicle:vehicle.registrationNumber]) {
        [self.userInterface showMessage:@"This Registration Number is belong to another vehicle!"];
        return;
    }
    
    [self.interactor updateRegisteredVehicle:vehicle forOldNumber:oldVehicle.registrationNumber];
}


#pragma mark - FirstTime Interactor Output
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

- (void)completeUpdatingRegisteredVehicle
{
    [self.userInterface.navigationController popViewControllerAnimated:YES];
}


#pragma mark - DatePicker delegate
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    NSString *selectedDateStr = [[[DateManager sharedManager] presentedDateFormatter]
                                 stringFromDate:date];
    [self.userInterface didSelectDate:selectedDateStr];
}

@end
