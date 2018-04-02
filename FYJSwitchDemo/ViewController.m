//
//  ViewController.m
//  FYJSwitchDemo
//
//  Created by GZHL on 2017/12/4.
//  Copyright © 2017年 fyj. All rights reserved.
//

#import "ViewController.h"

#import "YJSwitch.h"

#import "FYJSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一种
    YJSwitch *yjSwitch = [[YJSwitch alloc] initWithFrame:CGRectMake(150, 100, 100, 40)];
    yjSwitch.on = 1;
    [yjSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yjSwitch];
    
    //第二种
    FYJSwitch *fyjSwitch = [[FYJSwitch alloc] initWithFrame:CGRectMake(150, 200, 100, 40)];
    fyjSwitch.on = 1;
    [fyjSwitch addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fyjSwitch];
}


- (void)switchAction:(YJSwitch *)sender
{
    NSLog(@"yjSwitch.on = %d",sender.on);
}

- (void)action:(UIControl *)sender
{
    FYJSwitch *fyjSwitch = (FYJSwitch *)sender;
    NSLog(@"fyjSwitch.on = %d",fyjSwitch.on);
}


@end
