//
//  JKNavItem.m
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/6/30.
//  Copyright (c) 2015年 史江凯. All rights reserved.
//

#import "JKNavItem.h"

@implementation JKNavItem

+ (UIBarButtonItem *)navItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置两种状态下的图片
    [item setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    //设置尺寸
    item.frame = CGRectMake(0, 0, item.currentBackgroundImage.size.width, item.currentBackgroundImage.size.width);
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

@end
