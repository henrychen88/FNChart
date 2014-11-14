//
//  CorePlotViewController.h
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
@interface CorePlotViewController : UIViewController<CPTPlotDataSource>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    NSMutableArray              *dataForPlot1;      //坐标数组
    NSTimer                     *timer1;            //定时器
    int                         j;
    int                         r;
    
}
@property (retain, nonatomic) NSMutableArray *dataForPlot1;
@end
