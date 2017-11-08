//
//  NewAdditionOldManViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "NewAdditionOldManViewController.h"
#import "SearchOldManView.h"
#import "SearchOldManOfResultView.h"

@interface NewAdditionOldManViewController () {
    SearchOldManView *_searchView;
    SearchOldManOfResultView *_searchResultView;
}

@end

@implementation NewAdditionOldManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增老人";
    
    _searchView = [SearchOldManView loadSearchOldManView];
    _searchView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_searchView];
    [_searchView.searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchResultView = [SearchOldManOfResultView loadSearchOldManOfResultView];
    _searchResultView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_searchResultView];
    
    _searchResultView.hidden = YES;
    
}

- (void)searchButtonClick:(id)sender {
    _searchResultView.hidden = NO;
    _searchView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
