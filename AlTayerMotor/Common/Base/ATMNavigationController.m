//
//  ATMNavigationController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/12/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "ATMNavigationController.h"

@interface ATMNavigationController ()

@end

@implementation ATMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
