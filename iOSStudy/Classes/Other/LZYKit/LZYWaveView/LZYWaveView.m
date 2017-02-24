//
//  LZYWaveView.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/22.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "LZYWaveView.h"

@interface JSProxy : NSObject

@property (weak, nonatomic) id executor;

@end

@implementation JSProxy

- (void)callback {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [_executor performSelector:@selector(wave)];
#pragma clang diagnostic pop
    
}

@end


@interface LZYWaveView ()

//刷屏器
@property (nonatomic, strong) CADisplayLink *timer;

//真实浪(默认有0.6透明度)
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;

//背景浪
@property (nonatomic, strong) CAShapeLayer *backgroundWaveLayer;

//偏移量
@property (nonatomic, assign) CGFloat offset;


@end

@implementation LZYWaveView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initData];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    //初始化
    self.waveSpeed = 0.1;
    self.waveCurvature = 1.5;
    self.waveHeight = 6;
    
    self.waveColor = [[UIColor blueColor] colorWithAlphaComponent:0.6];
    self.backgroundWaveColor = [UIColor blueColor];
    
    [self.layer addSublayer:self.backgroundWaveLayer];
    [self.layer addSublayer:self.realWaveLayer];
    self.backgroundColor = [UIColor clearColor];
}

- (CAShapeLayer *)realWaveLayer{
    
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y =0;
        frame.size.height = self.waveHeight;
        _realWaveLayer.frame = frame;
        _realWaveLayer.fillColor = self.waveColor.CGColor;
    
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)backgroundWaveLayer{
    
    if (!_backgroundWaveLayer) {
        _backgroundWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = 0;
        frame.size.height = self.waveHeight;
        _backgroundWaveLayer.frame = frame;
        _backgroundWaveLayer.fillColor = self.backgroundWaveColor.CGColor ;
    }
    return _backgroundWaveLayer;
}

- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    
    CGRect frame = [self bounds];
    frame.origin.y = 0;
    frame.size.height = 0;
    _realWaveLayer.frame = frame;
    
    CGRect frame1 = [self bounds];
    frame1.origin.y = frame1.size.height-self.waveHeight;
    frame1.size.height = self.waveHeight;
    _backgroundWaveLayer.frame = frame1;
    
}

- (void)setWaveColor:(UIColor *)waveColor
{
    _waveColor = [waveColor colorWithAlphaComponent:0.6];

}

- (void)startWaveAnimation{
    JSProxy *proxy = [[JSProxy alloc] init];
    proxy.executor = self;
    self.timer = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(callback)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopWaveAnimation{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave{
    
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveHeight;
    
    //真实浪
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = 0.f;
    
    //遮罩浪
    CGMutablePathRef backgroundpath = CGPathCreateMutable();
    CGFloat y2 = 0.f;
    
    //左侧起点
    CGPathMoveToPoint(path, NULL, 0, height *sinf(self.offset * 0.045));
    
    //背景浪起点
    CGPathMoveToPoint(backgroundpath, NULL, 0,MAX(height *sinf(self.offset * 0.045), height *cosf(self.offset * 0.045)) );
    
    for (CGFloat x = 0.f; x <= width ; x++) {

        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
        y2 = height * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045); ;
        CGPathAddLineToPoint(backgroundpath, NULL, x, MAX(y, y2));
    }
    
    //背景浪结束绘制（右下角->左下角->起点）
    CGPathAddLineToPoint(backgroundpath, NULL, width, self.frame.size.height);
    CGPathAddLineToPoint(backgroundpath, NULL, 0, self.frame.size.height);
    CGPathMoveToPoint(backgroundpath, NULL, 0,MAX(height *sinf(self.offset * 0.045), height *cosf(self.offset * 0.045)) );
    
    CGPathCloseSubpath(backgroundpath);
    self.backgroundWaveLayer.path = backgroundpath;
    self.backgroundWaveLayer.fillColor = self.backgroundWaveColor.CGColor;
    CGPathRelease(backgroundpath);
    
    for (CGFloat x = width; x >= 0; x--) {
        y = height * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045); ;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    //浪花回到起点
    CGPathAddLineToPoint(path, NULL,0, height *sinf(self.offset * 0.045));
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.waveColor.CGColor;
    CGPathRelease(path);
    
}

@end
