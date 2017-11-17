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

static NSString *cellIdent = @"OldManListCollectionViewCell";

@interface OldManListViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    CGRect _frame;
    
}

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation OldManListViewController

-(NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
    self.view.backgroundColor = [UIColor yellowColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    
    [self makeMainView];
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
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"OldManListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdent];
}

#pragma mark - UICollectionViewDataSource method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OldManListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 10;
    
    if (self.dataArr.count == indexPath.row) {
        cell.personImageV.image = [UIImage imageNamed:@"addImage.png"];
        cell.nameLab.text = @"新增老人";
    }else{
        //正常数据
        cell.personImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
        cell.nameLab.text = @"李大帅";
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
    if (self.dataArr.count == indexPath.row) {
        //@"新增老人";
        UIViewController *vc = (UIViewController *)self.delegate;
        
        NewAdditionOldManViewController *vv = [[NewAdditionOldManViewController alloc] init];
        [vc.navigationController pushViewController:vv animated:YES];
    }else{
        //普通数据点击更新界面
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
