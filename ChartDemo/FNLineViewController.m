//
//  FNLineViewController.m
//  ChartDemo
//
//  Created by Henry on 14-11-14.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "FNLineViewController.h"
#import "FNLineChart.h"

@interface FNLineViewController ()

@end

@implementation FNLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    FNLineChart *chart = [[FNLineChart alloc]initWithFrame:CGRectMake(0, 40, 320, 300)];
    chart.horizontalTitles = @[@"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
    chart.leftLineColors = @[[UIColor greenColor], [UIColor orangeColor]];
    chart.leftLineWidths = @[@(2), @(1.5)];
    chart.leftLineAnimationDuration = @[@(2), @3];
    chart.verticalLeftValus = @[@[@(0.1), @(3), @(0.6), @(8), @(5), @(1.3), @(4), @(0)],
                                                @[@(6), @(4), @(5), @(2), @(0), @(4), @(8), @(6)]];
        chart.verticalRightValus = @[@[@(60), @(30), @(100), @(14), @(50), @(10), @(80), @(140)]];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
