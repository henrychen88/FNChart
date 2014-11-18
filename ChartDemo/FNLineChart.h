//
//  FNLineChart.h
//  ChartDemo
//
//  Created by Henry on 14-11-14.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNLineChart : UIView

//图表离边框上下左右的距离
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat bottomtMargin;

//数据量
@property (nonatomic, assign) int verticalLeftStep;
@property (nonatomic, assign) int verticalRightStep;
@property (nonatomic, assign) int horizontalStep;

@property (nonatomic, assign) CGFloat axisLineWidth;
@property (nonatomic, strong) UIColor *axisLineColor;

@property (nonatomic, assign) CGFloat innerLineWidth;
@property (nonatomic, strong) UIColor *innerLineColor;

//是否画内部线条
@property (nonatomic) BOOL drawInnerVerticalLine;
@property (nonatomic) BOOL drawInnerHorizontalLine;

//数值以左边Y轴为准的线条相关属性
@property (nonatomic, strong) NSArray *leftLineColors;//线条颜色 UIColor 对象
@property (nonatomic, strong) NSArray *leftLineWidths;//线条宽度 CGFloat 类型
@property (nonatomic, strong) NSArray *leftLineAnimationDuration;//线条动画时间 CGFloat类型

//数值以右边Y轴为准的线条相关属性
@property (nonatomic, strong) NSArray *rightLineColors;//线条颜色 UIColor 对象
@property (nonatomic, strong) NSArray *rightLineWidths;//线条宽度 CGFloat 类型
@property (nonatomic, strong) NSArray *rightLineAnimationDuration;//线条动画时间 CGFloat类型

@property (nonatomic, strong) NSArray *horizontalTitles;
@property (nonatomic, strong) NSArray *verticalLeftValus;
@property (nonatomic, strong) NSArray *verticalRightValus;

@end
