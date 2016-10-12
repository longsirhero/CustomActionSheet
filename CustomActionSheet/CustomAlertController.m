//
//  CustomAlertController.m
//  CustomActionSheet
//
//  Created by WingChing_Yip on 16/10/12.
//  Copyright © 2016年 Dinpay Inc. All rights reserved.
//

#import "CustomAlertController.h"
#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
NSString *const reuseId = @"reuseID";
CGFloat const customActionSheetCellHeight = 44.0;

@interface CustomAction ()

/**
 *  写属性保存
 */
@property (nonatomic , strong , readwrite) UIView *customView;
@property (nonatomic , copy , readwrite) void (^handler)(CustomAction * _Nonnull);

@end

@implementation CustomAction

+ (instancetype)actionWithString:(NSString *)title handler:(void (^)(CustomAction *))handler {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH,customActionSheetCellHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    return [[self alloc] initActionWithCustomView:label andHandler:handler];
}

- (instancetype)initActionWithCustomView:(UIView *)customView andHandler:(void (^)(CustomAction *))handler {
    self = [super init];
    if (self) {
        self.customView = customView;
        self.handler = handler;
    }
    return self;
}

@end

@interface CustomAlertController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong , readwrite) UITableView *tableView;
@property (nonatomic , strong , readwrite) NSMutableArray *dataSource;
@property (nonatomic , strong , readwrite) UIView *backGroundView;

@end

@implementation CustomAlertController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma makr lifeCycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backGroundView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(self.dataSource.count+1)*customActionSheetCellHeight-5, [UIScreen mainScreen].bounds.size.width, (self.dataSource.count+1)*customActionSheetCellHeight+5);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -
#pragma mark add action method
- (void)addAction:(CustomAction *)action {
    [self.dataSource addObject:action];
}

- (void)tapClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        CustomAction *action = self.dataSource[indexPath.row];
        [cell.contentView addSubview:action.customView];
    }
    else {
        UILabel* cancelLabel = [[UILabel alloc]initWithFrame:cell.bounds];
        cancelLabel.text = @"取消";
        cancelLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:cancelLabel];
    }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return customActionSheetCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENHEIGHT, 5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (indexPath.section == 1) {
        return ;
    }
    CustomAction *action = self.dataSource[indexPath.row];
    action.handler(action);
}

#pragma mark -
#pragma mark lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, (self.dataSource.count +1 ) * customActionSheetCellHeight + 5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor blackColor];
        _backGroundView.userInteractionEnabled = YES;
        _backGroundView.alpha = 0.5;
        _backGroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClose)];
        [_backGroundView addGestureRecognizer:tap];
    }
    return _backGroundView;
}
@end
