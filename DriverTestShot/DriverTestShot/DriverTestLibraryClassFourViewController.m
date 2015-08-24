//
//  DriverTestLibraryClassTwoViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "DriverTestLibraryClassFourViewController.h"

#import "FlowLayoutForPageTest.h"
#import "WaterFallUICollectionViewCell.h"
#import "DriverTestQuestionsViewController.h"

static NSString *CELL_IDENTITY = @"cellIdentify";

@interface DriverTestLibraryClassFourViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation DriverTestLibraryClassFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // INIT CollectionView
    FlowLayoutForPageTest *flowLayout = [[FlowLayoutForPageTest alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    [_collectionView registerClass:[WaterFallUICollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTITY];
    [self.view addSubview:_collectionView];
    
    // INIT NavigationBar
    self.navigationController.title = NSLocalizedString(@"CLASS_FOUR", nil);


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
    
    cell.image = [UIImage imageNamed:@"MyHead.jpg"];
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
