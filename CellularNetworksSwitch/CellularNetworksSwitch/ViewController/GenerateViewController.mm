//
//  GenerateViewController.m
//  CellularNetworksSwitch
//
//  Created by guakeliao on 15/4/16.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "GenerateViewController.h"
#import "QREncoder.h"
#import "DataMatrix.h"

@interface GenerateViewController ()
@property(weak, nonatomic) IBOutlet UITextView *textView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation GenerateViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"生成";
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addRightBarButtonWithTitle:@"生成" andAction:@selector(updatePressed:)];
}

#pragma mark - Events
- (void)updatePressed:(id)sender {
  [self.textView resignFirstResponder];

  NSString *aVeryLongURL = self.textView.text;

  DataMatrix *qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO
                                              version:QR_VERSION_AUTO
                                               string:aVeryLongURL];
  UIImage *qrcodeImage =
      [QREncoder renderDataMatrix:qrMatrix
                   imageDimension:self.imageView.frame.size.width];

  self.imageView.image = qrcodeImage;
}
@end
