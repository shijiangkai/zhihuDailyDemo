//
//  JKNavItem.h
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/6/30.
//  Copyright (c) 2015年 史江凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKNavItem : NSObject
+ (UIBarButtonItem *)navItemWithTarget:(id)target action:(SEL)selector image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
