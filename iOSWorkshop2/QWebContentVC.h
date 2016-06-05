//
//  QWebContentVC.h
//  iOSWorkshop2
//
//  Created by Pedro Ontiveros on 6/3/16.
//  Copyright © 2016 Pedro Ontiveros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface QWebContentVC : UIViewController<WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

@property(nonatomic, retain)UIView *webView;

@end
