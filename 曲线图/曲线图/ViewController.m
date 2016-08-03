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
}

- (void)setUI
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:(self.view.bounds)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.144 green:0.939 blue:0.870 alpha:1.000];
    [self.view addSubview:self.scrollView];
    

    {
        self.scrollView.contentSize = CGSizeMake(self.view.width * 1.5, 0);
    }
    
    self.pathView = [[MyPathView alloc]initWithFrame:(CGRectMake(0, self.view.height * 0.07, self.scrollView.contentSize.width, self.view.height *0.8 - 30))]  ;
    self.pathView.lineColor = [UIColor whiteColor];
    self.pathView.lineWidth = 3;
    self.pathView.fillColors = @[[UIColor colorWithRed:0.144 green:0.939 blue:0.870 alpha:1.000],[UIColor colorWithRed:0.587 green:0.939 blue:0.028 alpha:1.000],[UIColor colorWithRed:1.000 green:0.454 blue:0.741 alpha:1.000]];
    self.pathView.btnBackgroundColor = [UIColor colorWithRed:0.358 green:0.473 blue:0.832 alpha:1.000];
    self.pathView.animationDuration = 1.5;
    self.pathView.isCuver = NO;
    self.pathView.type = @"0";
    [self.scrollView addSubview:self.pathView];
    self.pathView.dataArr = @[@1,@2,@3,@1.5,@0.5,@7.8,@1.5,@6.6,@2.2,@1.0,@3.3,@15,@4,@5,@6,@1,@2.8,@7,@6.5,@3.5,@5.8];
    [self.pathView startAnimation];
    
}


@end
