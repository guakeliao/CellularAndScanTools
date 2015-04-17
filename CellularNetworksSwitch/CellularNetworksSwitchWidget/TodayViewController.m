//
//  TodayViewController.m
//  CellularNetworksSwitchWidget
//
//  Created by guakeliao on 14/12/20.
//  Copyright (c) 2014年 Boco. All rights reserved.
//
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

extern BOOL CTCellularDataPlanGetIsEnabled();
extern void CTCellularDataPlanSetIsEnabled(BOOL enabled);

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *showText;

@property (nonatomic,assign) BOOL isOpen;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    [self setPreferredContentSize:CGSizeMake(self.view.bounds.size.width, 70)];
    _isOpen = CTCellularDataPlanGetIsEnabled();
    _showText.text = [NSString stringWithFormat:@"数据流量已经%@",_isOpen?@"打开":@"关闭"];
}
#pragma mark
#pragma mark Action
- (IBAction)btnClicked:(id)sender {
    _isOpen = !_isOpen;
    CTCellularDataPlanSetIsEnabled(_isOpen);
    _showText.text = [NSString stringWithFormat:@"数据流量已经%@",_isOpen?@"打开":@"关闭"];
}

// 一般默认的View是从图标的右边开始的...如果你想变换,就要实现这个方法
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
//    UIEdgeInsets newMarginInsets = UIEdgeInsetsMake(defaultMarginInsets.top, defaultMarginInsets.left - 16, defaultMarginInsets.bottom, defaultMarginInsets.right);
//    return newMarginInsets;
//    return UIEdgeInsetsZero; // 完全靠到了左边....
    return UIEdgeInsetsMake(0.0, 16.0, 0, 0);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
