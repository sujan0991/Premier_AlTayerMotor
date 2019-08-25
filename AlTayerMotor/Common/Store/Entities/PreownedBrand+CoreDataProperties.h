//
//  PreownedBrand+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Lucas Nguyen on 8/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PreownedBrand.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreownedBrand (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *name_ar;
@property (nullable, nonatomic, retain) NSString *no_preowned_message;
@property (nullable, nonatomic, retain) NSString *no_preowned_message_ar;
@property (nullable, nonatomic, retain) NSString *roadside;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSNumber *oldest_year;

@end

NS_ASSUME_NONNULL_END
