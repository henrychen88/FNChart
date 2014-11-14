//
//  GKLineViewController.h
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GKLineGraph.h"

@interface GKLineViewController : UIViewController<GKLineGraphDataSource>

@property (nonatomic, strong) IBOutlet GKLineGraph *graph;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;

- (IBAction)onButtonDraw:(id)sender;
- (IBAction)onButtonReset:(id)sender;

@end
