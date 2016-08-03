//
//  BezierBtn.m
//  PathText
//
//  Created by Candy on 16/3/30.
//  Copyright © 2016年 汪汉琦. All rights reserved.
//

#import "BezierBtn.h"

UIOffset tapOffset;

@implementation BezierBtn


+ (id)buttonWithType:(UIButtonType)buttonType tappableAreaOffset:(UIOffset)tappableAreaOffset
{
    tapOffset = tappableAreaOffset;
    return [super buttonWithType:buttonType];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return CGRectContainsPoint(CGRectInset(self.bounds, - tapOffset.horizontal, - tapOffset.vertical), point);
}

@end
