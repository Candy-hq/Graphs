//
//  ViewController.m
//  曲线图
//
//  Created by Netho on 16/8/3.
//  Copyright © 2016年 whq. All rights reserved.
//

#import "ViewController.h"
#import "MyPathView.h"
#import "UIView+Frame.h"

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) MyPathView *pathView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(200, 80, 100, 30);
    [btn setTitle:@"开始动画" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(start:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)start:(UIButton *)btn
{
    [self.pathView startAnimation];

}




- (void)setUI
{
    // 底部
    self.scrollView = [[UIScrollView alloc]initWithFrame:(self.view.bounds)];
    // 背景色
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.144 green:0.939 blue:0.870 alpha:1.000];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width * 1.5, 0);
    // 图表的视图
    self.pathView = [[MyPathView alloc]initWithFrame:(CGRectMake(0, self.view.height * 0.07, self.scrollView.contentSize.width - 30, self.view.height *0.8 - 30))]  ;
    // 线条颜色
    self.pathView.lineColor = [UIColor whiteColor];
    // 线宽
    self.pathView.lineWidth = 3;
    // 填充色
    self.pathView.fillColors = @[[UIColor colorWithRed:0.144 green:0.939 blue:0.870 alpha:1.000],[UIColor colorWithRed:0.587 green:0.939 blue:0.028 alpha:1.000],[UIColor colorWithRed:1.000 green:0.454 blue:0.741 alpha:1.000]];
    // 按钮颜色
    self.pathView.btnBackgroundColor = [UIColor whiteColor];
    // 动画时间
    self.pathView.animationDuration = 1.5;
    // 是否是曲线
    self.pathView.isCuver = NO;
    [self.scrollView addSubview:self.pathView];
    // 数据源
    self.pathView.dataArr = @[@1,@2,@3,@4,@5,@5,@6.6,@7,@8.8,@9.4];
    // 立即开始动画
    [self.pathView startAnimation];
    
}


@end
