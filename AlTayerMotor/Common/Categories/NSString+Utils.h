//
//  NSString+Utils.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (BOOL)isInvalid;
- (NSString *)toImageLink;
- (BOOL) validateEmail;
- (BOOL) validatePhoneNumber;
@end
