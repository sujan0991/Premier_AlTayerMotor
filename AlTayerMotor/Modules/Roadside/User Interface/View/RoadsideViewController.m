//
//  RoadsideViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsideViewController.h"
#import "RoadsideCell.h"
#import "RoadsideModuleInterface.h"
#import "MBrand.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewUtils.h"
#import "NSString+Color.h"
#import "UIView+Roundify.h"
#import "NSString+Utils.h"

#define RoadsideCellIdentifier                 @"RoadsideCell"

@interface RoadsideViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *brands;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RoadsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self.eventHandler findAllBrands];
    AFFINE_TRANSFORM(_tableView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (!parent) {
        [self activeAllTabBarItems];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Updating UI
- (void)setupViews
{
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    self.navigationItem.title = LOCALIZED(@"MENU ROADSIDE ASSISTANCE");
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20, 0.0);
    
    // config gradient background
    [self.view setBackGroundGradientFromColor:[@"22416b" representedColor]
                                      toColor:[@"071f3d" representedColor]];
}

#pragma mark - View Interface
- (void)foundAllBrands:(NSArray *)brands
{
    self.brands = brands;
    [self.tableView reloadData];
}

#pragma mark - Table View Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brands.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 98.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 98)];
    //    view.backgroundColor = [@"#21416A" representedColor];
    //    view.backgroundColor = [UIColor clearColor];
    [view setBackGroundGradientFromColor:[@"22416b" representedColor]
                                 toColor:[@"1f3d66" representedColor]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 21, screenWidth - 30, 77)];
    [view addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                    withRadii:CGSizeMake(8, 8)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, bgView.width - 24, bgView.height)];
    label.numberOfLines = 4;
    label.backgroundColor = [UIColor clearColor];
    label.text = LOCALIZED(@"TEXT ROADSIDE TITLE");
    label.textColor = [@"777777" representedColor];
    label.font = [UIFont systemFontOfSize:13.f];
    label.minimumScaleFactor = 0.5;
    label.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:label];
    
    AFFINE_TRANSFORM(label);
    TEXT_ALIGN(label);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoadsideCell *cell = [tableView dequeueReusableCellWithIdentifier:RoadsideCellIdentifier];
    MBrand *brand = self.brands[indexPath.row];
    cell.lbBrand.text = [brand.name uppercaseString];
    [cell.imvBrand sd_setImageWithURL:[NSURL URLWithString:[brand.logo toImageLink]]
                     placeholderImage:[UIImage imageNamed:@"icon_placeholder_brand"]];
    
    cell.lineView.hidden = (self.brands.count - 1 == indexPath.row);
    cell.lastRow = (self.brands.count - 1 == indexPath.row);
    cell.btnPhone.hidden = !(brand && brand.roadsideAssistance && ![brand.roadsideAssistance isEqual:[NSNull null]] && brand.roadsideAssistance.length > 0);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBrand *brand = self.brands[indexPath.row];
    [ATMGlobal callPhoneNumber:brand.roadsideAssistance];
}

@end
