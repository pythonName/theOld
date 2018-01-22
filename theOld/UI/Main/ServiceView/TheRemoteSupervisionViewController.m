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
#import "MainDataManager.h"
#import "CareOldManModel.h"
#import "CustomAnnotationView.h"

static NSString *cloudURL = @"http://hls.kan1.live.anyan.com/live_60875_103875/m3u8?sign=1513839731-48cc1f190412b437c8adf20abd836054&device_sn=Ay0000000000002107UM&video_rate=700&channel_id=1&customer=60875_103875";

@interface TheRemoteSupervisionViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) UIView *smallMapView;
@property (nonatomic, strong) UIView *smallVideoView;

@property (nonatomic, strong) LTAVPlayerView *playerView;
@property (nonatomic, strong) LTAVPlayerView *playerView2;


@property (nonatomic, strong) UIButton *smallMapViewBtn;
@property (nonatomic, strong) UIButton *smallVideoViewBtn;

@property (nonatomic, strong) MAMapView *mapView1;
@property (nonatomic, strong) MAMapView *mapView2;
@property (nonatomic, strong) MAPointAnnotation *annotation;

@property (nonatomic, strong) UIView *videoView;

@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UILabel *heartLabel;
@property (nonatomic, strong) UIButton *contactButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TheRemoteSupervisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"远程看护";
    
    //全屏地图及视频播放器
    [self.view addSubview:self.videoView];
    [self.videoView addSubview:self.playerView2];
    [self.view addSubview:self.mapView2];
    
    
    //左上角小地图
    [self.view addSubview:self.smallMapView];
    [self.smallMapView addSubview:self.mapView1];
    [self.view addSubview:self.smallMapViewBtn];
    
    //左上角的视频缩略图
    [self.view addSubview:self.smallVideoView];
    [self.smallVideoView addSubview:self.playerView];
    [self.view addSubview:self.smallVideoViewBtn];
    
    //底部老人心率及联系方式
    [self.view addSubview:self.bottomBackView];
    [self.bottomBackView addSubview:self.heartLabel];
    [self.bottomBackView addSubview:self.contactButton];
    
    [self lxt_addConstraints];
    
    [self loadData];
    self.timer;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //必须要在预添加一个annotation否则 之后添加的annotation无效  具体原因不明
    _annotation = [[MAPointAnnotation alloc] init];
    _annotation.coordinate = CLLocationCoordinate2DMake(22.55724716, 113.93560028);
    [_mapView1 addAnnotation:_annotation];
    [_mapView1 setCenterCoordinate:_annotation.coordinate animated:YES];
    _mapView1.zoomLevel = 13;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [_timer invalidate];
    _timer = nil;
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"*****************退出远程监控页面*****************");
    [self.playerView stopPlay];
    [self.playerView2 stopPlay];
    
}

#pragma mark - 请求数据
- (void)loadData{
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.ID_number forKey:@"ID_number"];
    [DataInterface remoteSupervisionRequest:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == 200) {
            NSArray *dataArray = model.data;
            if (dataArray.count > 0) {
                NSDictionary *dict = [dataArray firstObject];
                cloudURL = [dict objectForKey:@"m3u8_url"];
                [self.playerView setVedioURL:cloudURL];
                [self.playerView2 setVedioURL:cloudURL];
            }
            
        }
        else{
            [self showInfoMsg:model.msg];
        }
    }];
}

- (void)loadLocationData{
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.ID_number forKey:@"ID_number"];
    [DataInterface remoteLocationRequest:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == 200) {
            NSLog(@"===%@", model.data);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *heart = [model.data objectForKey:@"heart_rate"];
                self.heartLabel.text = [NSString stringWithFormat:@"老人心率：%@次/分", heart];
                float lat = [[[model.data objectForKey:@"position"] objectForKey:@"lat"] floatValue];
                float lon = [[[model.data objectForKey:@"position"] objectForKey:@"lon"] floatValue];
                
                [self.mapView1 removeAnnotation:_annotation];
                [self.mapView2 removeAnnotation:_annotation];
                
                [self.mapView1 setCenterCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                [self.mapView2 setCenterCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                
                _annotation = [[MAPointAnnotation alloc] init];
                _annotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
                
                [self.mapView1 addAnnotation:_annotation];
                self.mapView1.zoomLevel = 13;
                
                [self.mapView2 addAnnotation:_annotation];
                self.mapView2.zoomLevel = 16;
            });
        }
        else{
            [self showInfoMsg:model.msg];
        }
    }];
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
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.cell_phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        if ([mapView isEqual:_mapView1]) {
            annotationView.portrait = [UIImage imageNamed:@"map_point_small"];
        }
        else{
            annotationView.portrait = [UIImage imageNamed:@"map_point"];
        }
        
        
        return annotationView;
    }
    
    return nil;
}

//- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
//
//}

#pragma mark - getter setter

- (UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc] init];
        _videoView.backgroundColor = [UIColor clearColor];
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
        _smallVideoView.hidden = YES;
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
//        _mapView1.showsUserLocation = YES;
        _mapView1.userTrackingMode = MAUserTrackingModeNone;
        _mapView1.delegate = self;
        
    }
    return _mapView1;
}

- (MAMapView *)mapView2{
    if (!_mapView2) {
        _mapView2 = [[MAMapView alloc] init];
        _mapView2.zoomLevel = 16;
//        _mapView2.showsUserLocation = YES;
        _mapView2.userTrackingMode = MAUserTrackingModeNone;
        _mapView2.userInteractionEnabled = NO;
        _mapView2.delegate = self;
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
        VFWeakSelf(self)
        _playerView.playerReadyBlock = ^{
            weakself.smallVideoView.alpha = 0.0;
            weakself.smallVideoView.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                weakself.smallVideoView.alpha = 1.0;
            }];
        };
//        [_playerView setVedioURL:cloudURL];
    }
    
    return _playerView;
}

- (LTAVPlayerView *)playerView2{
    if (!_playerView2) {
        _playerView2 = [[LTAVPlayerView alloc] init];
//        [_playerView2 setVedioURL:cloudURL];
    }
    return _playerView2;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadLocationData) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
