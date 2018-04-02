//
//  FYJSwitch.h
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/4.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYJSwitch : UIControl

@property (nonatomic, assign, getter=isOn) BOOL on;

- (void)switchClick;

@end
