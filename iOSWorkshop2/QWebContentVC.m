//
//  QWebContentVC.m
//  iOSWorkshop2
//
//  Created by Pedro Ontiveros on 6/3/16.
//  Copyright © 2016 Pedro Ontiveros. All rights reserved.
//

#import "QWebContentVC.h"

@interface QWebContentVC ()

@end

@implementation QWebContentVC

- (void)awakeFromNib {
    self.title = @"Web Content";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (NSClassFromString(@"WKWebView")) {
        
//        NSError  *error = nil;
//        NSString  *path = [[NSBundle mainBundle] pathForResource: @"ScriptWebView" ofType: @"js"];
//        NSString *scriptFromFile = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//        
//        NSString *script = @"function onClickButton() { window.webkit.messageHandlers.Observe.postMessage('Message from web'); console.log('click here... working!');}";
//        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        WKUserScript *scriptCamera = [[WKUserScript alloc] initWithSource:scriptFromFile injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *userController  = [[WKUserContentController alloc] init];
        WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
        
//        [userController addUserScript:userScript];
//        [userController addUserScript:scriptCamera];
        [userController addScriptMessageHandler:self name:@"Observe"];
        [webConfiguration setUserContentController:userController];
        
         WKWebView *web = [[WKWebView alloc] initWithFrame:[[self view] bounds] configuration:webConfiguration];
//        WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(0,0,500,400) configuration:webConfiguration];
        
//        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/webkitapp"]]];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.amd.com"]]];
        [web setUserInteractionEnabled:YES];
//        [web setUIDelegate:self];
        self.webView = web;
    }
    
    [self.view addSubview:self.webView];
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

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
   forNavigationAction:(WKNavigationAction *)navigationAction
        windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    NSLog(@"You're here, please check it out!");
    
    return webView;
}

#pragma mark - UserContentController
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"Observe"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:message.body preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
