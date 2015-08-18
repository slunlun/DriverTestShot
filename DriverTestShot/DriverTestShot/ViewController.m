//
//  ViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/18/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "ViewController.h"
#import "SWDrag2ShowMenu.h"
#import "UserInfoTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *slideTableViewMenu;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) SWDrag2ShowMenu *drag2ShowMenu;
@end

static NSString *cellIdentify = @"MyCellIdentify";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentView = [[UIView alloc] initWithFrame:self.view.frame];
    _contentView.backgroundColor = [UIColor yellowColor];
    
    
    _slideTableViewMenu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5*4, self.view.frame.size.height)];
    _slideTableViewMenu.delegate = self;
    _slideTableViewMenu.dataSource = self;
    _slideTableViewMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _drag2ShowMenu = [[SWDrag2ShowMenu alloc] initWithContentView:_contentView];
    _drag2ShowMenu.menuContentView = _slideTableViewMenu;
    [self.view addSubview:_drag2ShowMenu];

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
        UserInfoTableViewCell *cell = [UserInfoTableViewCell initWithTableView:tableView userInfoCellWithUserName:@"slunlun" userHeadImage:[UIImage imageNamed:@"MyHead.jpg"]];
        return cell;
    }
    static NSString *normalCellIdentify = @"NormalListCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentify];
    }
    cell.textLabel.text = @"Test 1";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
@end
