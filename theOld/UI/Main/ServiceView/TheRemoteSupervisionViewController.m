//
//  TheRemoteSupervisionViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "TheRemoteSupervisionViewController.h"
#import "DataInterface.h"
#import <MAMapKit/MAMapKit.h>
#import "Masonry.h"
#import "LTAVPlayerView.h"

static NSString *cloudURL = @"http://hls.kan1.live.anyan.com/live_60875_103875/m3u8?sign=1513839731-48cc1f190412b437c8adf20abd836054&device_sn=Ay0000000000002107UM&video_rate=700&channel_id=1&customer=60875_103875";

@interface TheRemoteSupervisionViewController ()

@property (nonatomic, strong) UIView *smallMapView;
@property (nonatomic, strong) UIView *smallVideoView;

@property (nonatomic, strong) LTAVPlayerView *playerView;
@property (nonatomic, strong) LTAVPlayerView *playerView2;


@property (nonatomic, strong) UIButton *smallMapViewBtn;
@property (nonatomic, strong) UIButton *smallVideoViewBtn;

@property (nonatomic, strong) MAMapView *mapView1;
@property (nonatomic, strong) MAMapView *mapView2;

@property (nonatomic, strong) UIView *videoView;

@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UILabel *heartLabel;
@property (nonatomic, strong) UIButton *contactButton;

@end

@implementation TheRemoteSupervisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"远程看护";
//    [[DataInterface shareInstance] registerDeviceRequest:nil complication:^(NSDictionary *resultDic) {
//        
//    }];
    
    
    [self.view addSubview:self.videoView];
    [self.videoView addSubview:self.playerView2];
    [self.view addSubview:self.mapView2];
    
    
    [self.view addSubview:self.smallMapView];
    [self.smallMapView addSubview:self.mapView1];
    [self.view addSubview:self.smallMapViewBtn];
    
    [self.view addSubview:self.smallVideoView];
    [self.smallVideoView addSubview:self.playerView];
    [self.view addSubview:self.smallVideoViewBtn];
    
    [self.view addSubview:self.bottomBackView];
    [self.bottomBackView addSubview:self.heartLabel];
    [self.bottomBackView addSubview:self.contactButton];
    
    [self lxt_addConstraints];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"退出远程监控页面*****************");
    [self.playerView stopPlay];
    [self.playerView2 stopPlay];
}

#pragma mark - updateConstraints

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //自动布局等到view的frame确定后，更新PlayerLayer的frame否则无法显示视频
    [self.playerView updatePlayerLayerFrame];
    [self.playerView2 updatePlayerLayerFrame];
}

- (void)lxt_addConstraints{
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.playerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.mapView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.smallMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.smallMapViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.mapView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    
    
    [self.smallVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallMapView.mas_right).with.offset(20);
        make.centerY.equalTo(self.smallMapView);
        make.size.equalTo(self.smallMapView);
    }];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.smallVideoViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallMapView.mas_right).with.offset(20);
        make.centerY.equalTo(self.smallMapView);
        make.size.equalTo(self.smallMapView);
    }];
    
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.heartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBackView).with.offset(16);
        make.centerY.equalTo(self.bottomBackView);
    }];
    
    [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomBackView).with.offset(-16);
        make.centerY.equalTo(self.bottomBackView);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
}

#pragma mark - UserAction
//点击小地图
-(void)smallMapViewClick:(UIButton *)button{
    NSLog(@"samllMapViewTap");
    _smallVideoView.layer.borderColor = [UIColor grayColor].CGColor;
    _smallMapView.layer.borderColor = [UIColor greenColor].CGColor;
    [UIView animateWithDuration:0.3 animations:^{
        self.mapView2.alpha = 1.0;
    }];
    
}

//点击小监控
- (void)smallVideoViewClick:(UIButton *)button{
    NSLog(@"smallVideoViewTap");
    _smallVideoView.layer.borderColor = [UIColor greenColor].CGColor;
    _smallMapView.layer.borderColor = [UIColor grayColor].CGColor;
    [UIView animateWithDuration:0.3 animations:^{
        self.mapView2.alpha = 0.0;
    }];
}

//联系老人
- (void)contactOldMan{
    NSLog(@"联系老人");
}

#pragma mark - getter setter

- (UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc] init];
        _videoView.backgroundColor = [UIColor blueColor];
    }
    
    return _videoView;
}

- (UIView *)smallMapView{
    if (!_smallMapView) {
        _smallMapView = [[UIView alloc] init];
        _smallMapView.layer.borderWidth = 2.0;
        _smallMapView.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
    return _smallMapView;
}


- (UIView *)smallVideoView{
    if (!_smallVideoView) {
        _smallVideoView = [[UIView alloc] init];
        _smallVideoView.layer.borderWidth = 2.0;
        _smallVideoView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _smallVideoView;
}

- (UIButton *)smallMapViewBtn{
    if (!_smallMapViewBtn) {
        _smallMapViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallMapViewBtn addTarget:self action:@selector(smallMapViewClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _smallMapViewBtn;
}

- (UIButton *)smallVideoViewBtn{
    if (!_smallVideoViewBtn) {
        _smallVideoViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallVideoViewBtn addTarget:self action:@selector(smallVideoViewClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallVideoViewBtn;
}

- (MAMapView *)mapView1{
    if (!_mapView1) {
        _mapView1 = [[MAMapView alloc] init];
        _mapView1.zoomLevel = 16;
        _mapView1.showsUserLocation = YES;
        _mapView1.userTrackingMode = MAUserTrackingModeFollow;
        
    }
    return _mapView1;
}

- (MAMapView *)mapView2{
    if (!_mapView2) {
        _mapView2 = [[MAMapView alloc] init];
        _mapView2.zoomLevel = 16;
        _mapView2.showsUserLocation = YES;
        _mapView2.userTrackingMode = MAUserTrackingModeFollow;
        _mapView2.userInteractionEnabled = NO;
    }
    
    return _mapView2;
}

- (UIView *)bottomBackView{
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] init];
        _bottomBackView.backgroundColor = [UIColor blackColor];
        _bottomBackView.alpha = 0.7;
    }
    return _bottomBackView;
}

- (UILabel *)heartLabel{
    if (!_heartLabel) {
        _heartLabel = [[UILabel alloc] init];
        _heartLabel.text = @"老人心率：70次/分";
        _heartLabel.textColor = [UIColor whiteColor];
    }
    return _heartLabel;
}

- (UIButton *)contactButton{
    if (!_contactButton) {
        _contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactButton setTitle:@"联系老人" forState:UIControlStateNormal];
        [_contactButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _contactButton.backgroundColor = [UIColor greenColor];
        _contactButton.layer.cornerRadius = 15.0;
        [_contactButton addTarget:self action:@selector(contactOldMan) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _contactButton;
}

- (LTAVPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[LTAVPlayerView alloc] init];
        [_playerView setVedioURL:cloudURL];
    }
    
    return _playerView;
}

- (LTAVPlayerView *)playerView2{
    if (!_playerView2) {
        _playerView2 = [[LTAVPlayerView alloc] init];
        [_playerView2 setVedioURL:cloudURL];
    }
    return _playerView2;
}


@end
