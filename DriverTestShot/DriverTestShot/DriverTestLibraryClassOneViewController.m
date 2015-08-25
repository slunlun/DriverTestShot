//
//  DriverTestLibraryViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "DriverTestLibraryClassOneViewController.h"

#import "FlowLayoutForPageTest.h"
#import "WaterFallUICollectionViewCell.h"
#import "DriverTestQuestionsViewController.h"

static NSString *CELL_IDENTITY = @"cellIdentify";
#define NAV_BAR_HEIGHT 60

@interface DriverTestLibraryClassOneViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UINavigationBar *navigationBar;
@end

@implementation DriverTestLibraryClassOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // INIT CollectionView
    FlowLayoutForPageTest *flowLayout = [[FlowLayoutForPageTest alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    [_collectionView registerClass:[WaterFallUICollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTITY];
    [self.view addSubview:_collectionView];
    
    // INIT NavigationBar
    [self layoutNavigationBar];

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
#pragma mark UI INIT
-(void) layoutNavigationBar
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, NAV_BAR_HEIGHT)];
    // set the interface of navigation
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"CLASS_ONE", nil)];
    
    
    UIBarButtonItem *showSlideMenuBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SlideMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(showSlideMenuBtnPressed)];
    showSlideMenuBarButton.tintColor = [UIColor blackColor];
    navItem.leftBarButtonItem = showSlideMenuBarButton;
    
    UIImageView *userPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyHead.jpg"]];
    userPic.frame = CGRectMake(0, 0, 30, 30);
    userPic.layer.cornerRadius = userPic.frame.size.width / 2;
    userPic.clipsToBounds = YES;
    userPic.layer.borderWidth = 1.0f;
    userPic.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoBtnPressed)];
    [userPic addGestureRecognizer:tapRecognizer];
    
    
    UIBarButtonItem *userInfoBtn = [[UIBarButtonItem alloc] initWithCustomView:userPic];
    navItem.rightBarButtonItem = userInfoBtn;
    
    [_navigationBar pushNavigationItem:navItem animated:YES];
    _navigationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigationBar];
    
}
-(void) userInfoBtnPressed
{
    NSLog(@"User Info pressed");
}

-(void) showSlideMenuBtnPressed
{
    NSLog(@"show Slide Menu pressed");
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else
    {
        return 3;
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTITY forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:@"classOne.png"];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Now select %@", indexPath);
    if ([self.delegate respondsToSelector:@selector(DriverTestView:shouldShowViewController:)]) {
        DriverTestQuestionsViewController *vc = [[DriverTestQuestionsViewController alloc] init];
        [self.delegate DriverTestView:self shouldShowViewController:vc];
        
    }
}
@end
