//
//  FYJSwitch.m
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/4.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import "FYJSwitch.h"
#import "FYJDrawHelper.h"

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface FYJSwitch ()
{
    id _target;
    SEL _action;
    
    BOOL _switchOnStatue;
}
@property (strong, nonatomic) NSArray *onColorArray;

@property (strong, nonatomic) NSArray *offColorArray;

@property (strong, nonatomic) CAShapeLayer *switchLineLayer;

@property (strong, nonatomic) CAShapeLayer *switchBallLayer;

@property (strong, nonatomic) FYJDrawHelper *helper;

@end
@implementation FYJSwitch
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
    
    self.helper = [[FYJDrawHelper alloc]init];
    [self.helper drawCat:self.bounds];
    
    [self.layer addSublayer:self.switchLineLayer];
    [self.layer addSublayer:self.switchBallLayer];
}

#pragma mark - lazy load
- (CAShapeLayer *)switchLineLayer
{
    if (!_switchLineLayer) {
        _switchLineLayer = [CAShapeLayer layer];
        _switchLineLayer.frame = [self bounds];
        _switchLineLayer.lineJoin = kCALineJoinRound;
        _switchLineLayer.lineWidth = 4;
        _switchLineLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _switchLineLayer.fillColor = [UIColor lightGrayColor].CGColor;
        _switchLineLayer.path = self.helper.switchLinePath.CGPath;
    }
    return _switchLineLayer;
}

- (CAShapeLayer *)switchBallLayer
{
    if (!_switchBallLayer) {
        _switchBallLayer = [CAShapeLayer layer];
        _switchBallLayer.frame = [self bounds];
        _switchBallLayer.lineCap = kCALineCapRound;
        _switchBallLayer.lineJoin = kCALineJoinRound;
        _switchBallLayer.lineWidth = 4;
        _switchBallLayer.strokeColor = [UIColor whiteColor].CGColor;
        _switchBallLayer.fillColor = [UIColor whiteColor].CGColor;
        _switchBallLayer.path = self.helper.switchLeftPath.CGPath;
    }
    return _switchBallLayer;
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
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

- (void)switchClick{
    
    _switchOnStatue = !_switchOnStatue;
    NSArray *ballValue = nil;
    CGColorRef onColor = kColor(54, 151, 255, 1).CGColor;
    CGColorRef offColor = kColor(204, 204, 204, 1).CGColor;
    
    if (!_switchOnStatue) {
        
        self.switchLineLayer.strokeColor = offColor;
        
        ballValue = @[(__bridge id)self.helper.switchRightPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchLeftPath.CGPath];
    } else {
        
        self.switchLineLayer.strokeColor = onColor;
        
        ballValue = @[(__bridge id)self.helper.switchLeftPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchRightPath.CGPath];
    }
    
    [self.switchBallLayer addAnimation:[self.helper createKeyframeAniamtionWithValue:ballValue] forKey:@"moveAnimationKey"];
}


#pragma mark - delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag{
    
    
}

#pragma mark - override

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    _target  = target;
    _action = action;
}


@end
