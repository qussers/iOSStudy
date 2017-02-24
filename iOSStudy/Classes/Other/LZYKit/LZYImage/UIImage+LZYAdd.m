//
//  UIImage+LZYAdd.m
//  iOSStudy
//
//  Created by 李志宇 on 17/2/23.
//  Copyright © 2017年 izijia. All rights reserved.
//

#import "UIImage+LZYAdd.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (LZYAdd)

- (UIImage *)blurImageWithRadius:(CGFloat)radius
{
    /*---------------coreImage-------------*/
    // CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    
    // CIFilter,高斯模糊
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    // 将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    // 设置模糊程度
    [blurFilter setValue:@(radius) forKey:@"inputRadius"];
    
    // 用来查询滤镜可以设置的参数以及一些相关的信息
    NSLog(@"%@", [blurFilter attributes]);
    
    // 将处理好的图片输出
    CIImage *outCIImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIContext
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // 获取CGImage句柄
    CGImageRef outCGImage = [context createCGImage:outCIImage fromRect:[outCIImage extent]];
    
    // 最终获取到图片
    UIImage *blurImage = [UIImage imageWithCGImage:outCGImage];
    
    // 释放CGImage句柄
    CGImageRelease(outCGImage);
    /*-----------------------------------------------------*/

    return blurImage;
}

- (UIImage *)blurryImageWithLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


@end
