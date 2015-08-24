//
//  ViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/18/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "DriverTestMainViewController.h"
#import "SWDrag2ShowMenu.h"
#import "UserInfoTableViewCell.h"
#import "DriverTestLibraryClassOneViewController.h"
#import "DriverTestLibraryClassFourViewController.h"
#import "DriverTestTabBarController.h"
#import "DriverTestLibNavigationViewController.h"

#import "ClassOneView.h"

@interface DriverTestMainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *slideTableViewMenu;
@property(nonatomic, strong) DriverTestLibraryClassOneViewController *classOneVC;
@property(nonatomic, strong) DriverTestTabBarController *mainTabBarController;
@property(nonatomic, strong) SWDrag2ShowMenu *drag2ShowMenu;
@end

static NSString *cellIdentify = @"MyCellIdentify";
@implementation DriverTestMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // init tab bar
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    _mainTabBarController = [stroyBoard instantiateViewControllerWithIdentifier:@"DRIVER_TEST_BAR_CONTROLLER"];
    
    _slideTableViewMenu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, self.view.frame.size.height)];
    _slideTableViewMenu.delegate = self;
    _slideTableViewMenu.dataSource = self;
    _slideTableViewMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _drag2ShowMenu = [[SWDrag2ShowMenu alloc] initWithContentView:_mainTabBarController.view];
    _drag2ShowMenu.menuContentView = _slideTableViewMenu;
    [self.view addSubview:_drag2ShowMenu];
    
    // 
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return 2;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserInfoTableViewCell *cell = [UserInfoTableViewCell initWithTableView:tableView userInfoCellWithUserName:@"时滕" userHeadImage:[UIImage imageNamed:@"MyHead.jpg"]];
        cell.imageView.center = cell.center;
        return cell;
    }
    static NSString *normalCellIdentify = @"NormalListCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentify];
    }
    cell.textLabel.text = @"Test 1";
    cell.imageView.image = [UIImage imageNamed:@"classTwo.png"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.drag2ShowMenu closeSideBar];
    
    
    if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:  //科目一
            {
                self.mainTabBarController.selectedIndex = 0;
                DriverTestLibNavigationViewController *nav = self.mainTabBarController.viewControllers[0];
                UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                DriverTestLibraryClassOneViewController *testOneVC = [stroyBoard instantiateViewControllerWithIdentifier:@"TEST_ONE_VC"];
                NSArray *vcArray = [[NSArray alloc] initWithObjects:testOneVC, nil];
                nav.viewControllers = vcArray;
                
            }
                break;
            case 1:  //科目四
            {
                self.mainTabBarController.selectedIndex = 0;
                DriverTestLibNavigationViewController *nav = self.mainTabBarController.viewControllers[0];
                UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                DriverTestLibraryClassFourViewController *testFourVC = [stroyBoard instantiateViewControllerWithIdentifier:@"TEST_FOUR_VC"];
                NSArray *vcArray = [[NSArray alloc] initWithObjects:testFourVC, nil];
                nav.viewControllers = vcArray;
            }
                break;
            default:
                break;
        }
    }
}
@end
