//
//  FNShapeLayer.m
//  ChartDemo
//
//  Created by Henry on 14-11-14.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "FNShapeLayer.h"

#pragma mark - Custom CALayer Delegate

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

#pragma mark - -

@interface FNShapeLayer()
{
    LayerDelegate *layerDeleagte;
}

@end

@implementation FNShapeLayer

- (id)init
{
    if (self = [super init]) {
        layerDeleagte = [[LayerDelegate alloc]initWithView:self];
//        self.delegate = layerDeleagte;
        
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"xx");
}
@end
