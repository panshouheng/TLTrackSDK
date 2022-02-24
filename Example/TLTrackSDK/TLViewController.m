//
//  TLViewController.m
//  TLTrackSDK
//
//  Created by panshouheng on 11/17/2021.
//  Copyright (c) 2021 panshouheng. All rights reserved.
//

#import "TLViewController.h"
#import "TLSecondViewController.h"
#import <TLTrackSDK.h>
@interface TLViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"首页";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"carpet_mode_select"] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(200, 200, 100, 1000) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"123123"];
    [self.view addSubview:tableView];
    
    
    
}
- (void)buttonClick {
    TLSecondViewController *second = [[TLSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
    [TLTrackSDK.sharedInstance deleteSuperPropertiesByKeys:@[@"自己添加的属性5"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123123"];
    cell.textLabel.text = @"dasdasdasd";
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [TLTrackSDK.sharedInstance registerSuperProperties:@{[NSString stringWithFormat:@"自己添加的属性%ld",indexPath.row]:@"自己添加的超级属性"}];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
