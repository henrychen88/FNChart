//
//  CorePlotViewController.m
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "CorePlotViewController.h"

@interface CorePlotViewController ()

@end

@implementation CorePlotViewController
@synthesize dataForPlot1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    graph = [[CPTXYGraph alloc] initWithFrame:scrollView.bounds];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(scrollView.frame), [UIScreen mainScreen].bounds.size.width - 20, 100)];
    label.text = @"总结：使用 goole的静态库 实现\n优点：功能强大 专业\n缺点：需要添加到项目中的文件较大(5M) 并且 不能抽取某一个种图表的文件";
    label.numberOfLines = 0;
    [scrollView addSubview:label];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, CGRectGetMaxY(label.frame))];
    
    //给画板添加一个主题
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [graph applyTheme:theme];
    
    //创建主画板视图添加画板
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:scrollView.bounds];
    hostingView.hostedGraph = graph;
    
    [scrollView addSubview:hostingView];
    
    //设置留白
    graph.paddingLeft = 0;
    graph.paddingTop = 0;
    graph.paddingRight = 0;
    graph.paddingBottom = 0;
    
    graph.plotAreaFrame.paddingLeft = 45.0 ;
    graph.plotAreaFrame.paddingTop = 40.0 ;
    graph.plotAreaFrame.paddingRight = 5.0 ;
    graph.plotAreaFrame.paddingBottom = 80.0 ;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(200.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(200.0)];
    
    //设置坐标刻度大小
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) graph.axisSet ;
    CPTXYAxis *x = axisSet.xAxis ;
    x. minorTickLineStyle = nil ;
    // 大刻度线间距： 50 单位
    x. majorIntervalLength = CPTDecimalFromString (@"50");
    // 坐标原点： 0
    x. orthogonalCoordinateDecimal = CPTDecimalFromString ( @"0" );
    
    CPTXYAxis *y = axisSet.yAxis ;
    //y 轴：不显示小刻度线
    y. minorTickLineStyle = nil ;
    // 大刻度线间距： 50 单位
    y. majorIntervalLength = CPTDecimalFromString ( @"30" );
    // 坐标原点： 0
    y. orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
    
    //创建绿色区域
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = @"Green Plot";
    
    //设置绿色区域边框的样式
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 1.f;
    lineStyle.lineColor = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    //设置透明实现添加动画
    dataSourceLinePlot.opacity = 0.0f;
    
    //设置数据元代理
    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];
    
    // 创建一个颜色渐变：从 建变色 1 渐变到 无色
    CPTGradient *areaGradient = [ CPTGradient gradientWithBeginningColor :[CPTColor greenColor] endingColor :[CPTColor colorWithComponentRed:0.65 green:0.65 blue:0.16 alpha:0.2]];
    // 渐变角度： -90 度（顺时针旋转）
    areaGradient.angle = -90.0f ;
    // 创建一个颜色填充：以颜色渐变进行填充
    CPTFill *areaGradientFill = [ CPTFill fillWithGradient :areaGradient];
    // 为图形设置渐变区
    dataSourceLinePlot. areaFill = areaGradientFill;
    dataSourceLinePlot. areaBaseValue = CPTDecimalFromString ( @"0.0" );
    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationLinear ;
    
    
    dataForPlot1 = [[NSMutableArray alloc] init];
    j = 200;
    r = 0;
    timer1 = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(dataOpt) userInfo:nil repeats:YES];
    [timer1 fire];
    
}
- (void) dataOpt
{
    //添加随机数
    if ([dataSourceLinePlot.identifier isEqual:@"Green Plot"]) {
        NSString *xp = [NSString stringWithFormat:@"%d",j];
        NSString *yp = [NSString stringWithFormat:@"%d",(rand()%100)];
        NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
        [dataForPlot1 insertObject:point1 atIndex:0];
    }
    //刷新画板
    [graph reloadData];
    j = j + 20;
    r = r + 20;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - dataSourceOpt

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [dataForPlot1 count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num;
    //让视图偏移
    if ( [(NSString *)plot.identifier isEqualToString:@"Green Plot"] ) {
        num = [[dataForPlot1 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = [NSNumber numberWithDouble:[num doubleValue] - r];
        }
    }
    //添加动画效果
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration = 1.0f;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    fadeInAnimation.toValue = [NSNumber numberWithFloat:2.0];
    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    return num;
}

@end
