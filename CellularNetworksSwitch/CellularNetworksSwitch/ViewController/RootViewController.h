//
//  RootViewController.h
//  CellularNetworksSwitch
//
//  Created by guakeliao on 15/4/16.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>

@interface RootViewController : UIViewController

- (void)addRightBarButtonWithTitle:(NSString *)title andAction:(SEL)action;

@end
