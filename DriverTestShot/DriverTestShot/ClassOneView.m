//
//  UIViewTest.m
//  DriverTestShot
//
//  Created by ShiTeng on 15/8/23.
//  Copyright (c) 2015年 Eren. All rights reserved.
//

#import "ClassOneView.h"
#import "FlowLayoutForPageTest.h"
#import "WaterFallUICollectionViewCell.h"

static NSString *CELL_IDENTITY = @"cellIdentify";

@interface ClassOneView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UINavigationBar *bar;
@property(nonatomic, strong) UICollectionView *collectionView;
@end
@implementation ClassOneView


-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // INIT BAR
        _bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(removeSelf)];
        
        [self addSubview:_bar];
        
        [_bar pushNavigationItem:item animated:NO];
        [item setLeftBarButtonItem:button];
        
        
        // INIT CollectionView
         FlowLayoutForPageTest *flowLayout = [[FlowLayoutForPageTest alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.dataSource =self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        [_collectionView registerClass:[WaterFallUICollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTITY];
        [self addSubview:_collectionView];

    }
    
    return self;
}

-(void) removeSelf
{
    NSLog(@"remove Self preese!");
}

#pragma mark UICollecitonViewDataSource

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
}
@end
