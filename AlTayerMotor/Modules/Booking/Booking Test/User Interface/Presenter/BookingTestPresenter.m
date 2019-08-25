//
//  BookingTestPresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestPresenter.h"
#import "BookingTestViewInterface.h"
#import "BookingTestWireframe.h"
#import "BookingConfirmationWireframe.h"
#import "IQActionSheetPickerView.h"

#import "NSString+Utils.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MCity.h"
#import "MLocation.h"
#import "MBookingTestRequest.h"
#import "Brand.h"


@interface BookingTestPresenter() <IQActionSheetPickerViewDelegate>
@end

@implementation BookingTestPresenter

#pragma mark - Module interface
- (void)findBrands
{
    [self.interactor findBrands];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    [self.interactor findVehicleModelsByBrand:brandId];
}

- (void)findUserInfo
{
    [self.interactor findUserInfo];
}

- (void)findCities
{
    [self.interactor findCities];
}

- (void)findLocations
{
    [self.interactor findLocations];
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

- (void)showBirthdaySelectionAlert:(NSDate *)birthday
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:LOCALIZED(@"TEXT SELECT DATE OF BIRTH")
                                                                            delegate:self];
    [picker setTag:6];
    [picker setBackgroundColor:[UIColor whiteColor]];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    NSDate *endRange = [self subtractYears:18 fromDate:[NSDate date]];
    [picker setMaximumDate:endRange];
    [picker setDate:(birthday ?: endRange)];
    [picker show];
}

- (void)sendBookingTestRequest:(MBookingTestRequest *)request
{
    if (!request.brand) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A BRAND")];
        return;
    } else if (!request.model) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A MODEL")];
        return;
    } else if (!request.firstName || request.firstName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT FIRST NAME")];
        return;
    } else if (!request.lastName || request.lastName.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT LAST NAME")];
        return;
    } else if (!request.birthday) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE YOUR BIRTHDAY")];
        return;
    } else if (!request.phoneNumber || request.phoneNumber.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT PHONE NUMBER")];
        return;
    } else if (!request.email || request.email.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE INPUT EMAIL")];
        return;
    } else if (![request.email validateEmail]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE EMAIL IS INVALID")];
        return;
    } else if (!request.city) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A CITY")];
        return;
    } else if (![request.phoneNumber validatePhoneNumber]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PHONE NUMBER IS INVALID")];
        return;
    }
    
    [self.userInterface showLoadingIndicator];
    [self.interactor postBookingService:request];
}

#pragma mark - Interactor Network
- (void)postBookingTestFailed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface hideLoadingEndicator];
        [self.userInterface showMessage:LOCALIZED(@"TEXT SEND REQUEST NOT SUCCESSFULLY")];
    });
}

- (void)postBookingTestSuccessWithRequest:(MBookingTestRequest *)request
{
    // Navigation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       [self.userInterface didClearForm];
                       [self.userInterface hideLoadingEndicator];
                       [self.bookingConfirmationWireframe presentBookingConfirmationInterfaceFromPresenter:self
                                                                                               withRequest:request];
                   });
    
    // Log Event
    NSDictionary *data = @{
                           @"formName" : @"Test Drive",
                           @"car" : @{ @"brand" : request.brand.name,
                                       @"model" : request.model.model,
                                       @"model-year": @(request.year)
                                   }
                           };
    
    [[GTMHelper sharedInstance] logEvent:kEventFormSubmitted inScreenName:nil withAdditionalData:data];
}



#pragma mark - DatePicker delegate
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    [self.userInterface didSelectBirthday:date];
}

#pragma mark - Others
- (NSDate *) subtractYears:(NSInteger)years fromDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    /*
     Create a date components to represent the number of years to add to the current date.
     In this case, we add -1 to subtract one year.
     */
    
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.year = -years;
    
    NSDate *temp = [calendar dateByAddingComponents:component toDate:date options:0];
    component = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:temp];
    [component setDay:31];
    [component setMonth:12];
    
    return [calendar dateFromComponents:component];
}
@end
