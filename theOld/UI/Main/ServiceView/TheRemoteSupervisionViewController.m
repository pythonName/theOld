//
//  TheRemoteSupervisionViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "TheRemoteSupervisionViewController.h"
#import "DataInterface.h"

@interface TheRemoteSupervisionViewController ()

@end

@implementation TheRemoteSupervisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"远程看护";
    [[DataInterface shareInstance] registerDeviceRequest:nil complication:^(NSDictionary *resultDic) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
