//
//  JKStoryWebViewController.h
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/8/29.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKStoryWebViewController : UIViewController

/**每一篇日报的ID */
@property (nonatomic, copy) NSString *storyID;

/**保存了一大段的HTML代码 */
@property (nonatomic, copy) NSString *HTMLString;

@end
