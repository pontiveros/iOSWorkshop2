//
//  QBarCodeReaderVC.m
//  iOSWorkshop2
//
//  Created by Pedro Ontiveros on 6/2/16.
//  Copyright © 2016 Pedro Ontiveros. All rights reserved.
//

#import "QBarCodeReaderVC.h"
#import "FundamentalsVC.h"

@interface QBarCodeReaderVC ()

@property(nonatomic, weak) IBOutlet UIButton *btnBarCodeReader;
@property(nonatomic, weak) IBOutlet UILabel  *lblFormat;
@property(nonatomic, weak) IBOutlet UILabel  *lblContent;

@end

@implementation QBarCodeReaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Bar Code Reader";
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


- (IBAction)onTapOpenBarCodeReader:(id)sender {
    ZBarReaderViewController *vc = [[ZBarReaderViewController alloc] init];
    vc.readerDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"INFO: %@", [info description]);
    
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //    resultText.text = symbol.data;
    QBarCodeReaderVC *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^ {
        [weakSelf.lblFormat setText:symbol.typeName];
        [weakSelf.lblContent setText:symbol.data];
    });
    
    NSLog(@"READ: %@", symbol.data);
    
    // EXAMPLE: do something useful with the barcode image
    //    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ZBarReaderDelegate

- (void) readerControllerDidFailToRead:(ZBarReaderController*)reader withRetry: (BOOL) retry {
    NSLog(@"Reader is not working properly.");
}

@end
