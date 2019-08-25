//
//  DataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DataManager.h"
#import "Brand.h"
#import "VehicleModel.h"
#import "City.h"

#define IMPORTED_DEFAULT_DATA @"IMPORTED_DEFAULT_DATA"

@implementation DataManager

+ (id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)importDefaultData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault boolForKey:IMPORTED_DEFAULT_DATA]) {
//        [self importCities];
        [self importBrands];
        [self importVehicleModels];
        // store key
        [userDefault setBool:YES forKey:IMPORTED_DEFAULT_DATA];
        [userDefault synchronize];
    }
}

- (void)importCities
{
    NSArray *array = @[@"Dubai", @"Abu Dhabi", @"Sharjah", @"Al Ain", @"Ajman", @"Ras al-Khaimah", @"Fujairah", @"Umm al-Quwain", @"Dibba Al-Hisn", @"Khor Fakkan"];
    [array enumerateObjectsUsingBlock:^(NSString *cityName, NSUInteger idx, BOOL * _Nonnull stop) {
        City *city = [City MR_createEntity];
        city.id = @(idx + 1);
        city.name = cityName;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }];
}

- (void)importVehicleModels
{
//    VehicleModel *vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"86c62cc5-8879-4b7a-9796-89b4971af8da";
//    vehicleModel.brand_id = @"ba9109eb-eebc-4cf7-bb02-f4e1f86e4a1e";
//    vehicleModel.model = @"Fiesta";
//    vehicleModel.type = @"Hatchback";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"b25d6c50-2db2-48e7-aaa5-84f3bb1796a2";
//    vehicleModel.brand_id = @"ba9109eb-eebc-4cf7-bb02-f4e1f86e4a1e";
//    vehicleModel.model = @"Fiesta";
//    vehicleModel.type = @"Hatchback";
//    vehicleModel.model_year = @(2014);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"a072360c-e2c9-48d1-99d9-afb84688b1a8";
//    vehicleModel.brand_id = @"ba9109eb-eebc-4cf7-bb02-f4e1f86e4a1e";
//    vehicleModel.model = @"Focus";
//    vehicleModel.type = @"Sedan";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"7f157030-2abc-4e98-b4d2-d7c75d3bf9be";
//    vehicleModel.brand_id = @"e5bc0d9a-7057-4b50-aedc-182f17985c1e";
//    vehicleModel.model = @"Z3";
//    vehicleModel.type = @"SUV";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"c4844af0-eae1-4bc6-9034-7ad3dda143c6";
//    vehicleModel.brand_id = @"63bf6e3c-0b02-42ff-ad85-a164c7d74c49";
//    vehicleModel.model = @"California";
//    vehicleModel.type = @"Trucks";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"fa236a97-b72b-4b0d-a0fe-0e30b74ea044";
//    vehicleModel.brand_id = @"52ac6486-596a-4acb-8a31-f5c07b67231d";
//    vehicleModel.model = @"C35";
//    vehicleModel.type = @"Sedan";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"7b5052af-c649-4b75-94fa-fb39533ddb78";
//    vehicleModel.brand_id = @"9217a07d-121a-4342-9113-2b2e040c8048";
//    vehicleModel.model = @"MDX";
//    vehicleModel.type = @"SUV";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"77c58e69-b5ed-4fdf-bb9c-9b546edd62e1";
//    vehicleModel.brand_id = @"9217a07d-121a-4342-9113-2b2e040c8048";
//    vehicleModel.model = @"RLX";
//    vehicleModel.type = @"Trucks";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"5baa865d-99e3-4704-8545-f065782c7ba2";
//    vehicleModel.brand_id = @"66e00125-858b-47b4-a3ee-32d410094cdb";
//    vehicleModel.model = @"EB110";
//    vehicleModel.type = @"Sedan";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    vehicleModel = [VehicleModel MR_createEntity];
//    vehicleModel.id = @"3ed7b1a6-4dd8-438c-81cc-8c56b6911bb7";
//    vehicleModel.brand_id = @"7f157030-2abc-4e98-b4d2-d7c75d3bf9be";
//    vehicleModel.model = @"Challenger";
//    vehicleModel.type = @"Sedan";
//    vehicleModel.model_year = @(2015);
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void) importBrands
{
//    Brand *brand = [Brand MR_createEntity];
//    brand.id    =   @"9217a07d-121a-4342-9113-2b2e040c8048";
//    brand.name  =   @"Acura";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Acura-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"e4386129-a142-4785-b009-6066dcc5377d";
//    brand.name  =   @"Alfa Romeo";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/alfa-romeo-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"55131bea-fe1d-483b-b035-bdea015a8f80";
//    brand.name  =   @"Bentley";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Bentley-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"e22e2980-e54d-4d61-a11f-996125f6dd69";
//    brand.name  =   @"Audi";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/audi-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"ba9109eb-eebc-4cf7-bb02-f4e1f86e4a1e";
//    brand.name  =   @"Aston Martin";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/aston-martin-logo1.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"66e00125-858b-47b4-a3ee-32d410094cdb";
//    brand.name  =   @"Bugatti";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/bugatti-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"e5bc0d9a-7057-4b50-aedc-182f17985c1e";
//    brand.name  =   @"BMW";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/bmw-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"5e01d9f3-2daa-4f81-91e3-f0129c0f661d";
//    brand.name  =   @"Buick";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Buick-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"f64b9da6-90a9-4f62-9699-947784e21b7d";
//    brand.name  =   @"Cadillac";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Cadillac-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"7c1f8e44-21c4-4589-ae76-ed53c93ff80b";
//    brand.name  =   @"Chevrolet";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Chevrolet-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"63c7539b-7596-46d4-8593-108deb89b989";
//    brand.name  =   @"Chrysler";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2015/01/Chrysler-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"52ac6486-596a-4acb-8a31-f5c07b67231d";
//    brand.name  =   @"Citroen";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/citroen-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"d5a95074-ca2e-4adc-a79a-c7bc215de310";
//    brand.name  =   @"Dodge";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Dodge-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"63bf6e3c-0b02-42ff-ad85-a164c7d74c49";
//    brand.name  =   @"Ferrari";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/ferrari-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"3bcddb18-c4aa-4306-bcfb-271b61a33315";
//    brand.name  =   @"Fiat";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/fiat-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"cf55e53e-07f9-4dc8-8950-6563b1759c38";
//    brand.name  =   @"Ford";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/ford-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"728b085d-c422-4e30-a272-bfbe7e841725";
//    brand.name  =   @"Geely";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/Geely-Logo1.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"0688271a-e42d-47c7-b0dc-7f70488f7d46";
//    brand.name  =   @"General Motors";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2015/01/General-Motors-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"abc15d8f-dfe5-4838-853f-026ec2c2aab0";
//    brand.name  =   @"GMC";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/GMC-Logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    brand = [Brand MR_createEntity];
//    brand.id    =   @"fdb23448-9395-4c7d-8fca-0291fb4354a7";
//    brand.name  =   @"Honda";
//    brand.logo  =   @"https://8096-presscdn-0-23-pagely.netdna-ssl.com/wp-content/uploads/2014/10/honda-logo.jpg";
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
