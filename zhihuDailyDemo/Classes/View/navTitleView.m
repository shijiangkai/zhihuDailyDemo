//
//  navTitleView.m
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import "navTitleView.h"
#import "UIView+Extension.h"

@implementation navTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        [self setImage:[UIImage imageNamed:@"zhihu_titleBtn"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    [self setTitle:title forState:UIControlStateNormal];
    
    self.height = self.currentImage.size.height;
    
    NSDictionary *attrDict = @{ NSFontAttributeName : self.titleLabel.font};
    
    CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size.width;

    //宽度等于图片宽度加文字宽度加文字偏移量
    self.width = self.currentImage.size.width + titleWidth + self.titleEdgeInsets.left;
}

@end
