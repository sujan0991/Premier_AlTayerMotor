//
//  NumberPadToolbar.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberPadToolbar;

@protocol NumberPadToolbarDelegate <NSObject>

@optional
- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UIView *)textField;
- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickCancel:(UIView *)textField;

@end

@interface NumberPadToolbar : UIToolbar
@property (nonatomic, weak) id<NumberPadToolbarDelegate> numberPadDelegate;
- (instancetype)initWithTextField:(UITextField *)textfield;
- (instancetype)initWithTextView:(UITextView *)textView;
@end
