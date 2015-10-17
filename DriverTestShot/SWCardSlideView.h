//
//  SWCardSlideView.h
//  SWCardSlideView
//
//  Created by EShi on 8/14/15.
//  Copyright (c) 2015 nextlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWCardSlideView;
@protocol SWCardSlideViewDelegate <NSObject>

@optional
-(BOOL) cardShouldSlideOffLeft:(SWCardSlideView *) cardView;
-(void) cardDidSlideOffLeft:(SWCardSlideView *) cardView;

-(BOOL) cardShouldSlideOffRight:(SWCardSlideView *) cardView;
-(void) cardDidSLideOffRight:(SWCardSlideView *) cardView;

@end

@interface SWCardSlideView : UIView
@property(nonatomic, weak) id<SWCardSlideViewDelegate> delegate;


-(void) showFromLeft;
-(void) slideOffLeft;

-(void) showFromRight;
-(void) slideOffRight;

-(void) cardViewBound;
@end
