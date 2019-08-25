//
//  ReminderViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ReminderViewController.h"
#import "DateManager.h"
#import "ATMFullRowButton.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbHeadline.text = LOCALIZED(@"TEXT REMINDER");
    [self.btnClose setTitle:LOCALIZED(@"TEXT CLOSE")
                   forState:UIControlStateNormal];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    components.day = kReminderDate;
//    NSDate *oneMonthFromNow = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    NSDate *remindedDate = _dateStr ? [[[DateManager sharedManager] presentedDateFormatter] dateFromString:_dateStr] : [NSDate date];
    NSString *dateStr = [[[DateManager sharedManager] reminderFormatter] stringFromDate:remindedDate];
    NSString *content = [NSString stringWithFormat:@"%@%@. %@",
                               LOCALIZED(@"TEXT REMINDER CONTENT ONE"),
                               dateStr,
                               LOCALIZED(@"TEXT REMINDER CONTENT TWO")];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:content];
    [attrString setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}
                        range:[content rangeOfString:dateStr]];
    self.tfExpiredDate.numberOfLines = 0;
    self.tfExpiredDate.attributedText = attrString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)closeAction:(id)sender {
    [UIView animateWithDuration:0.33 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        NSDate *remindedDate = _dateStr ? [[[DateManager sharedManager] presentedDateFormatter] dateFromString:_dateStr] : [NSDate date];
        NSInteger dateNumber = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:remindedDate] integerValue];
        [ATMGlobal reminderSetLastShownDate:dateNumber];
        
        [self.view removeFromSuperview];
        self.view = nil;
        [self removeFromParentViewController];
        [self didMoveToParentViewController:nil];
        
        // Log Event
        [[GTMHelper sharedInstance] logEvent:kEventNotification
                                inScreenName:kScreenReminder];
    }];
}

@end
