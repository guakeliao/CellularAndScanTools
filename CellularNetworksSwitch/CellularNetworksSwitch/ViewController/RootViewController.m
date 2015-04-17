//
//  RootViewController.m
//  CellularNetworksSwitch
//
//  Created by guakeliao on 15/4/16.
//  Copyright (c) 2015年 Boco. All rights reserved.
//
#define IOS_Version ([[UIDevice currentDevice] systemVersion])
#define IOS7_OR_LATER ([IOS_Version compare:@"7.0"] != NSOrderedAscending)

#import "RootViewController.h"


@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  if (IOS7_OR_LATER) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
}

- (void)addRightBarButtonWithTitle:(NSString *)title andAction:(SEL)action {
  self.navigationItem.rightBarButtonItem =
      [self barButtonItemWithTitle:title andAction:action];
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                  andAction:(SEL)action {
  UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
  [buttonItem setTitle:title forState:UIControlStateNormal];
  [buttonItem addTarget:self
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
  //  [NUIRenderer renderButton:buttonItem
  //                  withClass:self.styleClassNameForNavBarItem];
  [buttonItem sizeToFit];
  UIBarButtonItem *barItem =
      [[UIBarButtonItem alloc] initWithCustomView:buttonItem];
  return barItem;
}
@end
