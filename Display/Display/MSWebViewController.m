//
//  MSWebViewController.m
//  Sword
//
//  Created by haorenjie on 16/6/21.
//  Copyright © 2016年 mjsfax. All rights reserved.
//

#import "MSWebViewController.h"
#import "MSToast.h"

@interface MSWebViewController()<UIWebViewDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) UIView *statusView;

@property (strong, nonatomic) UIWebView *webview;
@property (assign, nonatomic) BOOL authenticated;
@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) UInt64 startLoadTime;

@property (copy, nonatomic) void (^payCompletion)(void);
@end

@implementation MSWebViewController

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureElement];
}

#pragma mark - web配置userAgent

- (void)web {
    //在创建webview之前就定义好全局的userAgent
    self.webview = [[UIWebView alloc] init];//新建webview是为了获取旧的userAgent
    //navigator.userAgent: html内部东东
    NSString *secretAgent = [self.webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"webView旧的userAgent：%@",secretAgent);
    
    NSRange range = [secretAgent rangeOfString:@"mjd_cridit_native"];
    if(range.length == 0){
        NSString *newUagent = [NSString stringWithFormat:@"%@ %@",secretAgent,@"mjd_cridit_native"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:newUagent, @"UserAgent",nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];//系统级方法这之后web就带native
    }
}

#pragma mark - 加载本地html（mjd文件夹）

- (void)loadLocalHtml {
    //加载本地html文件 注意baseurl的配置，否则样式、图片由于路径错误不显示
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"mjd/html"];
    NSURL *baseUrl = [NSURL fileURLWithPath:htmlPath];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlCont baseURL:baseUrl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.url && self.url.length > 0) {
        [self loadUrl];
    }
    
    if (self.htmlContent && self.htmlContent.length > 0) {
        [self loadHtmlContent];
    }
}

- (void)dealloc {
    if (self.webview.loading) {
        self.webview.delegate = nil;
        [self.webview stopLoading];
    }
    NSLog(@"%s",__func__);
}

#pragma mark - Public
//+ (MSWebViewController *)load {
//    MSWebViewController *webVC = [[MSWebViewController alloc] init];
//    return webVC;
//}

- (void)payUrl:(NSString *)url payCompletion:(void (^)(void))payCompletion {
    self.payCompletion = payCompletion;
    self.url = url;
}

#pragma mark - StatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.payCompletion) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private

- (void)loadUrl {
    NSURL *requestUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [self.webview loadRequest:request];
}

- (void)loadHtmlContent {
    [self.webview loadHTMLString:self.htmlContent baseURL:nil];
}

- (void)configureElement {
    self.authenticated = NO;
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    self.webview.opaque = NO;
    self.webview.backgroundColor = [UIColor clearColor];
    
    if (self.payCompletion) {
        self.statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        self.statusView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.statusView];
        
    }
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    [btnBack addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)backButtonOnClick {
     [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
//    NSString *urlstr = request.URL.absoluteString;
//    NSArray  *urlArray = [urlstr componentsSeparatedByString:@"?"];
//    NSString *header = [urlArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    NSLog(@"[WebView] url: %@", urlstr);
//
//    //单项认证
//    NSString *scheme = request.URL.scheme;
//    if ([scheme isEqualToString:@"https"]
//        && self.authenticated == NO
//        && ![header containsString:@"alipay.com"]
//        && ![header containsString:@"mjsytc.minshengjf.com"]
//        && ![header containsString:@"www.mjsfax.com/h5/static/themes/default/success.html"]) {
//        self.authenticated  = NO;
//        self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        [self.urlConnection start];
//        return NO;
//    }
//
//    // h5支付完成页面回调拦截
//    if ([header isEqualToString:@"mjs://fhonlinepayresponse"]) {
//        [self backButtonOnClick];
//        return NO;
//    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    self.startLoadTime = [TimeUtils currentTimeMillis];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *url = [webView.request.URL absoluteString];
//    [MSLog verbose:[NSString stringWithFormat:@"[http_test] %@ %llu %llu",url,self.startLoadTime,[TimeUtils currentTimeMillis]]];
//    [MSProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [MSProgressHUD dismiss];
}

#pragma mark - NSURLConnection Delegate  //单项认证
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge; {
    if ([challenge previousFailureCount] == 0){
        self.authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response; {
    self.authenticated = YES;
    NSURL *requestUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [self.webview loadRequest:request];
    
    [self.urlConnection cancel];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


@end
