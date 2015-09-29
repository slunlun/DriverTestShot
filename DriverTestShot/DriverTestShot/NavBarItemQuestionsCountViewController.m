//
//  NavBarItemQuestionsCountViewController.m
//  DriverTestShot
//
//  Created by EShi on 9/25/15.
//  Copyright © 2015 Eren. All rights reserved.
//

#import "NavBarItemQuestionsCountViewController.h"

@interface NavBarItemQuestionsCountViewController ()

@end

@implementation NavBarItemQuestionsCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    }

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view from its nib.
    NSLayoutConstraint *itemImageViewWidthCons = [NSLayoutConstraint constraintWithItem:self.itemImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *itemImageViewHidthCons = [NSLayoutConstraint constraintWithItem:self.itemImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0.0];
    NSLayoutConstraint *itemImageViewTopCons = [NSLayoutConstraint constraintWithItem:self.itemImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *itemLabelViewWidthCons = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *itemLabelViewHeightCons = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0.0];
    NSLayoutConstraint *itemLabelViewTopCons = [NSLayoutConstraint constraintWithItem:self.itemLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.itemImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:itemImageViewWidthCons];
    [self.view addConstraint:itemImageViewHidthCons];
    [self.view addConstraint:itemLabelViewWidthCons];
    [self.view addConstraint:itemLabelViewHeightCons];
    [self.view addConstraint:itemImageViewTopCons];
    [self.view addConstraint:itemLabelViewTopCons];

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
