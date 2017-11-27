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
#import "AddOldManAlterView.h"
#import "VerifyIdentityCard.h"
#import "DataInterface.h"
#import "UserManager.h"

@interface NewAdditionOldManViewController () {
    SearchOldManView *_searchView;
    SearchOldManOfResultView *_searchResultView;
    
    AddOldManAlterView *_addOldManAlterView;
}

@end

@implementation NewAdditionOldManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增老人";
    
    //搜索老人
    _searchView = [SearchOldManView loadSearchOldManView];
    _searchView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_searchView];
    [_searchView.searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索老人结果
    _searchResultView = [SearchOldManOfResultView loadSearchOldManOfResultView];
    _searchResultView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_searchResultView];
    [_searchResultView.addAttentionBtn addTarget:self action:@selector(addAttentionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _searchResultView.hidden = YES;
    
}

//添加关注按钮事件
-(void)addAttentionBtnClick {
    _addOldManAlterView = [AddOldManAlterView loadAddOldManAlterView];
    [_addOldManAlterView.okButton addTarget:self action:@selector(addOldManAlterViewOkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//选择关系弹框的确定按钮事件
-(void)addOldManAlterViewOkBtnClick {
    NSString *oldID = _searchView.identTextField.text;
    [[DataInterface shareInstance] addOldRequest:@{@"ID_number":oldID,@"relation":@"子女"}
                                    complication:^(NSDictionary *resultDic)
     {
         int code = [[resultDic objectForKey:@"code"] intValue];
         if(200 == code && [UserManager shareInstance].defaultSelectedOldID.length < 1){
             //关注的第一个老人，将其作为当前的关注老人
             [UserManager shareInstance].defaultSelectedOldID = oldID;
         }
         //                            {
         //                                code = 200;
         //                                msg = "Add attention success!";
         //                            }
     }];
    
    [_addOldManAlterView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

//根据身份证立即查询，查询按钮事件
- (void)searchButtonClick:(id)sender {
    
    BOOL isIdentityCard = YES;//[VerifyIdentityCard validateIDCardNumber:_searchView.identTextField.text];
    
    if (isIdentityCard) {
        
        //输入的是身份证//发送请求查询搜索
        [[DataInterface shareInstance] searchOldIDRequest:@{@"ID_number":_searchView.identTextField.text} complication:^(NSDictionary *resultDic) {
            //            code = 200;
            //            data =     {
            //                "ID_number" = 420521199910100011;
            //                address = xxxxxx;
            //                age = 50;
            //                area = "\U6e56\U5317\U6b66\U6c49";
            //                "cell_phone" = 13928400211;
            //                "fixed_phone" = 1521111212;
            //                name = "\U9648xx";
            //                photo = "";
            //                sex = "\U7537";
            //            };
        }];
        //请求成功后修改UI
        _searchResultView.hidden = NO;
        _searchView.hidden = YES;
    }else{
        //提示
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的身份证号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
