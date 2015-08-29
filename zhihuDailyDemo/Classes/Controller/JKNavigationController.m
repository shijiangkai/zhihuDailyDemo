//
//  JKNavigationController.m
//  zhihuDailyDemo
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import "JKNavigationController.h"
#import "UIImage+Tools.h"
#import "JKNavItem.h"

@interface JKNavigationController ()

@end

@implementation JKNavigationController


+ (void)initialize
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:3/255.0 green:156/255.0 blue:217/255.0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //不是根控制器时才需要显示左右两侧的navigationItem
    if (self.viewControllers.count > 0) {
        //利用自定义navItem设置左右两侧的navItem
        viewController.navigationItem.leftBarButtonItem = [JKNavItem navItemWithTarget:self action:@selector(back) image:@"navigationbar_back" selectedImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [JKNavItem navItemWithTarget:self action:@selector(more) image:@"navigationbar_more" selectedImage:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
