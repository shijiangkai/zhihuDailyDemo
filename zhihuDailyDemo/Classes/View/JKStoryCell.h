//
//  JKStoryCell.h
//  1
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMWaterflowViewCell.h"

@class JKStory, HMWaterflowView;

@interface JKStoryCell : HMWaterflowViewCell

/**返回一个瀑布流的cell */
+ (instancetype)cellWithWaterflowView:(HMWaterflowView *)waterflowView;

/**日报模型 */
@property (nonatomic, strong) JKStory *story;

@end
