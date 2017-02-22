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
//真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
//遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

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
    
    [self.layer addSublayer:self.maskWaveLayer];
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

- (CAShapeLayer *)maskWaveLayer{
    
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        CGRect frame = [self bounds];
        frame.origin.y = 0;
        frame.size.height = self.waveHeight;
        _maskWaveLayer.frame = frame;
        _maskWaveLayer.fillColor = self.waveColor.CGColor ;
    }
    return _maskWaveLayer;
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
    _maskWaveLayer.frame = frame1;
    
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
    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height);
    for (CGFloat x = 0.f; x <= width ; x++) {
        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
        
        maskY = height * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045); ;
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    
    //变化的中间Y值
    CGFloat centX = self.bounds.size.width/2;
    CGFloat CentY = height * sinf(0.01 * self.waveCurvature *centX  + self.offset * 0.045);
    if (self.waveBlock) {
        self.waveBlock(CentY);
    }
    
    CGPathAddLineToPoint(path, NULL, width, self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.waveColor.CGColor;
    CGPathRelease(path);
    
    CGPathAddLineToPoint(maskpath, NULL, width, self.frame.size.height);
    CGPathAddLineToPoint(maskpath, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(maskpath);
    self.maskWaveLayer.path = maskpath;
    self.maskWaveLayer.fillColor = self.waveColor.CGColor;
    CGPathRelease(maskpath);
    
}

@end
