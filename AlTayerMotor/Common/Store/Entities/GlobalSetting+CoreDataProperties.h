//
//  GlobalSetting+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GlobalSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalSetting (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSString *key;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *nameAR;
@property (nullable, nonatomic, retain) NSString *parent_key;

@end

NS_ASSUME_NONNULL_END
