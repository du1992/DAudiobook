//
//  UIColor+ZN.m
//  Star
//
//  Created by JUNE_EN on 15/6/8.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "UIColor+ZN.h"

@implementation UIColor (ZN)
+ (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image {
    
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:
                          inImage];
    
    if (cgctx == NULL) { return nil; /* error */ }
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
//        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,
//              blue,alpha);
//        
//        NSLog(@"x:%f y:%f", point.x, point.y);
        
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
                 (blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    CGContextRelease(cgctx);
    
    if (data) { free(data); }
    
    return color;
    
}
+ (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    
    CGColorSpaceRef colorSpace;
    
    void *          bitmapData;
    
    int             bitmapByteCount;
    
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow   = (int)(pixelsWide * 4);
    
    bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
        
    {
        
        fprintf(stderr, "Error allocating color space\n");
        
        return NULL;
        
    }
    
    bitmapData = malloc( bitmapByteCount );
    
    if (bitmapData == NULL)
        
    {
        
        fprintf (stderr, "Memory not allocated!");
        
        CGColorSpaceRelease( colorSpace );
        
        return NULL;
        
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     
                                     pixelsWide,  
                                     
                                     pixelsHigh,  
                                     
                                     8,        
                                     
                                     bitmapBytesPerRow,  
                                     
                                     colorSpace,  
                                     
                                     kCGImageAlphaPremultipliedLast);  
    
    if (context == NULL)  
        
    {  
        
        free (bitmapData);  
        
        fprintf (stderr, "Context not created!");  
        
    }  
    
    CGColorSpaceRelease( colorSpace );  
    
    return context;  
    
}
@end
