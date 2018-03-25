//
//  WebViewController.m
//  PsychicLoan
//
//  Created by 高扬 on 17/11/18.
//  Copyright © 2017年 GaoYang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController()

@property(nonatomic,retain)WKWebView* webView;
//@property(nonatomic,retain)UIProgressView* progressView;

@end

@implementation WebViewController

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        _webView.scrollView.bounces = false;
//        __weak __typeof(self) weakSelf = self;
//        [[_webView rac_valuesAndChangesForKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew observer:nil]subscribeNext:^(id x) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            strongSelf.progressView.hidden = strongSelf->_webView.estimatedProgress == 1;
//            [strongSelf.progressView setProgress:strongSelf->_webView.estimatedProgress animated:YES];
//        }];
        [self.view addSubview:_webView];
    }
    return _webView;
}

//-(UIProgressView *)progressView{
//    if (!_progressView) {
//        _progressView = [[UIProgressView alloc]init];
//        [self.view addSubview:_progressView];
//    }
//    return _progressView;
//}

-(void)viewDidLayoutSubviews{
    self.webView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
//    self.progressView.frame = CGRectMake(0, 0, self.view.width, 3);
}

-(void)popToPrevController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = self.navigationTitle;

    self.webView.frame = self.view.bounds;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
}

@end
