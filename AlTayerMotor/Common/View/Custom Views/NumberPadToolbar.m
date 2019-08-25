//
//  NumberPadToolbar.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NumberPadToolbar.h"

@interface NumberPadToolbar()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation NumberPadToolbar

- (instancetype)initWithTextField:(UITextField *)textfield
{
    CGRect sizeRect = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:CGRectMake(0, 0, sizeRect.size.width, 50)]) {
        self.textField = textfield;
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil action:nil];
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneWithNumberPad:)];
        self.items = @[space, btnDone];
        [self sizeToFit];
    }
    
    return self;
}

- (instancetype)initWithTextView:(UITextView *)textView
{
    CGRect sizeRect = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:CGRectMake(0, 0, sizeRect.size.width, 50)]) {
        self.textView = textView;
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil action:nil];
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneWithNumberPad:)];
        self.items = @[space, btnDone];
        [self sizeToFit];
    }
    
    return self;
}

-(IBAction)doneWithNumberPad:(id)sender
{
    if (self.textField) {
        [self.textField resignFirstResponder];
        [self.numberPadDelegate numberPadToolbar:self didClickDone:self.textField];
    }
    
    if (self.textView) {
        [self.textView resignFirstResponder];
        [self.numberPadDelegate numberPadToolbar:self didClickDone:self.textView];
    }
    
    
    
}

@end
