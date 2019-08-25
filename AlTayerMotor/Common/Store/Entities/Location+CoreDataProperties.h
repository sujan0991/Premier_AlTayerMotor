//
//  Location+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *isBodyShop;
@property (nullable, nonatomic, retain) NSNumber *isServiceCenter;
@property (nullable, nonatomic, retain) NSNumber *isShowRoom;
@property (nullable, nonatomic, retain) NSNumber *lang;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *openHourTitle1;
@property (nullable, nonatomic, retain) NSString *openHourTitle2;
@property (nullable, nonatomic, retain) NSString *openHourTitle3;
@property (nullable, nonatomic, retain) NSString *openHourValue1;
@property (nullable, nonatomic, retain) NSString *openHourValue2;
@property (nullable, nonatomic, retain) NSString *openHourValue3;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSData *brandids;

@end

NS_ASSUME_NONNULL_END
