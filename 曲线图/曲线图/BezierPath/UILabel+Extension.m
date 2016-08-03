//
//  UILabel+Extension.m
//  Sensology
//
//  Created by Candy on 16/3/2.
//  Copyright © 2016年 汪汉琦. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)initWithFrame:(CGRect)frame font:(NSInteger)font color:(UIColor *)color text:(NSString *)text
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    label.text = text;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
    
}

@end
