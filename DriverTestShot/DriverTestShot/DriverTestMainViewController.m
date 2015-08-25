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
#import "DriverTestViewDelegate.h"
#import "DriverApplyViewController.h"

#define USER_INFO_SECTION_NUM 0
#define DRIVER_TEST_SECTION_NUM 1
#define CLASS_ONE_CELL_ROW 0
#define CLASS_FOUR_CELL_ROW 1

@interface DriverTestMainViewController ()<UITableViewDataSource, UITableViewDelegate, DriverTestViewProtocal>
@property(nonatomic, strong) UITableView *slideTableViewMenu;

// subview
@property(nonatomic, strong) SWDrag2ShowMenu *drag2ShowMenu;
// tabbar
@property(nonatomic, strong) DriverTestTabBarController *mainTabBarController;
// tab 1 : Driver Test
@property(nonatomic, strong) DriverTestLibraryClassOneViewController *classOneVC;
@property(nonatomic, strong) DriverTestLibraryClassFourViewController *classFourVC;
// tab 2:Driver Apply
@property(nonatomic, strong) DriverApplyViewController *driverApplyVC;



@end

static NSString *cellIdentify = @"MyCellIdentify";
@implementation DriverTestMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // init tab bar
    _mainTabBarController = [[DriverTestTabBarController alloc] init];
    
    _classOneVC = [[DriverTestLibraryClassOneViewController alloc] init];
    _classOneVC.delegate = self;
    _classFourVC = [[DriverTestLibraryClassFourViewController alloc] init];
    _classFourVC.delegate = self;
    
    _driverApplyVC = [[DriverApplyViewController alloc] init];
    
    NSArray *tabBarArray = [[NSArray alloc] initWithObjects:_classOneVC, _driverApplyVC, nil];
    _mainTabBarController.viewControllers = tabBarArray;
    UITabBar *tabBar = _mainTabBarController.tabBar;
    UITabBarItem *itemFile = [tabBar.items objectAtIndex:0];
    itemFile.title = NSLocalizedString(@"DRIVER_TEST", NULL);
    itemFile.image = [UIImage imageNamed:@"DriverCard"];
    itemFile.selectedImage = [UIImage imageNamed:@"DirverCardSEL"];
    
    UITabBarItem *itemAccount = [tabBar.items objectAtIndex:1];
    itemAccount.title = NSLocalizedString(@"DRIVER_APPLY", NULL);
    itemAccount.image = [UIImage imageNamed:@"Drive"];
    itemAccount.selectedImage = [UIImage imageNamed:@"DriveSEL"];
    
    
    
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
    if (section == USER_INFO_SECTION_NUM) {
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
    // UserInfo section
    if (indexPath.section == USER_INFO_SECTION_NUM) {
        UserInfoTableViewCell *cell = [UserInfoTableViewCell initWithTableView:tableView userInfoCellWithUserName:@"时滕" userHeadImage:[UIImage imageNamed:@"MyHead.jpg"]];
        cell.imageView.center = cell.center;
        return cell;
    }
    
    // DriverTest section
    if (indexPath.section == DRIVER_TEST_SECTION_NUM) {
        static NSString *normalCellIdentify = @"NormalListCellIdentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentify];
        }
        switch (indexPath.row) {
            case CLASS_ONE_CELL_ROW: //科目一
            {
                cell.textLabel.text = NSLocalizedString(@"CLASS_ONE", nil);
                cell.imageView.image = [UIImage imageNamed:@"classOne.png"];

            }
                break;
            case CLASS_FOUR_CELL_ROW: //科目四
            {
                cell.textLabel.text = NSLocalizedString(@"CLASS_FOUR", nil);
                cell.imageView.image = [UIImage imageNamed:@"classFour.png"];
            }
                break;
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
#pragma mark DriverTestViewProtocal
-(void) DriverTestView:(UIViewController *) driverTestView shouldShowViewController:(UIViewController *) viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void) DriverTestViewSlideMenuBarPressed:(UIViewController *) driverTestView
{
    [self.drag2ShowMenu switchSlideBarState];
}
#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.drag2ShowMenu closeSideMenu];
    self.slideTableViewMenu.scrollsToTop = YES;
    NSIndexPath* indexPathZero = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.slideTableViewMenu scrollToRowAtIndexPath:indexPathZero atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.slideTableViewMenu deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section == DRIVER_TEST_SECTION_NUM) {
        self.mainTabBarController.selectedIndex = 0;
        switch (indexPath.row) {
            case CLASS_ONE_CELL_ROW:  //科目一
            {
                NSArray *barArray = [[NSArray alloc] initWithObjects:self.classOneVC, self.driverApplyVC, nil];
                self.mainTabBarController.viewControllers = barArray;
            }
                break;
            case CLASS_FOUR_CELL_ROW:  //科目四
            {
                
                NSArray *vcArray = [[NSArray alloc] initWithObjects:self.classFourVC, self.driverApplyVC, nil];
                self.mainTabBarController.viewControllers = vcArray;
                UITabBar *tabBar = self.mainTabBarController.tabBar;
                UITabBarItem *itemAccount = [tabBar.items objectAtIndex:0];
                itemAccount.title = NSLocalizedString(@"DRIVER_TEST", NULL);
                itemAccount.image = [UIImage imageNamed:@"DriverCard"];
                itemAccount.selectedImage = [UIImage imageNamed:@"DriverCardSEL"];
            }
                break;
            default:
                break;
        }
    }
}


@end
