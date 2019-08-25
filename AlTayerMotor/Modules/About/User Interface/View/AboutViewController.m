//
//  AboutViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/19/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "AboutViewController.h"
#import "NSString+Color.h"
#import "CustomWebViewController.h"

@interface AboutViewController()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@end

@implementation AboutViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // Mutiple language
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE AL TAYER GROUP");
//    self.tvContent.text = LOCALIZED(@"TEXT ABOUT CONTENT");
    self.tvContent.attributedText = [self attributedContent];
    self.tvContent.delegate = self;
    TEXT_ALIGN(self.tvContent);
//    if (![ATMGlobal isEnglish]) {
//        self.tvContent.font = [UIFont fontWithName:@"Arial" size:18];
//        self.tvContent.textColor = [@"474747" representedColor];
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad inScreenName:kScreenAbout];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tvContent scrollRangeToVisible:NSMakeRange(0, 0)];
        [self.tvContent setContentOffset:CGPointMake(0, -self.tvContent.contentInset.top) animated:NO];
    });
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (!parent) {
        [self activeAllTabBarItems];
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.tvContent setContentOffset:CGPointZero animated:NO];
}

- (NSAttributedString *)attributedContent {
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] init];
    
    // Plain Text
    NSString *plainText = LOCALIZED(@"TEXT ABOUT CONTENT");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName: [@"474747" representedColor]};
    if (![ATMGlobal isEnglish]) {
        attributes = @{NSFontAttributeName : [UIFont fontWithName:@"Arial" size:18], NSForegroundColorAttributeName: [@"474747" representedColor]};
    }
    NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:plainText attributes:attributes];
    [mutableAttString appendAttributedString:newAttString];
    
    NSMutableDictionary *linkAttributes = [@{} mutableCopy];
    linkAttributes[NSFontAttributeName] = attributes[NSFontAttributeName];
    linkAttributes[NSForegroundColorAttributeName] = [@"0000EE" representedColor];
    linkAttributes[NSLinkAttributeName] = [ATMGlobal isEnglish] ? @"http://altayer.com" : @"https://www.altayermotors.com/ar";
    NSAttributedString *linkAttString = [[NSAttributedString alloc] initWithString:LOCALIZED(@"TEXT AL TAYER GROUP") attributes:linkAttributes];
    [mutableAttString appendAttributedString:linkAttString];
    
    return mutableAttString;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    CustomWebViewController *webVC = [[CustomWebViewController alloc] initWithURL:URL];
    webVC.supportedWebNavigationTools = DZNWebNavigationToolAll;
    webVC.supportedWebActions = DZNWebActionAll;
    webVC.showLoadingProgress = NO;
    webVC.allowHistory = YES;
    webVC.hideBarsWithGestures = NO;
    webVC.navigationItem.hidesBackButton = YES;
    [self.navigationController setToolbarHidden:NO];
    
    [self.navigationController pushViewController:webVC
                                         animated:YES];
    
    return NO;
}

@end
