//
//  ViewController.m
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "ViewController.h"

#import "JSViewController.h"
#import "FSLineViewController.h"
#import "GKLineViewController.h"
#import "CorePlotViewController.h"
#import "FNLineViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"调用JS库", @"FSLineChart", @"GKLineGraph", @"CorePlot", @"FNLineChart"];
    
    self.title = @"图表";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController;
    switch (indexPath.row) {
        case 0:
            viewController = [[JSViewController alloc]init];
            break;
        case 1:
            viewController = [[FSLineViewController alloc]init];
            break;
        case 2 :
            viewController = [[GKLineViewController alloc]init];
            break;
        case 3:
            viewController = [[CorePlotViewController alloc]init];
            break;
        case 4:
            viewController = [[FNLineViewController alloc]init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
