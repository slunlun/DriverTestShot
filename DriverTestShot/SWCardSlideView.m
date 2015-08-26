//
//  SWCardSlideView.m
//  SWCardSlideView
//
//  Created by EShi on 8/14/15.
//  Copyright (c) 2015 nextlabs. All rights reserved.
//

#import "SWCardSlideView.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
#define CARD_VIEW_BOUND_INTEVAL 0.3
#define CARD_VIEW_BOUND_AMPLITUDE 30
#define kHorizontalEdgeOffset   65

@interface SWCardSlideView()
@property(nonatomic) CGRect originRect;
@property(nonatomic) CGPoint originPoint;
@property(nonatomic) CGPoint preOffPoint;
@property(nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property(nonatomic, strong) UISwipeGestureRecognizer *swipeRecognizer;
@property(nonatomic) CGFloat totalRotateDegrees;
@end

@implementation SWCardSlideView
#pragma INIT/SETTER/GETTER
-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _originRect = frame;
        _originPoint = self.center;
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCardView:)];
        _swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipeFrom:)];
        [self addGestureRecognizer:_panRecognizer];
        [self addGestureRecognizer:_swipeRecognizer];
        
    }
    return self;
}

#pragma mark Slide Card Operation
-(void) showFromLeft
{
    CGFloat startX = -self.superview.frame.size.width;
    self.center = CGPointMake(startX, self.center.y);
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-60));
    
    [UIView animateWithDuration:1 animations:^{
        self.center = _originPoint;
        self.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void) slideOffLeft
{
    CGFloat endX = -self.superview.frame.size.width;
    [UIView animateWithDuration:1 animations:^{
        self.center = CGPointMake(endX, self.center.y);
    } completion:^(BOOL finished) {
         self.totalRotateDegrees = 0.0f;
        if ([self.delegate respondsToSelector:@selector(cardDidSlideOffLeft:)]) {
            [self.delegate cardDidSlideOffLeft:self];
        }
    }];
}

-(void) showFromRight
{
    CGFloat startX = self.superview.frame.size.width * 2;
    self.center = CGPointMake(startX, self.center.y);
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(60));
    
    [UIView animateWithDuration:1 animations:^{
        self.center = _originPoint;
        self.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        
    }];
}
-(void) slideOffRight
{
    CGFloat endX = self.superview.frame.size.width * 2;
    [UIView animateWithDuration:1 animations:^{
        self.center = CGPointMake(endX, self.center.y);
    } completion:^(BOOL finished) {
        self.totalRotateDegrees = 0.0f;
        if ([self.delegate respondsToSelector:@selector(cardDidSLideOffRight:)]) {
            [self.delegate cardDidSLideOffRight:self];
        }
    }];
}

-(void) cardViewBound
{
    BOOL cardMoveToRight = NO;
    BOOL cardMoveToLeft = NO;
    
    if ((self.center.x - self.originPoint.x) > 0) {
        cardMoveToRight = YES;
    }else if((self.center.x - self.originPoint.x) < 0 )
    {
        cardMoveToLeft = YES;
    }else
    {
        return;
    }
    
    [UIView animateWithDuration:CARD_VIEW_BOUND_INTEVAL  animations:^{
        if (cardMoveToLeft) {
            CGFloat boundRightX = self.originPoint.x + CARD_VIEW_BOUND_AMPLITUDE;
            self.center = CGPointMake(boundRightX, self.center.y);
            
        }else if(cardMoveToRight)
        {
            CGFloat boundLeftX = self.originPoint.x - CARD_VIEW_BOUND_AMPLITUDE;
            self.center = CGPointMake(boundLeftX, self.center.y);

        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:CARD_VIEW_BOUND_INTEVAL  animations:^{
            if (cardMoveToLeft) {
                CGFloat boundLeftX = self.originPoint.x - CARD_VIEW_BOUND_AMPLITUDE;
                self.center = CGPointMake(boundLeftX, self.center.y);
               
                
            }else if(cardMoveToRight)
            {
                CGFloat boundRightX = self.originPoint.x + CARD_VIEW_BOUND_AMPLITUDE;
                self.center = CGPointMake(boundRightX, self.center.y);
                
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:CARD_VIEW_BOUND_INTEVAL  animations:^{
                
                self.center = self.originPoint;
                
            } completion:^(BOOL finished) {
                
            }];

        }];
    }];
    
    
}
#pragma mark gesture operation
-(void) panCardView:(UIPanGestureRecognizer *) recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.preOffPoint = [recognizer translationInView:self];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat offX = [recognizer translationInView:self].x - self.preOffPoint.x;
           
            self.preOffPoint = [recognizer translationInView:self];
            
           self.center = CGPointMake(self.center.x + offX, self.center.y);
            if (self.totalRotateDegrees < 360 && offX > 0) {
                self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS([recognizer translationInView:self].x * 0.25));
                self.totalRotateDegrees += [recognizer translationInView:self].x * 0.25;

            }
            
            if (self.totalRotateDegrees > -360 && offX < 0) {
                self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS([recognizer translationInView:self].x * 0.25));
                self.totalRotateDegrees += [recognizer translationInView:self].x * 0.25;
            }
        }
            break;
        case UIGestureRecognizerStateRecognized:
        {
            CGSize superSize = self.superview.frame.size;
            if (self.center.x > superSize.width - kHorizontalEdgeOffset) {
                [self slideOffRight];
            }else if((self.center.x - kHorizontalEdgeOffset) < 0.0f){
                [self slideOffLeft];
            }
            else
            {
                self.transform = CGAffineTransformMakeRotation(0);
                self.totalRotateDegrees = 0;
                [self cardViewBound];
            }
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.transform = CGAffineTransformMakeRotation(0);
            self.totalRotateDegrees = 0;
            [self cardViewBound];
        }
            break;
        default:
            break;
    }
}

-(void) handSwipeFrom:(UISwipeGestureRecognizer *) recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self slideOffLeft];
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        [self slideOffRight];
    }
}
@end
