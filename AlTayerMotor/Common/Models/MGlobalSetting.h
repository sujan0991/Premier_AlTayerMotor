//
//  MGlobalSetting.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class GlobalSetting;

@interface MGlobalSetting : MBase

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameAR;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *parentKey;
@property (strong, nonatomic) NSArray *subItems;

-(instancetype)initWithDict:(NSDictionary *)dict withParentKey:(NSString*)parentKey atIndex:(NSInteger)index;
-(instancetype)initWithDatabaseObject:(GlobalSetting *)setting;

@end
