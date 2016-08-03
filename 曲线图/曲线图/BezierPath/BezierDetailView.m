//
//  BezierDetailView.m
//  BezierText2
//
//  Created by Candy on 16/3/31.
//  Copyright © 2016年 汪汉琦. All rights reserved.
//

#import "BezierDetailView.h"
#import "UIView+Frame.h"

@implementation BezierDetailView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.width,self.height))];
    imageV.image =[UIImage imageNamed:@"P05_2_History_Week_bubble"];
    [self addSubview:imageV];
    
    self.titleLB=[[UILabel alloc] initWithFrame:CGRectMake(0, imageV.height *0.1, imageV.width, imageV.height * 0.8)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor =  [UIColor whiteColor];
    self.titleLB.adjustsFontSizeToFitWidth = YES;
//    self.titleLB.font = [UIFont systemFontOfSize:14];
    self.titleLB.clipsToBounds=YES;
    [imageV addSubview:self.titleLB];
    
    self.detailLB=[[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLB.height + self.titleLB.y + self.height *0.05, imageV.width, imageV.height * 0.3)];
    self.detailLB.textAlignment=NSTextAlignmentCenter;
    self.detailLB.textColor =  [UIColor whiteColor];
//    self.detailLB.font = [UIFont systemFontOfSize:14];
    self.detailLB.adjustsFontSizeToFitWidth = YES;
    self.detailLB.clipsToBounds=YES;
//    [imageV addSubview:self.detailLB];
    
}




@end
