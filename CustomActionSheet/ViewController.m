//
//  ViewController.m
//  CustomActionSheet
//
//  Created by WingChing_Yip on 16/10/12.
//  Copyright © 2016年 Dinpay Inc. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)popSheet:(UIButton *)sender {
    
    CustomAlertController *alert = [[CustomAlertController alloc] init];
   CustomAction *saveAction = [CustomAction actionWithString:@"保存" handler:^(CustomAction *action) {
        NSLog(@"%@",@"保存");
    }];
   CustomAction *shareAction = [CustomAction actionWithString:@"分享" handler:^(CustomAction *action) {
        NSLog(@"%@",@"分享");
    }];
    [alert addAction:saveAction];
    [alert addAction:shareAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
