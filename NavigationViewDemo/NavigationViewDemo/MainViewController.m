//
//  MainViewController.m
//  NavigationViewDemo
//
//  Created by Mac on 17/5/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Demo示例";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *vc = [[ViewController alloc]init];
    vc.isShowNavgationViewButton = (indexPath.row == 1);
    [self.navigationController pushViewController:vc animated:YES];
}


@end
