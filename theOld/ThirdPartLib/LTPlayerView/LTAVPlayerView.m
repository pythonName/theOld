//
//  LTAVPlayerView.m
//  HelloWorld
//
//  Created by test on 2017/12/25.
//  Copyright © 2017年 test. All rights reserved.
//

#import "LTAVPlayerView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LTAVPlayerView()

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, copy) NSString *videoURL;

@end

static NSString *context = @"lixt";
static NSString *keyPath = @"status";

@implementation LTAVPlayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)addAVPlayer{
    [self.layer addSublayer:self.playerLayer];
    
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];

}

- (void)setVedioURL:(NSString *)videoURL{
    _videoURL = videoURL;
    
    [self addAVPlayer];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [_player play];
            if (self.playerReadyBlock) {
                self.playerReadyBlock();
            }
        }
    }
}

- (void)stopPlay{
    [_player pause];
//    [_playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)dealloc{
    [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [_playerLayer removeFromSuperlayer];
    _playerLayer = nil;
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    _playerItem = nil;
}

- (void)updatePlayerLayerFrame{
//    _playerLayer.frame = self.bounds;
    self.playerLayer.frame = self.bounds;
}

#pragma mark - getter setter

- (AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _player = [[AVPlayer alloc] init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _playerLayer;
}

- (AVPlayerItem *)playerItem{
    if (!_playerItem) {
        _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_videoURL]];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playerItem;
}

@end
