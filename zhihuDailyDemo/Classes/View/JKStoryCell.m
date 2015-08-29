//
//  JKStoryCell.m
//  1
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import "JKStoryCell.h"
#import "HMWaterflowView.h"
#import "UIImageView+WebCache.h"
#import "JKStory.h"

@interface JKStoryCell ()

/**配图 */
@property (weak, nonatomic) UIImageView *imageView;

/**文章标题 */
@property (weak, nonatomic) UILabel *titleLabel;
@end

@implementation JKStoryCell

+ (instancetype)cellWithWaterflowView:(HMWaterflowView *)waterflowView
{
    static NSString *ID = @"Story";
    JKStoryCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JKStoryCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor colorWithRed:54/255.0 green:156/255.0 blue:218/255.0 alpha:0.3];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)setStory:(JKStory *)story
{
    _story = story;
    
    self.titleLabel.text = story.title;
    NSString *imageName = story.images[0];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"zhihu"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat priceX = 0;
    CGFloat priceH = 40;
    CGFloat priceY = self.bounds.size.height - priceH;
//    CGFloat priceY = self.bounds.size.height;
    CGFloat priceW = self.bounds.size.width;
    self.titleLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
}

@end
