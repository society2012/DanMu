//
//  ViewController.m
//  弹幕
//
//  Created by hupeng on 2017/7/18.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManage.h"

@interface ViewController ()


@property(nonatomic,strong)BulletManage *manage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manage = [[BulletManage alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    self.manage.generateViewBlock = ^(BulletView *view) {
        [weakSelf addBulletView:view];
    };
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(250, 100, 100, 40);
    [btn1 setTitle:@"停止" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(stopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)clickBtn{

    [self.manage start];
}


-(void)stopBtn{
    [self.manage stop];
}

-(void)addBulletView:(BulletView *)view{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(screenW, 300 + view.trajectory * 40, CGRectGetWidth(view.bounds), 30);
    [self.view addSubview:view];
    [view startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
