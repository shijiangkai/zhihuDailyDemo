//
//  UIImage+Tools.h
//  屏幕截屏  带圆环的圆形图片
//
//  Created by 史江凯 on 15/6/6.
//  Copyright (c) 2015年 史江凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

+ (instancetype)imageWithView:(UIView * )view;//屏幕截屏，

/**带圆环的圆形图片*/
+ (instancetype)circletRoundImageWithName:(NSString *)name border:(CGFloat)border color:(UIColor *)color;

/**根据颜色返回图片*/
+ (instancetype)imageWithColor:(UIColor *)color;
@end
