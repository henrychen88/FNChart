//
//  JSViewController.m
//  ChartDemo
//
//  Created by Henry on 14-11-11.
//  Copyright (c) 2014年 ichint. All rights reserved.
//

#import "JSViewController.h"

@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"JS + HTML";
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    {
        UIWebView *WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 180)];
        [WebView setUserInteractionEnabled:YES];
        WebView.scalesPageToFit =YES;
        [WebView setBackgroundColor:[UIColor clearColor]];
        [WebView setOpaque:NO];//使网页透明
        
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chart_1" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [WebView loadHTMLString:html baseURL:baseURL];
        [scrollView addSubview:WebView];
    }
    
    {
        UIWebView *WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 180)];
        [WebView setUserInteractionEnabled:YES];
        WebView.scalesPageToFit =YES;
        [WebView setBackgroundColor:[UIColor clearColor]];
        [WebView setOpaque:NO];//使网页透明
        
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chart_2" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [WebView loadHTMLString:html baseURL:baseURL];
        [scrollView addSubview:WebView];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width - 20, 140)];
    label.text = @"总结：使用html调用第三方js库\n优点：IOS和安卓在界面上可以高度统一  样式多   并且包含的第三方文件只有 300KB\n缺点：图表加载没有native快";
    label.numberOfLines = 0;
    [scrollView addSubview:label];
    
    [scrollView setContentSize:CGSizeMake(label.frame.size.width, CGRectGetMaxY(label.frame))];
    
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
