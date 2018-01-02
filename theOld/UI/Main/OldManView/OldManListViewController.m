//
//  OldManListViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldManListViewController.h"
#import "OldManListCollectionViewCell.h"
#import "NewAdditionOldManViewController.h"
#import "DataInterface.h"
#import "ShiMingViewController.h"
#import "CareOldManModel.h"
#import "MJRefresh.h"
#import "MainDataManager.h"
#import "UserManager.h"

static NSString *cellIdent = @"OldManListCollectionViewCell";

static MainDataManager *dataManager;

@interface OldManListViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>{
    CGRect _frame;
    
}

@property (strong, nonatomic) UICollectionView *collectionView;

//@property (strong, nonatomic) NSMutableArray *dataArr;

@property (nonatomic) NSInteger selectIndex;

@end

@implementation OldManListViewController

//-(NSMutableArray*)dataArr {
//    if (!_dataArr) {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataManager = [MainDataManager sharedInstance];
    
    [self makeMainView];
    
    if ([UserManager shareInstance].isLogined) {
        [self loadData];
    }
    
}

- (void)loadData{
    [DataInterface careOldManListRequest:nil result:^(CommonResponseModel *model, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if ([model.code integerValue] == 200) {
            MainDataManager *dataManager = [MainDataManager sharedInstance];
            dataManager.dataArray = [CareOldManModel covertToArrayWithDictArray:model.data[@"focus_list"]];
            [self.collectionView reloadData];
        }
        
    }];
}

-(void)makeMainView {
    //UICollection
    UICollectionViewFlowLayout *folowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置水平滚动
    folowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    folowLayout.minimumLineSpacing = 20;
    folowLayout.minimumInteritemSpacing = 0;
   [folowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame)) collectionViewLayout:folowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIColorFromRGB(0xf5f9fd);
    [self.collectionView registerNib:[UINib nibWithNibName:@"OldManListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdent];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

#pragma mark - UICollectionViewDataSource method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [MainDataManager sharedInstance].dataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OldManListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 10;
    
    if (dataManager.dataArray.count == indexPath.row) {
        cell.personImageV.image = [UIImage imageNamed:@"addImage.png"];
        cell.nameLab.text = @"新增老人";
    }else{
        //正常数据
        cell.personImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
        CareOldManModel *model = [[MainDataManager sharedInstance].dataArray objectAtIndex:indexPath.row];
        cell.nameLab.text = model.name;
        if (_selectIndex == indexPath.row) {
            cell.nameLab.backgroundColor = baseColor;
            cell.nameLab.textColor = [UIColor whiteColor];
        }
        else{
            cell.nameLab.backgroundColor = [UIColor whiteColor];
            cell.nameLab.textColor = [UIColor blackColor];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(152*ScreenHRatioBaseIphone6, 183*ScreenHRatioBaseIphone6);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(25, 25, 20,25);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (dataManager.dataArray.count == indexPath.row) {
        if(dataManager.dataArray.count == 0){
//            //弹出完善信息提示
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"关注老人" message:@"请完善您的个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即完善", nil];
//            [alter show];
        }else{
            //@"新增老人";
            UIViewController *vc = (UIViewController *)self.delegate;
            
            NewAdditionOldManViewController *vv = [[NewAdditionOldManViewController alloc] init];
            [vc.navigationController pushViewController:vv animated:YES];
        }
        
    }else{
        //普通数据点击更新界面
        self.selectIndex = indexPath.row;
        [collectionView reloadData];
        [MainDataManager sharedInstance].selectIndex = indexPath.row;
        [[NSNotificationCenter defaultCenter] postNotificationName:SELECT_OLDMAN_NOTIFICATION object:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIViewController *vc = (UIViewController *)self.delegate;
        
        ShiMingViewController *vv = [[ShiMingViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        [vc.navigationController pushViewController:vv animated:YES];

    }
}

- (void)setupDelegate:(id)delegate {
    self.delegate = delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
