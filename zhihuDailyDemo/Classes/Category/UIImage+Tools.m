//
//  UIImage+Tools.m
//  屏幕截屏 +带圆环的圆形图片
//
//  Created by 史江凯 on 15/6/6.
//  Copyright (c) 2015年 史江凯. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

+ (instancetype)imageWithView:(UIView * )view
{
    //    开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //    获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    渲染
    [view.layer renderInContext:context];
    //    获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //    关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
    
}
+ (instancetype)circletRoundImageWithName:(NSString *)name border:(CGFloat)border color:(UIColor *)color
{
    CGFloat borderW = border;//圆环宽度
    UIImage *oldImage = [UIImage imageNamed:name];
    //    新图片所在正方形的尺寸 ＝ 旧图片 ＋ 2倍的圆环宽度
    CGFloat imageW = oldImage.size.width + 2 * borderW;
    CGFloat imageH = oldImage.size.height + 2 * borderW;
    //    比较长和宽，确保是正方形
    CGFloat circleW = imageW < imageH ? imageW : imageH;
    //    以新尺寸开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    //    正切于新尺寸的圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    
    //    获得当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    添加到上下文
    CGContextAddPath(context, path.CGPath);
    [color set];//填充红色
    //    绘制当前路径，填充，得到一个大圆
    CGContextFillPath(context);
    
    //  和原来的图片大小相等的CGRect，中心点于大圆重合，即大圆的内接正方形
    CGRect clipR = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
    //  正切于正方形的圆形路径
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    //    添加到裁剪区
    [clipPath addClip];
    //   在裁剪区绘制旧图片
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    //    获得新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //    关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
