//
//  ViewController.m
//  CellularNetworksSwitch
//
//  Created by guakeliao on 14/12/20.
//  Copyright (c) 2014年 Boco. All rights reserved.
//

#import "ScanViewController.h"
#import "GenerateViewController.h"
#import "ZBarSDK.h"

@interface ScanViewController () <ZBarReaderDelegate>

@property(nonatomic, weak) IBOutlet UIView *scanRectView;
@property(nonatomic, weak) IBOutlet UILabel *decodedLabel;

@end

@implementation ScanViewController

#pragma mark - View Controller Methods
//扫描
- (IBAction)scanClicked:(id)sender {

  ZBarReaderViewController *readerVC = [ZBarReaderViewController new];
  readerVC.readerDelegate = self;
  readerVC.supportedOrientationsMask = ZBarOrientationMaskAll;
  ZBarImageScanner *scanner = readerVC.scanner;
  [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];

  UINavigationController *scanNV =
      [[UINavigationController alloc] initWithRootViewController:readerVC];
  scanNV.navigationItem.title = @"扫描";
  [self presentViewController:scanNV animated:YES completion:nil];
}
//生成
- (IBAction)createClicked:(id)sender {
  UINavigationController *createNV = [[UINavigationController alloc]
      initWithRootViewController:[[GenerateViewController alloc] init]];
  [self.navigationController presentViewController:createNV
                                          animated:YES
                                        completion:nil];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"二维码相关";
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self initForData];
  [self initForView];
  //  [self initForAction];
}
#pragma mark
#pragma mark Init For VC

- (void)initForData {
}

- (void)initForView {
}

- (void)imagePickerController:(UIImagePickerController *)reader
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
  // ADD: get the decode results
  id<NSFastEnumeration> results =
      [info objectForKey:ZBarReaderControllerResults];
  ZBarSymbol *symbol = nil;
  for (symbol in results)
    // EXAMPLE: just grab the first barcode
    break;

  // EXAMPLE: do something useful with the barcode data
  self.decodedLabel.text = symbol.data;

  // EXAMPLE: do something useful with the barcode image
  //    resultImage.image =
  //    [info objectForKey: UIImagePickerControllerOriginalImage];

  // ADD: dismiss the controller (NB dismiss from the *reader*!)
  [reader dismissModalViewControllerAnimated:YES];
}

@end
