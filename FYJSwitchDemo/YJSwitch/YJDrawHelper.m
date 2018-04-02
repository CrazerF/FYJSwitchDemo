//
//  YJDrawHelper.m
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/11.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import "YJDrawHelper.h"

@implementation YJDrawHelper
- (void)drawCat:(CGRect)frame{
    
    CGFloat selfWidth = CGRectGetWidth(frame);
    CGFloat selfHeight = CGRectGetHeight(frame);
    
    CGFloat switchWidth = selfWidth*0.6;
    
    CGFloat switchLineX = (selfWidth-switchWidth)/2;
    CGFloat switchLineY = selfHeight/2;
    
    CGFloat ballRadius = switchWidth*31.00/187.00;
    

    self.switchLeftPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX-ballRadius, switchLineY-ballRadius, 2*ballRadius, 2*ballRadius)];
    [self.switchLeftPath closePath];
    
    self.switchMiddlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX+switchWidth/2-15,  switchLineY-ballRadius+4, 2*ballRadius+30, 2*ballRadius-8)];
    [self.switchMiddlePath closePath];
    
    self.switchRightPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX+switchWidth-ballRadius,  switchLineY-ballRadius, 2*ballRadius, 2*ballRadius)];
    [self.switchRightPath closePath];
}

- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyframeAnimation.values  = value;
    keyframeAnimation.duration = .3;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    return keyframeAnimation;
}

@end
