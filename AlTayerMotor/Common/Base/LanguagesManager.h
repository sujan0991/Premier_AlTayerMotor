//
//  LanguagesManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/11/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguagesManager : NSObject

+ (id)sharedInstance;
- (NSString *)getTextForKey:(NSString *)key;
@end
