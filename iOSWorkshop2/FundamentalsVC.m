//
//  FirstViewController.m
//  iOSWorkshop2
//
//  Created by Pedro Ontiveros on 5/30/16.
//  Copyright © 2016 Pedro Ontiveros. All rights reserved.
//

#import "FundamentalsVC.h"
#import "PageControlVC.h"
#import "QBarCodeReaderVC.h"
#import "QWebContentVC.h"

const NSString *openCamera        = @"openCamera";
const NSString *openWebView       = @"openWebView";
const NSString *openSafari        = @"openSafari";
const NSString *openNavController = @"openNavController";
const NSString *openPageControl   = @"openPageControl";
const NSString *openBarCodeReader = @"openBarCodeReader";

@interface FundamentalsVC ()

@property (nonatomic, retain) NSMutableDictionary *items;

@end

@implementation FundamentalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Fundamentals";
    
    self.items = [[NSMutableDictionary alloc] init];
    [self.items setObject:@"Open Camera" forKey:openCamera];
    [self.items setObject:@"Open WebView" forKey:openWebView];
    [self.items setObject:@"Open Safari" forKey:openSafari];
    [self.items setObject:@"Navigation Controller" forKey:openNavController];
    [self.items setObject:@"Page Control" forKey:openPageControl];
    [self.items setObject:@"ZBarSDK - Bar Code Reader" forKey:openBarCodeReader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString    *key = [[self.items allKeys] objectAtIndex:indexPath.row];
    NSString *title  = [self.items objectForKey:key];
    [cell.textLabel setText:title];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        NSString *strSelector = (NSString*)[[self.items allKeys] objectAtIndex:indexPath.row];
        
        SEL signatureSel = NSSelectorFromString(strSelector);
        
        if ([self respondsToSelector:signatureSel]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:signatureSel]];
            
            [invocation setTarget:self];
            [invocation setSelector:signatureSel];
            [invocation invoke];
            
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"This functionality is not implemented!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction    *action = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } @catch (NSException *err) {
        NSLog(@"An error has occurred :%@", [err description]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:[err description] delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Invocations
- (void)openPageControl {
    PageControlVC * vc = [[PageControlVC alloc] initWithNibName:@"PageControlVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openSafari {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.intel.com"]];
}

- (void)openBarCodeReader {
    QBarCodeReaderVC *vc = [[QBarCodeReaderVC alloc] initWithNibName:@"QBarCodeReaderVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openWebView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Fundamentals" bundle:nil];
    QWebContentVC *vc = [sb instantiateViewControllerWithIdentifier:@"webContentVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
