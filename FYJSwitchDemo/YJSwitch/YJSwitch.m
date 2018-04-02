//
//  YJSwitch.m
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/11.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import "YJSwitch.h"
#import "YJDrawHelper.h"

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface YJSwitch()
{
    id _target;
    SEL _action;
    
    BOOL _switchOnStatue;
}
//渐变效果
@property (strong, nonatomic) CAGradientLayer *bgGradientLayer;

@property (strong, nonatomic) NSArray *onColorArray;

@property (strong, nonatomic) NSArray *offColorArray;

@property (strong, nonatomic) CAShapeLayer *switchBallLayer;

@property (strong, nonatomic) YJDrawHelper *helper;
@end
@implementation YJSwitch

#pragma mark - life cycle
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self  initialize];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self  initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  initialize];
    }
    return self;
}

#pragma mark - initialize
- (void) initialize
{
    _switchOnStatue = NO;
    
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    
    self.helper = [[YJDrawHelper alloc]init];
    [self.helper drawCat:self.bounds];
    
    [self.layer addSublayer:self.bgGradientLayer];
    [self.layer addSublayer:self.switchBallLayer];
}

#pragma mark - lazy load
- (CAShapeLayer *)switchBallLayer
{
    if (!_switchBallLayer) {
        _switchBallLayer = [CAShapeLayer layer];
        _switchBallLayer.frame = self.bounds;
        _switchBallLayer.lineCap = kCALineCapRound;
        _switchBallLayer.lineWidth = 4;
        _switchBallLayer.strokeColor = [UIColor whiteColor].CGColor;
        _switchBallLayer.fillColor = [UIColor whiteColor].CGColor;
        _switchBallLayer.path = self.helper.switchLeftPath.CGPath;
    }
    return _switchBallLayer;
}


- (CAGradientLayer*)bgGradientLayer
{
    if (!_bgGradientLayer) {
        _bgGradientLayer = [CAGradientLayer layer];
        _bgGradientLayer.frame = self.bounds;
        _bgGradientLayer.cornerRadius =  5;
        _bgGradientLayer.startPoint = CGPointMake(1, 0);
        _bgGradientLayer.endPoint = CGPointMake(0, 1);
        _bgGradientLayer.colors = self.onColorArray;
        _bgGradientLayer.locations = @[@(0.0f) ,@(0.5f),@(1.0f)];
    }
    
    return _bgGradientLayer;
}


- (NSArray *)onColorArray
{
    if (!_onColorArray) {
        _onColorArray = [NSArray array];
        _onColorArray = @[
                          (__bridge id)kColor(54, 185, 254, 1).CGColor,
                          (__bridge id)kColor(54, 151, 255, 1).CGColor,
                          (__bridge id)kColor(54, 112, 255, 1).CGColor
                          ];
    }
    return _onColorArray;
}

- (NSArray *)offColorArray
{
    if (!_offColorArray) {
        _offColorArray = [NSArray array];
        _offColorArray = @[
                           //末色
                           (__bridge id)kColor(233, 233, 233, 1).CGColor,
                           (__bridge id)kColor(204, 204, 204, 1).CGColor,
                           (__bridge id)kColor(130, 130, 130, 1).CGColor
                           ];
    }
    return _offColorArray;
}


#pragma mark -  override getter / setter

- (BOOL)isOn{
    
    return _switchOnStatue;
}

- (void)setOn:(BOOL)on
{
    _switchOnStatue = !on;
    
    [self switchClick];
}

#pragma mark - Hit

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //    /* 判断点击区域是否在圆内 */
    //    CGPoint point = [[touches anyObject] locationInView:self];
    //    point = [self.layer convertPoint:point toLayer:self.switchBallLayer];
    //    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.switchBallLayer.path];
    //    if ([path containsPoint:point]) {
    //
    //    }
    
    [self switchClick];
    [self sendAction:_action to:_target forEvent:event];
  
}

- (void)switchClick
{
    _switchOnStatue = !_switchOnStatue;
    NSArray *ballValue = nil;

    if (!_switchOnStatue) {
        
        self.bgGradientLayer.colors = self.offColorArray;
        
        ballValue = @[(__bridge id)self.helper.switchRightPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchLeftPath.CGPath];
    } else {
        
        self.bgGradientLayer.colors = self.onColorArray;
        
        ballValue = @[(__bridge id)self.helper.switchLeftPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchRightPath.CGPath];
    }
    
    [self.switchBallLayer addAnimation:[self.helper createKeyframeAniamtionWithValue:ballValue] forKey:@"moveAnimationKey"];
}


#pragma mark - delegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    
    
}

#pragma mark - override
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    _target  = target;
    _action = action;
}


@end
