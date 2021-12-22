//
//  TLSecondViewController.m
//  TLTrackSDK_Example
//
//  Created by psh on 2021/12/22.
//  Copyright © 2021 panshouheng. All rights reserved.
//

#import "TLSecondViewController.h"
#import <WebKit/WebKit.h>
#import <TLTrackSDK.h>
@interface TLSecondViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *_webView;
}
@end

@implementation TLSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"第二页";
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        WKWebViewConfiguration* webViewConfig = [[WKWebViewConfiguration alloc] init];
        webViewConfig.userContentController = userContentController;
        webViewConfig.allowsInlineMediaPlayback = true;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height) configuration:webViewConfig];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.backgroundColor = [UIColor blackColor];
        _webView.opaque = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;

        _webView.opaque = NO;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://zhuanlan.zhihu.com/p/164502340"]]];
    
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{

NSError *parseError = nil;

NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

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
