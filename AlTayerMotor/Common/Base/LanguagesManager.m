//
//  LanguagesManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/11/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "LanguagesManager.h"

@interface LanguagesManager()

@property (nonatomic, strong) NSString *languageAbbreviation;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation LanguagesManager

+ (id)sharedInstance {
    static LanguagesManager *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (NSDictionary *)dictionary
{
    if (!_dictionary) {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Languages"
                                                             ofType:@"plist"];
        _dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    
    return _dictionary;
}

- (NSString *)languageAbbreviation
{
    return [ATMGlobal isEnglish] ? @"en" : @"ar";
}

- (NSString *)getTextForKey:(NSString *)key
{
    return self.dictionary[key][self.languageAbbreviation];
}


@end
