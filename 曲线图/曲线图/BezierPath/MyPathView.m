//
//  MyPathView.m
//  PathText
//
//  Created by Candy on 16/3/30.
//  Copyright © 2016年 汪汉琦. All rights reserved.
//

#import "MyPathView.h"
#import "UIView+Frame.h"
#import "BezierBtn.h"
#import "BezierDetailView.h"
#import "UIBezierPath+curved.h"
#import "UILabel+Extension.h"

@interface MyPathView ()
{
    /**
     *  CAGradientLayer可以方便的处理颜色渐变。
     */
    CAGradientLayer *_gradient;
    /**
     *  点击出现的先线
     */
    CAShapeLayer *_lineLayer;
    /**
     *  btn_Tag
     */
    NSInteger _currentTag;
    
    
}

/**
 *  btnArr
 */
@property (nonatomic,strong) NSMutableArray *buttonsArr;
/**
 *  labelArr
 */
@property (nonatomic,strong) NSMutableArray *labelArr;

@property (nonatomic,strong) BezierDetailView *detailView;
/**
 *  pointArr
 */
@property (nonatomic,strong) NSMutableArray *pointsArr;

@end

@implementation MyPathView

+ (Class)layerClass
{
    return  [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.buttonsArr = [NSMutableArray array];
        self.labelArr = [NSMutableArray array];
        
        _detailView = [[BezierDetailView alloc]initWithFrame:(CGRectMake(0, 0, 80, 30))];
        _detailView.textColor = [UIColor whiteColor];
        _lineLayer = [[CAShapeLayer alloc]init];

        self.pointsArr = [NSMutableArray array];
        
        [self setNeedsDisplay];
        
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    ((CAShapeLayer *)self.layer).fillColor   = [UIColor clearColor].CGColor;
    ((CAShapeLayer *)self.layer).strokeColor = self.lineColor.CGColor;
    ((CAShapeLayer *)self.layer).lineWidth   = self.lineWidth;
    ((CAShapeLayer *)self.layer).path        = [self graphPathFromPoints].CGPath;

}

/**
 *
 *
 *  @return 贝塞尔曲线
 */
- (UIBezierPath *)graphPathFromPoints
{
    // 是否填充
    BOOL fill = self.fillColors.count;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (UIButton *btn in self.buttonsArr)
    {
        [btn removeFromSuperview];
    }
    for (UILabel *label in self.labelArr) {
        [label removeFromSuperview];
    }
    
    for (int i = 0; i< self.dataArr.count; i++)
    {
        // 获取dataArr的每个对象的位置
        CGPoint point = [self pointAtIndex:i];
        // 加入每个point
        [self.pointsArr addObject:[NSValue valueWithCGPoint:point]];
        
        if (i == 0)
        {
            [path moveToPoint:point];
        }
        BezierBtn *btn = [BezierBtn buttonWithType:(UIButtonTypeCustom) tappableAreaOffset:(UIOffsetMake(25, 25))];
        btn.backgroundColor = self.btnBackgroundColor;
        btn.frame = CGRectMake(0, 0, 10, 10);
        btn.center = point;
        btn.layer.cornerRadius = btn.width / 2;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = self.btnBackgroundColor.CGColor;
        btn.tag = 2000 + i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
        
        CGFloat space = self.width / self.dataArr.count;
        CGFloat xSpace =(self.width - 2 *space) / self.dataArr.count;
        
#pragma Mark-- 点
        if ([self.type intValue]== 0)
        {
            if (i % 6 == 0)
            {
                UILabel *label = [UILabel initWithFrame:(CGRectMake(point.x + 45, self.height + 10, xSpace * 6, 20)) font:14 color:[UIColor whiteColor] text:[NSString stringWithFormat:@"%d:00",i / 6]];
                label.centerX = point.x + 40;
//                [self addSubview:label];
                [self.labelArr addObject:label];
            }
        }
        
        if ([self.type intValue]== 1)
        {
            if (i % 12 == 0)
            {
                if ((i /12 ) % 2 == 0) {
                    
                    UILabel *label = [UILabel initWithFrame:(CGRectMake(point.x + 45, self.height + 10, xSpace *6, 20)) font:14 color:[UIColor whiteColor] text:[NSString stringWithFormat:@"Day%d 00:00",(i / 24) + 1]];
                    label.centerX = point.x + 40;
                    [self addSubview:label];
                    [self.labelArr addObject:label];
                }else
                {
                    UILabel *label = [UILabel initWithFrame:(CGRectMake(point.x + 45, self.height + 10, xSpace *6, 20)) font:14 color:[UIColor whiteColor] text:[NSString stringWithFormat:@"Day%d 12:00",(i / 24) + 1]];
                    label.centerX = point.x + 40;
                    [self addSubview:label];
                    [self.labelArr addObject:label];

                }
            }
        }
        
        if ([self.type intValue] == 2)
        {
            if (i % 8 == 0)
            {
                UILabel *label = [UILabel initWithFrame:(CGRectMake(point.x + 45, self.height + 10, xSpace * 6, 20)) font:14 color:[UIColor whiteColor] text:[NSString stringWithFormat:@"%d-%d ",self.mon,(i / 8)+1]];
                label.centerX = point.x + 40;
                [self addSubview:label];
                [self.labelArr addObject:label];
            }
        }
        /**
         *   添加每个按钮到数组中
         */
        [self.buttonsArr addObject:btn];
        
        /**
         *  绘制曲线
         */
        [path addLineToPoint:point];
    }
    
    /**
     *  设置弯曲
     */
    if (self.isCuver)
    {
        path = [path smoothedPathWithGranularity:20];
    }
    if (fill)
    {
        CGPoint last = [self pointAtIndex:self.dataArr.count - 1];
        CGPoint first = [self pointAtIndex:0];
        
        [path addLineToPoint:CGPointMake(last.x + self.lineWidth,self.height - self.lineWidth)];
        [path addLineToPoint:CGPointMake(first.x + self.lineWidth ,self.height - self.lineWidth)];
        [path addLineToPoint:first];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.strokeColor = self.lineColor.CGColor;
        maskLayer.path = path.CGPath;
        maskLayer.fillColor = [UIColor whiteColor].CGColor
        ;
        _gradient.mask = maskLayer;
        
    }
    /*
     *  循环创建虚线
     */
    for (int i = 0; i < 6; i ++)
    {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.frame = self.bounds;
        [line setFillColor:[UIColor clearColor].CGColor];
        [line setStrokeColor:[UIColor whiteColor].CGColor];
        [line setLineWidth:1.0f];
        [line setLineJoin:kCALineJoinMiter];
        NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [line setLineDashPattern:arr];
        
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:(CGPointMake(0, self.height / 4 * i ))];
        [path1 addLineToPoint:(CGPointMake(self.width, self.height / 4 *i))];
        line.path = path1.CGPath;
        [self.layer addSublayer:line];
    }
    
    
    return path;
}

#pragma mark --  点击事件
/**
 *  BezierBtn 点击事件
 *
 *  @param btn
 */
- (void)tap:(BezierBtn *)btn
{
    _currentTag = btn.tag;
    for (BezierBtn *btn in self.buttonsArr)
    {
        if (btn.tag == _currentTag)
        {
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
            
        }else
        {
            btn.layer.borderWidth = 0;
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
            
        }
    }
    [self.detailView removeFromSuperview];
    [self displayDetailViewAtPoint:CGPointMake(btn.x + 6.1, btn.y - 35)];
}

/**
 *  根据传入值的数组返回对应的point
 *
 *  @param index 下标
 *
 *  @return 返回point
 */
- (CGPoint)pointAtIndex:(NSInteger)index
{
    
    CGFloat max = 0.0;
    for (int i = 0; i < self.dataArr.count ; i++)
    {
        if ([self.dataArr[i] floatValue] > max)
        {
            max = [self.dataArr[i] floatValue];
        }
    }
    CGFloat data = [self.dataArr[index] floatValue];
    CGFloat ySpace = self.height  - ((data * self.height*0.8) / max);
    CGFloat space = self.width / self.dataArr.count;
    CGFloat xSpace =(self.width - 2 *space) / self.dataArr.count;
    CGPoint point = CGPointMake(space + xSpace * index, ySpace);
    return point;
}

/**
 *  获取每个点的point
 *
 *  @return point数组
 */

- (NSArray *)getPointArr
{
    [self setNeedsDisplay];

    return self.pointsArr.copy;
    
}


#pragma mark -- Setter 方法

/**
 *  设置填充颜色
 *
 *  @param fillColors
 */
- (void)setFillColors:(NSArray *)fillColors
{
    
    _fillColors = fillColors;
    
    [_gradient removeFromSuperlayer];
    _gradient = nil;
    
    if (fillColors.count)
    {
        
        NSMutableArray *colors=[[NSMutableArray alloc] initWithCapacity:fillColors.count];
        
        for (UIColor* color in fillColors)
        {
            if ([color isKindOfClass:[UIColor class]]) {
                [colors addObject:(id)[color CGColor]];
            }else{
                [colors addObject:(id)color];
            }
        }
        _fillColors=colors;
        
        _gradient = [CAGradientLayer layer];
        _gradient.frame = self.bounds;
        _gradient.colors = _fillColors;
        [self.layer addSublayer:_gradient];
        
    }
    {
        _fillColors = fillColors;
    }
    /**
     *  通知系统重新绘图
     */
    [self setNeedsDisplay];
    
}

#pragma mark --- 开始执行动画
- (void)startAnimation
{
    if (_detailView)
    {
        [_detailView removeFromSuperview];
        _lineLayer.hidden = YES;

    }
    _gradient.hidden = YES;
    
    ((CAShapeLayer *)self.layer).fillColor = [UIColor clearColor].CGColor;
    ((CAShapeLayer *)self.layer).strokeColor = self.lineColor.CGColor;
    ((CAShapeLayer *)self.layer).lineWidth = self.lineWidth;
    ((CAShapeLayer *)self.layer).path = [self graphPathFromPoints].CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = self.animationDuration;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"BezierPath"];
    for (BezierBtn *btn in self.buttonsArr)
    {
        [btn removeFromSuperview];
    }
    self.buttonsArr = [[NSMutableArray alloc]init];

    CGFloat delay = (CGFloat)self.animationDuration / self.dataArr.count;
    
    /**
     *  循环创建btn
     */
    for(int i = 0; i < self.dataArr.count;i++)
    {
        CGPoint point = [self pointAtIndex:i];
        
        BezierBtn *btn = [BezierBtn buttonWithType:(UIButtonTypeCustom) tappableAreaOffset:(UIOffsetMake(25, 25))];
        btn.backgroundColor = self.btnBackgroundColor;
        btn.frame = CGRectMake(0, 0, 10, 10);
        btn.center = point;
        btn.layer.cornerRadius = btn.width / 2;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = self.btnBackgroundColor.CGColor;
        btn.tag = 2000 + i;
        btn.transform = CGAffineTransformMakeTranslation(0, 0);
        [self addSubview:btn];
        [btn addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
        [self performSelector:@selector(displayBtn:) withObject:btn afterDelay:delay];
        
        [self.buttonsArr addObject:btn];
    }
    
    [self setNeedsDisplay];

}

#pragma mark --- 展示btn
- (void)displayBtn:(UIButton *)btn

{
    [UIView animateWithDuration:0.2 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(1, 1);
    }];
    
}

#pragma mark --- 动画停止

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [UIView animateWithDuration:0.2 animations:^{
    }];
    _gradient.hidden = NO;
}


#pragma mark --- detailView 展示

- (void)displayDetailViewAtPoint:(CGPoint)point
{
    self.detailView.center = point;

    // label的文字
    self.detailView.titleLB.text = [NSString stringWithFormat:@"%@", [self.dataArr objectAtIndex:_currentTag - 2000]];

    self.detailView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:.2 animations:^{
        self.detailView.transform=CGAffineTransformMakeScale(1, 1);
    }];;
    
    if (_lineLayer.hidden == YES)
    {
        _lineLayer.hidden = NO;
    }
    _lineLayer.lineWidth = 1;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.strokeColor = [UIColor colorWithWhite:0.986 alpha:1.000].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(point.x, 0)];
    [path addLineToPoint:CGPointMake(point.x, self.height)];
    _lineLayer.path = path.CGPath;

    [self.layer addSublayer:_lineLayer];
    [self addSubview:self.detailView];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BezierBtn *btn = [self viewWithTag:_currentTag];
    btn.layer.borderWidth = 0;
    if (self.detailView)
    {
        _lineLayer.hidden = YES;
        [self.detailView removeFromSuperview];
    }
}
//
//- (void)setType:(NSString *)type
//{
//    _type = type;
//    
//    [self graphPathFromPoints];
//    
//}


@end
