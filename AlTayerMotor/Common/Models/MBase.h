//
//  MBase.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBase : NSObject

- (BOOL)isDictionary:(id)dict;
- (BOOL)isArray:(id)array;
- (BOOL)isValidString:(id)field;

@end
