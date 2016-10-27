//
//  WQWebViewController.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/20.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "WQWebViewController.h"
#import "WQBaseNet.h"
@interface WQWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UIProgressView * progress;
@property(nonatomic,strong)NSTimer * progressTime;
@end

@implementation WQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 65, ViewWidth, 5)];
    _progress.progressTintColor = [UIColor greenColor];
    _progress.trackTintColor = [UIColor whiteColor];
    _progress.progress = 0;
    [self.view addSubview:_progress];
    

    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 70,ViewWidth , ViewHight-70)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestWebUrl]];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12, 20)];
    [backBtn setImage:[UIImage imageNamed:@"BackBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    _progressTime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
   }
-(void)backBtn
{
    if(_webView.canGoBack == YES)
    {
        [_webView goBack];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)changeProgress
{
    self.progress.progress +=0.3;
    if(self.progress.progress == 1)
    {
        [_progressTime setFireDate:[NSDate distantFuture]];
        self.progress.hidden = YES;
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progressTime setFireDate:[NSDate distantPast]];
    self.progress.hidden = NO;
    self.progress.progress = 0;
    NSLog(@"开始请求");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    NSLog(@"请求失败");
}
-(void)dealloc
{
    [self.progressTime invalidate];
    self.progressTime = nil;
}
@end
