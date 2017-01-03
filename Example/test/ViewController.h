//
//  ViewController.h
//  test
//
//  Created by zitopay on 2017/1/3.
//  Copyright © 2017年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZITOPay.h"
@interface ViewController : UIViewController
@property (nonatomic,retain) NSDictionary *dicData;

@property (strong, nonatomic) ZITOBaseResp *orderList;

@property  (assign, nonatomic) NSInteger actionType;

@end

