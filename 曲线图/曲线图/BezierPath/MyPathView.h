//
//  MyPathView.h
//  PathText
//
//  Created by Candy on 16/3/30.
//  Copyright © 2016年 汪汉琦. All rights reserved.
//


// 曲线图

#import <UIKit/UIKit.h>

@interface MyPathView : UIView
{
    CGFloat _duration;
}
/**
 *  值的数组
 */
@property (nonatomic,strong) NSArray *dataArr;
/**
 *  是否弯曲
 */
@property (nonatomic,assign) BOOL isCuver;
/**
 *  描边线条颜色
 */
@property (nonatomic,strong) UIColor *lineColor;
/**
 *  描边线条宽度
 */
@property (nonatomic,assign) CGFloat lineWidth;
/**
 *  渐变填充颜色
 */
@property (nonatomic,strong) NSArray *fillColors;
/**
 *  btn背景颜色
 */
@property (nonatomic,strong) UIColor *btnBackgroundColor;
/**
 *  动画持续时间
 */
@property (nonatomic,assign) CGFloat animationDuration;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,assign) int mon;


/**
 *  获取每个点的point
 *
 *  @return point数组
 */

- (NSArray *)getPointArr;
/**
 *  开始动画
 */
- (void)startAnimation;
@end
