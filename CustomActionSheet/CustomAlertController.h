//
//  CustomAlertController.h
//  CustomActionSheet
//
//  Created by WingChing_Yip on 16/10/12.
//  Copyright © 2016年 Dinpay Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAction : NSObject

+ (instancetype)actionWithString:(NSString *)title handler:(void(^)(CustomAction *action)) handler;
+ (instancetype)actionWithAttributedString:(NSString *)title handler:(void(^)(CustomAction *action)) handler;
+ (instancetype)actionWithCustomView:(UIView *)customView handler:(void(^)(CustomAction *action)) handler;

@end

@interface CustomAlertController : UIViewController

- (void)addAction:(CustomAction *)action;

@end
