//
//  SWDrag2ShowMenu.h
//  Drag2ShowMenu
//
//  Created by EShi on 7/17/15.
//  Copyright (c) 2015 EShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWDrag2ShowMenu : UIView
@property(nonatomic, weak) UIView *contentView;
@property(nonatomic, weak) UIView *menuContentView;

@property(nonatomic) CGFloat menuViewWidth;
@property(nonatomic) CGFloat menuViewSlideInWidth;

-(void) showSlideMenu;
-(instancetype) initWithContentView:(UIView *) contentView;
@end
