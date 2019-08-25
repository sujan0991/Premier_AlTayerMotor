//
//  CustomWebViewController.m
//  AlTayerMotors
//
//  Created by Lucas Nguyen on 7/20/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "CustomWebViewController.h"
#import "UIViewController+EmptyBackButton.h"
#import "UIViewController+MMDrawerController.h"

@interface CustomWebViewController ()
@property (nonatomic, strong) UIBarButtonItem *btnMenu;
@end

@implementation CustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    [self.navigationController.navigationBar.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : 1,1)];
    [self.navigationItem.titleView.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : 1,1)];
    for (UIView *subview in [self.navigationItem.titleView allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : 1,1)];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self setToolbarItems:@[]];
    [self.navigationController.toolbar removeFromSuperview];
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

- (void)addRightMenuWithAction:(SEL)action inController:(UIViewController*)controller
{
    UIImage *image = [UIImage imageNamed:@"icon_menu"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    self.btnMenu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = self.btnMenu;
}

- (IBAction)toggleMenu:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
