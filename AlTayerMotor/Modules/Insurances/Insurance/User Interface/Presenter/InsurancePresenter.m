//
//  InsurancePresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsurancePresenter.h"
#import "InsuranceConfirmationWireframe.h"
#import "IQActionSheetPickerView.h"
#import "MInsuranceRequest.h"

#import "MCity.h"
#import "MDrivingExperience.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+Utils.h"

@interface InsurancePresenter() <IQActionSheetPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (assign, nonatomic) CardSide cardSide;
@end


@implementation InsurancePresenter

#pragma mark - Module Interface
- (void)findUserInfo
{
    [self.interactor findUserInfo];
}

- (void)findCities
{
    [self.interactor findCities];
}

- (void)findDrivingExperiences
{
    [self.interactor findDrivingExperiences];
}

- (void)showBirthdaySelectionAlert:(NSDate *)birthday
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:LOCALIZED(@"TEXT SELECT DATE OF BIRTH") delegate:self];
    [picker setTag:6];
    [picker setBackgroundColor:[UIColor whiteColor]];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    NSDate *startRange = [self subtractYears:100 fromDate:[NSDate date]];
    NSDate *endRange = [self subtractYears:18 fromDate:[NSDate date]];
    [picker setMinimumDate:startRange];
    [picker setMaximumDate:endRange];
    [picker setDate:(birthday ?: endRange)];
    [picker show];
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

- (void)showDrivingExperienceSelectionAlert:(NSArray *)drivingExperiences
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT SELECT PREFERRED CALL TIME")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [drivingExperiences enumerateObjectsUsingBlock:^(MDrivingExperience *drivingExperience, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:drivingExperience.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.userInterface didSelectDrivingExperience:drivingExperience];
        }]];
    }];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)takePhoto:(CardSide)cardSide
{
    self.cardSide = cardSide;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:LOCALIZED(@"TEXT HOW WOULD YOU LIKE TO SELECT PICTURE")
                                                                         message:@""
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT ADD FROM GALLERY") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT A PHOTO") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerWithSource:UIImagePickerControllerSourceTypeCamera];
    }]];
    
    [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
}

- (void)deleteCardSide:(CardSide)cardSide
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:LOCALIZED(@"TEXT DO YOU WANT TO DELETE THIS IMAGE")
                                message:@""
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
                          [self.userInterface didDeleteCardSide:cardSide];
                      }]];
    
    [self.userInterface presentViewController:alert animated:YES completion:nil];
}

- (void)clearForm
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:LOCALIZED(@"TEXT DO YOU WANT TO CLEAR THIS FORM")
                                message:@""
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
                          [self.userInterface didClearForm];
                      }]];
    
    [self.userInterface presentViewController:alert animated:YES completion:nil];
}

- (void)submitRequest:(MInsuranceRequest *)request
{
    if (!request.firstName || request.firstName.length == 0) {
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
    } else if (!request.city) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE A CITY")];
        return;
    } else if (!request.drivingExperience || request.drivingExperience.length == 0) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PLEASE CHOOSE PREFERRED CALL TIME")];
        return;
    } else if (![[NSString stringWithFormat:@"%@%@",request.phoneCode,request.phoneNumber] validatePhoneNumber]) {
        [self.userInterface showMessage:LOCALIZED(@"TEXT TITLE PHONE NUMBER IS INVALID")];
        return;
    }
    
    [self.userInterface showLoadingIndicator];
    [self.interactor postInsuranceRequest:request];
}

#pragma mark - Interactor
- (void)foundUserInfo:(MUser *)user
{
    [self.userInterface updateUserInfo:user];
}

- (void)foundCities:(NSArray *)cities
{
    [self.userInterface updateCities:cities];
}

- (void)foundDrivingExperiences:(NSArray *)drivingExperiences
{
    [self.userInterface updateDrivingExperiences:drivingExperiences];
}

- (void)postInsuranceRequestFailed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface hideLoadingEndicator];
        [self.userInterface showMessage:LOCALIZED(@"TEXT SEND REQUEST NOT SUCCESSFULLY TRY AGAIN")];
    });
}

- (void)postInsuranceRequestSuccessWithRequest:(MInsuranceRequest *)request
{
    // Navigation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       [self.userInterface hideLoadingEndicator];
                       [self.confirmationWireframe presentInsuranceConfirmationInterfaceFromPresenter:self];
                   });
}

#pragma mark - THDatePicker delegate
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    [self.userInterface didSelectBirthday:date];
}

#pragma mark - Others
- (void)showImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self checkCamera];
    } else {
        [self checkMediaAsset];
    }
}

- (void)checkCamera {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self.userInterface presentViewController:imagePicker animated:YES completion:nil];
    }
    
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Camera Access Required"
                                                                             message:@"Please allow us to access your camera roll in your device Settings."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        
        [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
    }
}

- (void)checkMediaAsset {
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status == ALAuthorizationStatusAuthorized || status == ALAuthorizationStatusNotDetermined) {
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop) {
                [self.userInterface presentViewController:imagePicker animated:YES completion:nil];
                return;
            }
            *stop = TRUE;
        } failureBlock:^(NSError *error) {
            [imagePicker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Photos Access Required"
                                                                             message:@"Please allow us to access your Photos in your device Settings."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:LOCALIZED(@"TEXT OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        
        [self.userInterface presentViewController:actionSheet animated:YES completion:nil];
    }
}

- (UIImage *)compressImage:(UIImage *)scrImage {
    UIImage *resizeImg = [InsurancePresenter imageWithImage:scrImage scaledToWidth:512];
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 30*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(resizeImg, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(resizeImg, compression);
    }
    
    DLog(@"%@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
    return [UIImage imageWithData:imageData];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image  scaledToWidth:(CGFloat)newWidth {
    CGFloat newHeight = newWidth * image.size.height / image.size.width;
    return [InsurancePresenter imageWithImage:image scaledToSize:CGSizeMake(newWidth, newHeight)];
}

#pragma mark - Image Picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * resizedImage = [self compressImage:img];
    [self.userInterface didTakenPhoto:resizedImage
                              forSide:self.cardSide];
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
