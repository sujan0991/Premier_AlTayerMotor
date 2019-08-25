//
//  NSString+Utils.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isInvalid
{
    return !self || [self isEqual:[NSNull null]] || self.length == 0 || [self isEqualToString:@"(null)"];
}

- (NSString *)toImageLink
{
    if (self && ![self isEqual:[NSNull null]] && ![self isInvalid]) {

        return [NSString stringWithFormat:@"https://%@%@%@%@", [ATMGlobal getImageLink], self, [self containsString:@"?"] ? @"&" : @"?", @"preset=992"];
    }
    
    return nil;
}

- (BOOL) validateEmail
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL) validatePhoneNumber
{
    //    NSCharacterSet *characterSet  = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
    //    NSArray *inputString = [self componentsSeparatedByCharactersInSet:characterSet];
    //    NSString *filtered = [inputString componentsJoinedByString:@""];
    //    return  self == filtered;
    
    NSString *phoneRegex = @"^((\\+)|[0-9])[0-9 ]{1,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

@end
