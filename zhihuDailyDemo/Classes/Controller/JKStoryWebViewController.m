//
//  JKStoryWebViewController.m
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/8/29.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import "JKStoryWebViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

@interface JKStoryWebViewController () <UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation JKStoryWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.title = @"返回";
    //创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    //自动适应屏幕
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    [manager GET:self.storyID parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //只需要返回数据中的“body”字段
        self.HTMLString = responseObject[@"body"];
        //去掉页面最后的“查看知乎讨论”超链接
        NSRange range = [self.HTMLString rangeOfString:@"<div class=\"view-more\""];
        if (range.length) {
            NSString *viewMoreCode = [self.HTMLString substringFromIndex:range.location];
            NSString *final = [self.HTMLString stringByReplacingOccurrencesOfString:viewMoreCode withString:@""];
            //加载HTMLString
            [self.webView loadHTMLString:final baseURL:nil];
        } else {
            //如果没有，原样加载
            NSString *final = self.HTMLString;
            [self.webView loadHTMLString:final baseURL:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
