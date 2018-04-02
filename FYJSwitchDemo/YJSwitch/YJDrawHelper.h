//
//  YJDrawHelper.h
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/11.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YJDrawHelper : NSObject

@property (nonatomic, strong) UIBezierPath *switchLinePath;

@property (nonatomic, strong) UIBezierPath *rightPath;
@property (nonatomic, strong) UIBezierPath *leftPath;

@property (nonatomic, strong) UIBezierPath *switchLeftPath;
@property (nonatomic, strong) UIBezierPath *switchMiddlePath;
@property (nonatomic, strong) UIBezierPath *switchRightPath;

- (void)drawCat:(CGRect)frame;

- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value;

@end
