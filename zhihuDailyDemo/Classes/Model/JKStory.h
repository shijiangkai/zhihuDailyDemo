//
//  JKStory.h
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//  日报模型

#import <Foundation/Foundation.h>

@interface JKStory : NSObject

/**配图数组 */
@property (nonatomic, copy) NSArray *images;

//这里用id不妥。但在.m文件中，实现+replacedKeyFromPropertyName方法没成功
/**日报id */
@property (nonatomic, assign) NSUInteger id;

/**日报标题 */
@property (nonatomic, copy) NSString *title;

@end
