//
//  MLocation.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/3/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@class Location;

@interface MLocation : MBase

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) BOOL isShowRoom;
@property (nonatomic, assign) BOOL isServiceCenter;
@property (nonatomic, assign) BOOL isBodyShop;
@property (nonatomic, assign) AppLanguage lang;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *openHourTitle1;
@property (nonatomic, strong) NSString *openHourTitle2;
@property (nonatomic, strong) NSString *openHourTitle3;
@property (nonatomic, strong) NSString *openHourValue1;
@property (nonatomic, strong) NSString *openHourValue2;
@property (nonatomic, strong) NSString *openHourValue3;
@property (nonatomic, strong) NSArray *brandids;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithDatabaseObject:(Location *)location;

@end
