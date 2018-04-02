//
//  YJSwitch.h
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/11.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJSwitch : UIControl
@property (nonatomic, assign, getter=isOn) BOOL on;

- (void)switchClick;

@end
