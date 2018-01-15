//
//  UserCenterViewController.m
//  theOld
//
//  Created by loary on 2017/11/2.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UserCenterViewController.h"
#import "VVConfig.h"

#import "UserManager.h"
#import "ShiMingViewController.h"
#import "ChangePwdViewController.h"
#import "ChangeIphoneViewController.h"
#import "CustomNavigationController.h"
#import "UserCenterTableViewCell.h"
#import "PhysiologicalDataTableViewHeader.h"
#import "MainViewController.h"
#import "LeveyTabBarController.h"
#import <Social/Social.h>
#import "AppDelegate.h"
#import "AFNetworking.h"


static NSString *cellIdet = @"UserCenterTableViewCell";
static NSString *cellHeaderIdet = @"PhysiologicalDataTableViewHeader";
static UserManager *userManager;

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    CGRect _frame;
    UITableView *_mainTableView;
    UIView *_buttonCellView;
 
}
@property (nonatomic, strong) NSArray *labelNameArr;
@property (nonatomic, strong) NSArray *labelImageNameArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UserCenterViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
    [self.view setBackgroundColor:UIColorRGB(248, 248, 248)];
}

-(void)initNavgationView {
    self.title = @"个人中心";
    //返回按钮
//    UIButton *leftnButton = [[UIButton alloc] initWithFrame:BACK_IMAGE_VFRAME];
//    [leftnButton setImage:BACK_IMAGE forState:UIControlStateNormal];
//    [leftnButton addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithCustomView:leftnButton];
//    self.navigationItem.leftBarButtonItem = bbi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userManager = [UserManager shareInstance];
    //加载导航
    [self initNavgationView];
    
    self.labelNameArr = @[@[@"头像",@"账号",@"实名信息"],@[@"更换手机",@"修改密码"]];

    
    [self loadFooterView];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColorRGB(241, 246, 252);
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdet];
    [self.tableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:cellHeaderIdet];
    self.tableView.tableFooterView = _buttonCellView;
}

//关注老人／邀请监护
-(void)loadFooterView {
    
    //底部cell视图
    _buttonCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 102)];
    _buttonCellView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 0.5, 80)];
    line.backgroundColor = UIColorFromRGB(0xcccccc);
    line.center = CGPointMake(CGRectGetWidth(_frame)/2, line.center.y);
    [_buttonCellView addSubview:line];
    
    //左边关注老人按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 10, 160, 80);
    leftBtn.center = CGPointMake(CGRectGetWidth(_frame)/4, leftBtn.center.y);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
    leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [leftBtn setTitle:[NSString stringWithFormat:@"%ld", userManager.focus_count] forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColorFromRGB(0xff9c31) forState:UIControlStateNormal];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
    [_buttonCellView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //左边关注老人文字
    UILabel *leftll = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(leftBtn.frame) - 30, CGRectGetWidth(leftBtn.frame), 30)];
    leftll.text = @"关注老人";
    leftll.textColor = UIColorFromRGB(0x666666);
    leftll.textAlignment = NSTextAlignmentCenter;
    leftll.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11.0];
    [leftBtn addSubview:leftll];
    
    //右边邀请监护人按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = leftBtn.frame;
    rightBtn.center = CGPointMake(3*CGRectGetWidth(_frame)/4, rightBtn.center.y);
    
    [rightBtn setTitleColor:UIColorFromRGB(0xff9c31) forState:UIControlStateNormal];
    [rightBtn setTitle:[NSString stringWithFormat:@"%ld", userManager.focus_count] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = leftBtn.titleLabel.font;
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
    [_buttonCellView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //右边邀请监护人文字
    UILabel *rightll = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rightBtn.frame) - 30, CGRectGetWidth(rightBtn.frame), 30)];
    rightll.text = @"邀请监护人";
    rightll.textColor = UIColorFromRGB(0x666666);
    rightll.textAlignment = NSTextAlignmentCenter;
    rightll.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11.0];
    [rightBtn addSubview:rightll];
    
}

//邀请监护人事件
-(void)rightButtonClick {
 
    UIImage *imageToShare = [UIImage imageNamed:@"userCenterMid.png"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.vshare.com/down_vshare_vip/"];
    NSString *textToShare = [NSString stringWithFormat:@"分享的文本内容"];
    
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}

-(void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    LeveyTabBarController *tabVC = (LeveyTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;

    MainViewController *mainController=[[MainViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight*ScreenRatio, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight*ScreenRatio)];
    NSInteger pageInde = 0;
    CustomNavigationController *ctl =[tabVC.viewControllers objectAtIndex:pageInde];
    tabVC.selectedIndex = 0;
    [ctl  pushViewController:mainController animated:YES];
    mainController.pageIndex = 1;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.labelNameArr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section<self.labelNameArr.count) {
        return [self.labelNameArr[section] count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    PhysiologicalDataTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellHeaderIdet];
//    headerView.dateLabel.hidden = YES;
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = UIColorRGB(245, 249, 252);
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == 0 && indexPath.row == 0) {//头像cell高度
        height = 66.0;
    }else {
        height = 51.0;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdet];
    cell.titleLab.text = self.labelNameArr[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshCellViewWithData:nil indexPath:indexPath];
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            [self photo];
        }else if (1 == indexPath.row) {
            
        }else if (2 == indexPath.row) {
            ShiMingViewController *gegisterVC = [[ShiMingViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
            [self.navigationController pushViewController:gegisterVC animated:YES];
        }
    }else if (1 == indexPath.section) {
        UIViewController *vc = nil;
        if (0 == indexPath.row) {
            vc = [[ChangeIphoneViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        }else if (1 == indexPath.row) {
            vc = [[ChangePwdViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - photo
- (void)photo {
    VFWeakSelf(self)
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        alert.view.tintColor = baseColor;
        //通过拍照上传图片
        UIAlertAction * takingPicAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = weakself;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [weakself presentViewControllerFromRootController:imagePicker animated:YES completion:nil];
                
            }
            
        }];
        //从手机相册中选择上传图片
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = weakself;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                [self presentViewController:imagePicker animated:YES completion:nil];
                [weakself presentViewControllerFromRootController:imagePicker animated:YES completion:nil];
            }
            
        }];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:takingPicAction];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
//        [self presentViewController:alert animated:YES completion:nil];
        [self presentViewControllerFromRootController:alert animated:YES completion:nil];
        
        
    }else{
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark 调用系统相册及拍照功能实现方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"调用系统相册及拍照功能实现方法");
    UIImage * chosenImage = info[UIImagePickerControllerEditedImage];
    UIImageView * picImageView = (UIImageView *)[self.view viewWithTag:500];
    picImageView.image = chosenImage;
    chosenImage = [self imageWithImageSimple:chosenImage scaledToSize:CGSizeMake(150, 150)];
    NSData * imageData = UIImageJPEGRepresentation(chosenImage, 0.9);
    
    VFWeakSelf(self)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:[UserManager shareInstance].session forHTTPHeaderField:@"Authorization"];
    [manager POST:@"http://61.155.215.48:5000/api/upload_pic/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"jpg" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CommonResponseModel *model = [CommonResponseModel covertToModelWithDict:responseObject];
        if (model.code.integerValue == 200) {
            [UserManager shareInstance].photo = [model.data objectForKey:@"photo"];
            [weakself showInfoMsg:@"上传成功！"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USER_INFO object:nil];
                 [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
           
        }
        else{
            [weakself showInfoMsg:model.msg];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself showNetworkError];
    }];
    

    //    [self saveImage:chosenImage withName:@"avatar.png"];
    //    NSURL * filePath = [NSURL fileURLWithPath:[self documentFolderPath]];
    //将图片上传到服务器
    //    --------------------------------------------------------
//    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:nil];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json", nil];
//    NSString * urlString = [NSString stringWithFormat:@"%@appuser/modifyUserIcon",BASE_URL];
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:1];
//    [dict setObject:[userDefaults objectForKey:@"user_id"] forKey:@"user_id"];
//    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //通过post请求上传用户头像图片,name和fileName传的参数需要跟后台协商,看后台要传的参数名
//        [formData appendPartWithFileData:imageData name:@"img" fileName:@"img.jpg" mimeType:@"image/jpeg"];
//
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //解析后台返回的结果,如果不做一下处理,打印结果可能是一些二进制流数据
//        NSError *error;
//        NSDictionary * imageDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
//        //上传成功后更新数据
//        self.personModel.adperurl = imageDict[@"adperurl"];
//        NSLog(@"上传图片成功0---%@",imageDict);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"上传图片-- 失败  -%@",error);
//    }];
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"用户取消选取时调用");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

//返回按钮事件
-(void)backbuttonclick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
