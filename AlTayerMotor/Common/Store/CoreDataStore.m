//
//  CoreDataStore.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "CoreDataStore.h"
#import "NSArray+LinqExtensions.h"

#import "RegisteredVehicle.h"
#import "Brand.h"
#import "VehicleModel.h"
#import "City.h"
#import "RegisteredVehicle.h"
#import "User.h"
#import "Location.h"
#import "DrivingExperience.h"
#import "PreownedBrand.h"
#import "PreownedVehicleModel.h"
#import "GlobalSetting.h"
#import "DateManager.h"

#import "MBrand.h"
#import "MVehicleModel.h"
#import "MRegisteredVehicle.h"
#import "MUser.h"
#import "MCity.h"
#import "MLocation.h"
#import "MDrivingExperience.h"
#import "MPreownedBrand.h"
#import "MPreownedVehicleModel.h"
#import "MGlobalSetting.h"

@interface CoreDataStore ()

@end

@implementation CoreDataStore

+ (id)sharedStore {
    static CoreDataStore *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - User
- (void)saveUserInformation:(MUser *)user
{
    User *currentUser = [User MR_findFirst];
    if (!currentUser) {
        currentUser = [User MR_createEntity];
    }
    
    currentUser.first_name = user.firstName;
    currentUser.last_name = user.lastName;
    currentUser.phone_code = user.phoneCode;
    currentUser.phone_number = user.phoneNumber;
    currentUser.city = user.city.key;
    
    [self save];
}

- (MUser *)getUserInfo
{
    User *user = [User MR_findFirst];
    if (!user) {
        return nil;
    }
    MCity *city = [self getCityByKey:user.city];
    MUser *mUser = [[MUser alloc] initWithUser:user andCity:city];
    return mUser;
}

#pragma mark - Cities
- (NSArray *)fetchAllCities
{
    return [City MR_findAllSortedBy:@"name" ascending:YES];
}

- (void)deleteAllCities
{
    [City MR_truncateAll];
}

- (void)insertCities:(NSArray *)cities
{
    if (cities) {
        [cities enumerateObjectsUsingBlock:^(MCity *city, NSUInteger idx, BOOL * _Nonnull stop) {
            City *newInstance = [City MR_createEntity];
            newInstance.key = city.key;
            newInstance.name = city.name;
            newInstance.nameAR = city.nameAR;
            [self save];
        }];
    }
}

- (MCity *)getCityByKey:(NSString *)key
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(key == %@)", key];
    City *city = [City MR_findFirstWithPredicate:brandPredicate];
    if (!city) {
        return nil;
    }
    MCity *mCity = [[MCity alloc] initWithDatabaseObject:city];
    return mCity;
}


#pragma mark - Global Settings
- (NSArray*)fetchGlobalSettingsByKey:(NSString*)key
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(parent_key == %@)", key];
    NSArray *settings = [GlobalSetting MR_findAllSortedBy:@"index" ascending:YES withPredicate:predicate];
    return [settings linq_select:^id(id item) {
        return [[MGlobalSetting alloc] initWithDatabaseObject:item];
    }];
}

- (void)deleteAllGlobalSettings
{
    [GlobalSetting MR_truncateAll];
}

- (void)insertGlobalSettings:(NSArray *)settings
{
    if (settings) {
        [settings enumerateObjectsUsingBlock:^(MGlobalSetting *setting, NSUInteger idx, BOOL * _Nonnull stop) {
            GlobalSetting *newInstance = [GlobalSetting MR_createEntity];
            newInstance.key = setting.key;
            newInstance.name = setting.name;
            newInstance.nameAR = setting.nameAR;
            newInstance.parent_key = setting.parentKey;
            newInstance.index = @(setting.index);
            [self save];
        }];
    }
}

#pragma mark - Location
- (NSArray *)fetchAllLocations
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lang == %ld)", [ATMGlobal isEnglish] ? AppLanguageEnglish : AppLanguageArabian];
//    return [Location MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
    return [Location MR_findAllWithPredicate:predicate];
}

- (NSArray *)fetchServiceLocations
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lang == %ld) AND (isServiceCenter == %@)", [ATMGlobal isEnglish] ? AppLanguageEnglish : AppLanguageArabian, @(YES)];
//    return [Location MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
    return [Location MR_findAllWithPredicate:predicate];
}

- (NSArray *)fetchAllShowroomLocations
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lang == %ld) AND (isShowRoom == %@)", [ATMGlobal isEnglish] ? AppLanguageEnglish : AppLanguageArabian, @(YES)];
//    return [Location MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
    return [Location MR_findAllWithPredicate:predicate];
}

- (void)deleteAllLocations
{
    [Location MR_truncateAll];
}

- (void)insertLocations:(NSArray *)locations
{
    if (locations) {
        [locations enumerateObjectsUsingBlock:^(MLocation *location, NSUInteger idx, BOOL * _Nonnull stop) {
            Location *newInstance = [Location MR_createEntity];
            newInstance.id = @(location.Id);
            newInstance.name = location.name;
            DLog(@"%@", location.name);
            newInstance.brandids = [NSKeyedArchiver archivedDataWithRootObject:location.brandids];
            newInstance.latitude = @(location.latitude);
            newInstance.longitude = @(location.longitude);
            newInstance.city = location.city;
            newInstance.isBodyShop = @(location.isBodyShop);
            newInstance.isServiceCenter = @(location.isServiceCenter);
            newInstance.isShowRoom = @(location.isShowRoom);
            newInstance.openHourTitle1 = location.openHourTitle1;
            newInstance.openHourTitle2 = location.openHourTitle2;
            newInstance.openHourTitle3 = location.openHourTitle3;
            newInstance.openHourValue1 = location.openHourValue1;
            newInstance.openHourValue2 = location.openHourValue2;
            newInstance.openHourValue3 = location.openHourValue3;
            newInstance.phoneNumber = location.phoneNumber;
            newInstance.lang = @(location.lang);
            
            [self save];
        }];
    }
}

#pragma mark - Driving Experience
- (NSArray *)fetchAllDrivingExperiences
{
//    return [DrivingExperience MR_findAllSortedBy:@"name" ascending:YES];
    return [DrivingExperience MR_findAll];
}

- (void)deleteAllDrivingExperiences
{
    [DrivingExperience MR_truncateAll];
}

- (void)insertDrivingExperiences:(NSArray *)drivingExperiences
{
    if (drivingExperiences) {
        [drivingExperiences enumerateObjectsUsingBlock:^(MDrivingExperience *drivingExp, NSUInteger idx, BOOL * _Nonnull stop) {
            DrivingExperience *newInstance = [DrivingExperience MR_createEntity];
            newInstance.key = drivingExp.key;
            newInstance.name = drivingExp.name;
            newInstance.nameAr = drivingExp.nameAR;
            [self save];
        }];
    }
}

- (MDrivingExperience *)getDrivingExperienceByKey:(NSString *)key
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(key == %@)", key];
    DrivingExperience *drivingExp = [DrivingExperience MR_findFirstWithPredicate:brandPredicate];
    MDrivingExperience *mDrivingExp = [[MDrivingExperience alloc] initWithDatabaseObject:drivingExp];
    return mDrivingExp;
}

#pragma mark - Brands

- (NSArray *)fetchAllBrands
{
    return [Brand MR_findAll];
}

- (void)syncBrand:(MBrand *)brand
{
    // sync brand
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", brand.id];
    NSArray *brands = [Brand MR_findAllWithPredicate:brandPredicate];
    if (brands && brands.count > 0) {
        Brand *udpatedBrand = brands[0];
        udpatedBrand.name = brand.name;
        udpatedBrand.name_ar = brand.nameAR;
        udpatedBrand.logo = brand.logo;
        udpatedBrand.url = brand.url;
        udpatedBrand.roadside = brand.roadsideAssistance;
    } else {
        Brand *newBrand = [Brand MR_createEntity];
        newBrand.id = @(brand.id);
        newBrand.name = brand.name;
        newBrand.name_ar = brand.nameAR;
        newBrand.logo = brand.logo;
        newBrand.url = brand.url;
        newBrand.roadside = brand.roadsideAssistance;
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    // sync vehicle models
    if (brand.vehicleModels) {
        [brand.vehicleModels enumerateObjectsUsingBlock:^(MVehicleModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [self syncVehicleModel:model];
        }];
    }
}

- (MBrand *)getBrandById:(NSInteger)brandId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", brandId];
    Brand *brand = [Brand MR_findFirstWithPredicate:brandPredicate];
    MBrand *mBrand = [[MBrand alloc] initWithId:[brand.id integerValue]
                                       withName:brand.name
                                     withNameAR:brand.name_ar
                                       withLogo:brand.logo
                                        withUrl:brand.url
                                   withRoadside:brand.roadside];
    return mBrand;
}

- (void)deleteAllBrands
{
    [Brand MR_truncateAll];
}

#pragma mark - Preowned-Brands
- (NSArray *)fetchAllPreownedBrands
{
    NSArray *brands = [PreownedBrand MR_findAll];
    return [brands linq_select:^id(PreownedBrand *brand) {
        return [[MPreownedBrand alloc] initWithId:[brand.id integerValue]
                                 withName:brand.name
                               withNameAR:brand.name_ar
                                 withLogo:brand.logo
                                  withUrl:brand.url
                             withRoadside:brand.roadside
                            withNoPreownedMessage:brand.no_preowned_message
                          withNoPreownedMessageAR:brand.no_preowned_message_ar
                                   withOldestYear:[brand.oldest_year integerValue]];
    }];
}

- (void)syncPreownedBrand:(MPreownedBrand *)brand
{
    // sync brand
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", brand.id];
    NSArray *brands = [PreownedBrand MR_findAllWithPredicate:brandPredicate];
    if (brands && brands.count > 0) {
        PreownedBrand *udpatedBrand = brands[0];
        udpatedBrand.name = brand.name;
        udpatedBrand.name_ar = brand.nameAR;
        udpatedBrand.logo = brand.logo;
        udpatedBrand.url = brand.url;
        udpatedBrand.roadside = brand.roadsideAssistance;
        udpatedBrand.no_preowned_message = brand.noPreownedMessage;
        udpatedBrand.no_preowned_message_ar = brand.noPreownedMessageAR;
        udpatedBrand.oldest_year = @(brand.oldestYear);
    } else {
        PreownedBrand *newBrand = [PreownedBrand MR_createEntity];
        newBrand.id = @(brand.id);
        newBrand.name = brand.name;
        newBrand.name_ar = brand.nameAR;
        newBrand.logo = brand.logo;
        newBrand.url = brand.url;
        newBrand.roadside = brand.roadsideAssistance;
        newBrand.no_preowned_message = brand.noPreownedMessage;
        newBrand.no_preowned_message_ar = brand.noPreownedMessageAR;
        newBrand.oldest_year = @(brand.oldestYear);
    }
    [self save];
    
    // sync vehicle models
    if (brand.vehicleModels) {
        [brand.vehicleModels enumerateObjectsUsingBlock:^(MPreownedVehicleModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [self syncPreownedVehicleModel:model];
        }];
    }
}

- (MPreownedBrand *)getPreownedBrandById:(NSInteger)brandId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", brandId];
    PreownedBrand *brand = [PreownedBrand MR_findFirstWithPredicate:brandPredicate];
    MPreownedBrand *mBrand = [[MPreownedBrand alloc] initWithId:[brand.id integerValue]
                                       withName:brand.name
                                     withNameAR:brand.name_ar
                                       withLogo:brand.logo
                                        withUrl:brand.url
                                   withRoadside:brand.roadside
                                          withNoPreownedMessage:brand.no_preowned_message
                                        withNoPreownedMessageAR:brand.no_preowned_message_ar
                                                 withOldestYear:[brand.oldest_year integerValue]];
    return mBrand;
}

- (void)deleteAllPreownedBrands
{
    [PreownedBrand MR_truncateAll];
}

#pragma mark - Vehicle Models

- (NSArray *)fetchAllVehicleModels
{
    return [[VehicleModel MR_findAllSortedBy:@"model" ascending:YES] linq_distinct:^id(VehicleModel *vehicleModel) {
        return vehicleModel.model;
    }];
}

- (MVehicleModel *)getModelById:(NSInteger)modelId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", modelId];
    VehicleModel *model = [VehicleModel MR_findFirstWithPredicate:brandPredicate];
    MVehicleModel *mModel = [[MVehicleModel alloc] initWithVehicleModel:model];
    return mModel;
}

- (NSArray *)fetchVehicleModelsByBrand:(NSInteger)brandId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(brand_id == %d)", brandId];
    return [VehicleModel MR_findAllWithPredicate:brandPredicate];
}

- (void)syncVehicleModel:(MVehicleModel *)model
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", model.id];
    NSArray *models = [VehicleModel MR_findAllWithPredicate:brandPredicate];
    if (models && models.count > 0) {
        VehicleModel *updatedModel = models[0];
        updatedModel.type = model.type ?: @"other";
        updatedModel.brand_id = @(model.brandId);
        updatedModel.model = model.model;
        updatedModel.model_ar = model.modelAR;
        updatedModel.type = model.type;
        updatedModel.image = model.image;
    } else {
        VehicleModel *vehicleModel = [VehicleModel MR_createEntity];
        vehicleModel.id = @(model.id);
        vehicleModel.brand_id = @(model.brandId);
        vehicleModel.model = model.model;
        vehicleModel.model_ar = model.modelAR;
        vehicleModel.type = model.type;
        vehicleModel.image = model.image;
    }
    [self save];
}

#pragma mark - Preowned Vehicle Models
- (NSArray *)fetchAllPreownedVehicleModels
{
    NSArray *models = [PreownedVehicleModel MR_findAllSortedBy:@"model" ascending:YES];
    return [models linq_select:^id(PreownedVehicleModel *model) {
        return [[MPreownedVehicleModel alloc] initWithVehicleModel:model];
    }];
}

- (NSArray *)fetchPreownedVehicleModelsByBrand:(NSInteger)brandId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(brand_id == %d)", brandId];
    NSArray *models = [PreownedVehicleModel MR_findAllWithPredicate:brandPredicate];
    return [models linq_select:^id(PreownedVehicleModel *model) {
        return [[MPreownedVehicleModel alloc] initWithVehicleModel:model];
    }];
}

- (MPreownedVehicleModel *)getPreownedModelById:(NSInteger)modelId
{
    NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"(id == %d)", modelId];
    PreownedVehicleModel *model = [PreownedVehicleModel MR_findFirstWithPredicate:brandPredicate];
    MPreownedVehicleModel *mModel = [[MPreownedVehicleModel alloc] initWithVehicleModel:model];
    return mModel;
}

- (void)syncPreownedVehicleModel:(MPreownedVehicleModel *)model
{
    NSPredicate *modelPredicate = [NSPredicate predicateWithFormat:@"(id == %d) AND (type == %@)", model.id, model.type];
    NSArray *models = [PreownedVehicleModel MR_findAllWithPredicate:modelPredicate];
    if (models && models.count > 0) {
        PreownedVehicleModel *updatedModel = models[0];
        updatedModel.type = model.type ?: @"other";
        updatedModel.brand_id = @(model.brandId);
        updatedModel.model = model.model;
        updatedModel.type = model.type;
        updatedModel.image = [model.image isEqual:[NSNull null]] ? @"" : model.image;
    } else {
        PreownedVehicleModel *vehicleModel = [PreownedVehicleModel MR_createEntity];
        vehicleModel.id = @(model.id);
        vehicleModel.brand_id = @(model.brandId);
        vehicleModel.model = model.model;
        vehicleModel.type = model.type;
        vehicleModel.image = [model.image isEqual:[NSNull null]] ? @"" : model.image;
    }
    [self save];
}

#pragma mark - Registered Vechiles
- (NSArray *)fetchAllRegisteredVehicles
{
    NSArray *vehicles = [[RegisteredVehicle MR_findAllSortedBy:@"registration_expiry" ascending:YES] linq_select:^id(RegisteredVehicle *vehicle) {
        MRegisteredVehicle *registeredVehicle = [MRegisteredVehicle new];
        registeredVehicle.brandId = [vehicle.brand_id integerValue];
        registeredVehicle.modelId = [vehicle.model integerValue];
        registeredVehicle.year = [vehicle.model_year integerValue];
        registeredVehicle.registrationNumber = vehicle.registration_number;
        registeredVehicle.registrationExpiry = vehicle.registration_expiry;
        registeredVehicle.brand = [self getBrandById:[vehicle.brand_id integerValue]];
        registeredVehicle.model = [self getModelById:[vehicle.model integerValue]];
        registeredVehicle.otherBrand = vehicle.other_brand;
        registeredVehicle.otherModel = vehicle.other_model;
        return registeredVehicle;
    }];
    
    return vehicles;
}

- (RegisteredVehicle *)newRegisteredVehicle
{

    return [RegisteredVehicle MR_createEntity];
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    NSPredicate *vehiclePredicate = [NSPredicate predicateWithFormat:@"(registration_number ==[c] %@)", registrationNumber];
    return [RegisteredVehicle MR_findFirstWithPredicate:vehiclePredicate] != nil;
}

- (BOOL)hasRegisteredVehicleInDate:(NSString *)expiryDate
{
    NSPredicate *vehiclePredicate = [NSPredicate predicateWithFormat:@"(registration_expiry ==[c] %@)", expiryDate];
    return [RegisteredVehicle MR_findFirstWithPredicate:vehiclePredicate] != nil;
}

// get all registered vehicles will be expired in 30 days
- (NSArray *)expiredRegisteredVehicles
{
    NSMutableArray *vehicles = [@[] mutableCopy];
    
    NSInteger todayNumber = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:[NSDate date]] integerValue];
    NSInteger lastShown = [ATMGlobal reminderLastShownDate];
    NSInteger startNumber = MAX(0, lastShown - todayNumber + 1);
    
    for (NSInteger i = startNumber; i <= kReminderDate; i++) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = i;
        NSDate *oneMonthFromNow = [[NSCalendar currentCalendar]
                                   dateByAddingComponents:components
                                   toDate:[NSDate date]
                                   options:0];
        
        NSString *dateStr = [[[DateManager sharedManager] presentedDateFormatter]
                             stringFromDate:oneMonthFromNow];
        
        NSPredicate *vehiclePredicate = [NSPredicate predicateWithFormat:@"(registration_expiry ==[c] %@)", dateStr];
        [vehicles addObjectsFromArray:[RegisteredVehicle MR_findAllWithPredicate:vehiclePredicate]];
    }
    
    return [vehicles sortedArrayUsingComparator:^NSComparisonResult(RegisteredVehicle *obj1, RegisteredVehicle *obj2) {
        NSDate *date1 = [[[DateManager sharedManager] presentedDateFormatter] dateFromString:obj1.registration_expiry];
        NSDate *date2 = [[[DateManager sharedManager] presentedDateFormatter] dateFromString:obj2.registration_expiry];
        NSInteger dateNumber1 = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:date1] integerValue];
        NSInteger dateNumber2 = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:date2] integerValue];
        return dateNumber1 > dateNumber2;
    }];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    NSPredicate *vehiclePredicate = [NSPredicate predicateWithFormat:@"(registration_number ==[c] %@)", registrationNumber];
    
    RegisteredVehicle *oldVehicle = [RegisteredVehicle MR_findFirstWithPredicate:vehiclePredicate];
    
    if (oldVehicle) {
        // Save to database
        oldVehicle.brand_id = @(vehicle.brandId);
        oldVehicle.other_brand = vehicle.otherBrand;
        oldVehicle.model = @(vehicle.model.id);
        oldVehicle.other_model = vehicle.otherModel;
        oldVehicle.model_year = @(vehicle.year);
        oldVehicle.other_brand = vehicle.otherBrand;
        oldVehicle.other_model = vehicle.otherModel;
        oldVehicle.registration_number = vehicle.registrationNumber;
        oldVehicle.registration_expiry = vehicle.registrationExpiry;
        
        [self save];
        
        // Refresh local notifications
        [APP_DELEGATE setupRemotePushNotification];
    }
}

- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number {
    NSPredicate *vehiclePredicate = [NSPredicate predicateWithFormat:@"(registration_number ==[c] %@)", number];
    RegisteredVehicle *oldVehicle = [RegisteredVehicle MR_findFirstWithPredicate:vehiclePredicate];
    if (oldVehicle) {
        [oldVehicle MR_deleteEntity];
        [self save];
    }
}

- (void)deleteAllRegisteredVehicles {
    [RegisteredVehicle MR_truncateAll];
}

- (void)save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
