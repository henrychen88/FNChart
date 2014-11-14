//
//  FSLineViewController.m
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "FSLineViewController.h"

#import "FSLineChart.h"

@interface FSLineViewController ()

@end

@implementation FSLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FSLineChart";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:[self chart1]];
    [scrollView addSubview:[self chart2]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 380, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    label.text = @"总结：使用native 实现\n优点：加载速度块 有加载动画 可配置的选项多\n缺点：只能显示一组数据";
    label.numberOfLines = 0;
    [scrollView addSubview:label];
    
    [scrollView setContentSize:CGSizeMake(label.frame.size.width, CGRectGetMaxY(label.frame))];
}

-(FSLineChart*)chart1 {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:10];
    
    //    srand(time(nil));
    
    for(int i=0;i<10;i++) {
        int r = arc4random() % 100;
        r /= 100.0;
        chartData[i] = [NSNumber numberWithInt:r];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.verticalGridStep = 5;
    lineChart.horizontalGridStep = 9;
        lineChart.fillColor = nil;
    lineChart.animationDuration = 2;
    lineChart.valueLabelPosition = ValueLabelLeft;
    //    lineChart.fillColor = [UIColor orangeColor];
    //    lineChart.drawInnerGrid = NO;
    lineChart.bezierSmoothing = NO;
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

-(FSLineChart*)chart2 {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:101];
    
    for(int i=0;i<101;i++) {
        chartData[i] = [NSNumber numberWithFloat:(float)i / 30.0f + (float)(rand() % 100) / 200.0f];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 196, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.verticalGridStep = 4;
    lineChart.horizontalGridStep = 2;
    lineChart.color = [UIColor orangeColor];
    lineChart.fillColor = nil;
    lineChart.drawInnerGrid = NO;
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu%%",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f €", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}


@end
