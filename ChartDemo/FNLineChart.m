//
//  FNLineChart.m
//  ChartDemo
//
//  Created by Henry on 14-11-14.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "FNLineChart.h"
#import "FNShapeLayer.h"

#pragma mark - Custom CALayer Delegate
/*
@interface LayerDelegate : NSObject
{
    id _target;
}
- (id) initWithView:(id)target;
@end

@implementation LayerDelegate

- (id) initWithView:(id)target
{
    self = [super init];
    if (self) {
        _target = target;
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    [_target drawLayer:layer inContext:ctx];
}

@end
 */

@interface FNLineChart ()
{
//    LayerDelegate *layerDelegate;
}
@property (nonatomic, assign) CGFloat chartHeight;
@property (nonatomic, assign) CGFloat chartWidth;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) NSMutableArray *layerArray;
@end

@implementation FNLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setDefaultParameters];
    }
    return self;
}

- (void)setDefaultParameters
{
    _leftMargin = 25;
    _rightMargin = 15;
    _topMargin = 5;
    _bottomtMargin = 15;
    _hasTwoVerticalAxis = NO;
    _axisLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _innerLineColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    _drawInnerHorizontalLine = YES;
    _drawInnerVerticalLine = YES;
    
    _innerLineWidth = 0.5;
    _axisLineWidth = 1;
    
    _verticalLeftStep = 8;
    _horizontalStep = 10;
    
    _chartHeight = CGRectGetHeight(self.bounds) - _topMargin - _bottomtMargin;
    _chartWidth = CGRectGetWidth(self.bounds) - _leftMargin - _rightMargin;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawLineChart];
}

- (void)drawLineChart
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, _leftMargin, _topMargin);
    CGContextAddLineToPoint(ctx, _leftMargin, _topMargin + _chartHeight);
    CGContextAddLineToPoint(ctx, _leftMargin + _chartWidth, _topMargin + _chartHeight);
    CGContextSetStrokeColorWithColor(ctx, _axisLineColor.CGColor);
    CGContextSetLineWidth(ctx, _axisLineWidth);
    CGContextStrokePath(ctx);
    
    if (_drawInnerVerticalLine) {
        CGFloat lineGap = _chartWidth / (_horizontalStep - 1);
        CGFloat startX = _leftMargin + lineGap;
        CGContextSetStrokeColorWithColor(ctx, _innerLineColor.CGColor);
        for (int i = 1; i < _horizontalStep; i++) {
            CGContextMoveToPoint(ctx, startX, _topMargin);
            CGContextAddLineToPoint(ctx, startX, _topMargin + _chartHeight);
            CGContextSetLineWidth(ctx, _innerLineWidth);
            CGContextStrokePath(ctx);
            startX += lineGap;
        }
    }
    
    if (_drawInnerHorizontalLine) {
        CGFloat lineGap = _chartHeight / (_verticalLeftStep);
        CGFloat startY = _topMargin;
        CGContextSetStrokeColorWithColor(ctx, _innerLineColor.CGColor);
        for (int i = 0; i < _verticalLeftStep; i++) {
            CGContextMoveToPoint(ctx, _leftMargin, startY);
            CGContextAddLineToPoint(ctx, _leftMargin + _chartWidth, startY);
            CGContextSetLineWidth(ctx, _innerLineWidth);
            CGContextStrokePath(ctx);
            startY += lineGap;
        }
    }
    
    if (!_layerArray) {
        _layerArray = [[NSMutableArray alloc]init];
    }else{
        [_layerArray removeAllObjects];
    }
    
    

    
    for (int j = 0; j < _verticalLeftValus.count; j++) {
        UIBezierPath* path = [UIBezierPath bezierPath];
        NSArray *array = _verticalLeftValus[j];
        for (int i = 0; i < array.count; i++) {
            CGFloat value = [array[i] floatValue];
            CGPoint point = CGPointMake(_leftMargin + i * (_chartWidth / (_horizontalStep - 1)), CGRectGetHeight(self.bounds) - _bottomtMargin - value * _scale);
            if (i > 0) {
                [path addLineToPoint:point];
            }else{
                [path moveToPoint:point];
            }
//            [path addArcWithCenter:point radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        }
        
        UIColor *color = _leftLineColors[j];
        color = (color ? color : [UIColor blackColor]);
        CGFloat width = [_leftLineWidths[j] floatValue];
        width = (width == 0 ? 2 : width);
        CGFloat duration = [_leftLineAnimationDuration[j] floatValue];
        duration = (duration == 0 ? 2 : duration);
        
        
//        layerDelegate = [[LayerDelegate alloc]initWithView:self];
        
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.backgroundColor = [UIColor clearColor].CGColor;
        pathLayer.frame = self.bounds;
        pathLayer.bounds = self.bounds;
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = color.CGColor;
        pathLayer.fillColor = [UIColor clearColor].CGColor;
//        pathLayer.fillRule = kCAFillRuleNonZero;
        pathLayer.lineWidth = width;
//        pathLayer.delegate = layerDelegate;
        pathLayer.lineJoin = kCALineJoinRound;
        pathLayer.lineCap = kCALineCapRound;
        
        [_layerArray addObject:pathLayer];
        [self.layer addSublayer:pathLayer];
        
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = duration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"path"];
        
        
//        CGContextStrokePath(ctx);
    }
    
    /*
    for (int j = 0; j < _verticalLeftValus.count; j++) {
        NSArray * array = [_verticalLeftValus objectAtIndex:j];
        for (int i = 0; i < array.count; i++) {
            CGFloat value = [array[i] floatValue];
            CGPoint point = CGPointMake(_leftMargin + i * (_chartWidth / (_horizontalStep - 1)), CGRectGetHeight(self.bounds) - _bottomtMargin - value * _scale);
            
            CGContextAddArc(ctx, point.x, point.y, 2, 0, M_PI * 2, YES);
            CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
            CGContextFillPath(ctx);
        }
    }
     */
}

- (void)setHorizontalTitles:(NSArray *)horizontalTitles
{
    _horizontalTitles = horizontalTitles;
    _horizontalStep = horizontalTitles.count;
    [self setNeedsDisplay];
    
    CGFloat gap = _chartWidth / (horizontalTitles.count - 1);
    CGFloat originX = _leftMargin - gap / 2.0;
    CGFloat originY = CGRectGetHeight(self.bounds) - _bottomtMargin;
    for (int i = 0; i < horizontalTitles.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(originX, originY, gap, _bottomtMargin)];
        label.text = horizontalTitles[i];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        originX += gap;
    }
}

- (void)setVerticalLeftValus:(NSArray *)verticalLeftValus
{
    _verticalLeftValus = verticalLeftValus;
    
    CGFloat max = -MAXFLOAT;
    for (NSArray *array in verticalLeftValus) {
        for (NSNumber *number in array) {
            CGFloat value = number.floatValue;
            if (value > max) {
                max = value;
            }
        }
    }
    
    if (max >= _verticalLeftStep) {
        max = ceilf(max / _verticalLeftStep) * _verticalLeftStep;
    }else if (max > 1){
        NSInteger temp = (NSInteger)(floor(_verticalLeftStep / ceilf(max)));
        max = _verticalLeftStep * 1.0f / temp;
    }else{
        NSInteger temp = max * 10;
        if (temp >= _verticalLeftStep) {
            temp = ceilf(temp * 1.0f / _verticalLeftStep) * _verticalLeftStep;
        }else{
            NSInteger t = (NSInteger)(floor(_verticalLeftStep / temp));
            temp = _verticalLeftStep / t;
        }
        max = temp / 10.0;
    }
    
    CGFloat gap = max / _verticalLeftStep;
    CGFloat originY = _topMargin + _chartHeight - 10;
    for (int i = 0; i <= _verticalLeftStep; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, _leftMargin - 2, 15)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:10];
        label.text = [NSString stringWithFormat:@"%g", i * gap];
        [self addSubview:label];
        originY -= (_chartHeight / (_verticalLeftStep));
    }
    
    _scale = _chartHeight / max;
    
    [self setNeedsDisplay];

}

/*
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    
 
}
*/
 


@end
