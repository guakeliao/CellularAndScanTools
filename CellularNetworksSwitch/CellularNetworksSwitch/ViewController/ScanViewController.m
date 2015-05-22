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

@interface ScanViewController () <ZBarReaderViewDelegate>
@property (weak, nonatomic) IBOutlet ZBarReaderView* readview;
@property (weak, nonatomic) IBOutlet UIImageView* readImageView;

@property (nonatomic, strong) UIImageView* readLineView;

@end

@implementation ScanViewController

#pragma mark 获取扫描区域
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x, y, width, height;

    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;

    return CGRectMake(x, y, width, height);
}

#pragma mark 扫描动画
- (void)loopDrawLine
{
    CGRect rect = CGRectMake(self.readImageView.frame.origin.x,
        self.readImageView.frame.origin.y,
        self.readImageView.frame.size.width, 2);
    if (self.readLineView) {
        [self.readLineView removeFromSuperview];
        self.readLineView = nil;
    }
    self.readLineView = [[UIImageView alloc] initWithFrame:rect];
    [self.readLineView setImage:[UIImage imageNamed:@"line.png"]];
    self.readLineView.backgroundColor = [UIColor grayColor];
    [UIView animateWithDuration:3.0
        delay:0.0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
        //修改fream的代码写在这里
        self.readLineView.frame =
            CGRectMake(self.readLineView.frame.origin.x,
                       self.readLineView.frame.origin.y +
                           self.readLineView.frame.size.height,
                       self.readLineView.frame.size.width, 2);
        [self.readLineView setAnimationRepeatCount:1];
        }
        completion:^(BOOL finished) {
//                                     if (!is_Anmotion) {
//            
//                                         [self loopDrawLine];
//                                     }

        }];

    [self.readview addSubview:self.readLineView];
}
#pragma mark 获取扫描结果
- (void)readerView:(ZBarReaderView*)readerView
    didReadSymbols:(ZBarSymbolSet*)symbols
         fromImage:(UIImage*)image
{
    // 得到扫描的条码内容
    const zbar_symbol_t* symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString* symbolStr =
        [NSString stringWithUTF8String:zbar_symbol_get_data(symbol)];
    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE) {
        // 是否QR二维码
    }

    for (ZBarSymbol* symbol in symbols) {
        //        [sTxtField setText:symbol.data];
        if ([symbol.data hasPrefix:@"http://"]||[symbol.data hasPrefix:@"https://"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:symbol.data]];
        }else
        {
            NSLog(@"%@",symbol.data);
        }
        break;
    }

    [readerView stop];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"二维码相关";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loopDrawLine];
    [self.readview start];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.readview stop];
}
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    self.readview.scanCrop =
//        [self getScanCrop:self.readImageView.frame
//            readerViewBounds:self.readview.frame]; //将被扫描的图像的区域
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initForData];
    [self initForView];
    //    [self initForAction];
}
#pragma mark
#pragma mark Init For VC

- (void)initForData
{
}

- (void)initForView
{
    //    self.readview.backgroundColor = [UIColor clearColor];
    self.readview.readerDelegate = self;
    self.readview.allowsPinchZoom = YES; //使用手势变焦
    self.readview.trackingColor = [UIColor redColor];
    self.readview.showsFPS = NO; // 显示帧率  YES 显示  NO 不显示

    self.readview.scanCrop =
        [self getScanCrop:self.readImageView.frame
            readerViewBounds:self.readview.bounds]; //将被扫描的图像的区域
    [self.readview addSubview:self.readLineView];
}

@end
