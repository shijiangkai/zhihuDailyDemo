//
//  ViewController.m
//  1
//
//  Created by 史江凯 on 15/8/28.
//  Copyright (c) 2015年 example. All rights reserved.
//

#import "ViewController.h"
#import "JKNavigationController.h"
#import "navTitleView.h"
#import "HMWaterflowView.h"
#import "AFNetworking.h"
#import "JKStory.h"
#import "JKStoryCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "JKStoryWebViewController.h"

@interface ViewController () <HMWaterflowViewDataSource, HMWaterflowViewDelegate>
/**存储story的数组 */
@property (nonatomic, copy) NSMutableArray *storiesArrayM;

@property (nonatomic, weak) HMWaterflowView *waterflowView;

@property (nonatomic, strong) JKNavigationController *navigationController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HMWaterflowView *waterflowView = [[HMWaterflowView alloc] init];
    // 跟随着父控件的尺寸而自动伸缩
    waterflowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterflowView.frame = self.view.bounds;
    waterflowView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    waterflowView.dataSource = self;
    waterflowView.delegate = self;

    UIViewController *VC = [[UIViewController alloc] init];
    JKNavigationController *nav = [[JKNavigationController alloc] initWithRootViewController:VC];
    self.navigationController = nav;

    navTitleView *titleView = [[navTitleView alloc] init];
    titleView.title = @"";
    VC.navigationItem.titleView = titleView;
    
    [VC.view addSubview:waterflowView];
    self.waterflowView = waterflowView;
    
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    
    [waterflowView addHeaderWithTarget:self action:@selector(loadNewShops)];
    [self.waterflowView headerBeginRefreshing];
}

- (void)loadNewShops
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        manager.operationQueue.maxConcurrentOperationCount = 1;
        
        [manager GET:@"http://news-at.zhihu.com/api/4/news/latest" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            self.storiesArrayM = [[JKStory objectArrayWithKeyValuesArray:responseObject[@"stories"]] copy];
            // 刷新瀑布流控件
            [self.waterflowView reloadData];
            // 停止刷新
            [self.waterflowView headerEndRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    });
}

- (NSUInteger)numberOfCellsInWaterflowView:(HMWaterflowView *)waterflowView
{
    return [self.storiesArrayM count];
}

- (HMWaterflowViewCell *)waterflowView:(HMWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    JKStoryCell *cell = [JKStoryCell cellWithWaterflowView:waterflowView];
    
    cell.story = self.storiesArrayM[index];
    
    return cell;
}

- (NSUInteger)numberOfColumnsInWaterflowView:(HMWaterflowView *)waterflowView
{
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        // 竖屏
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)waterflowView:(HMWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    return 150;
}

- (void)waterflowView:(HMWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    JKStoryCell *cell = [JKStoryCell cellWithWaterflowView:waterflowView];
    
    cell.story = self.storiesArrayM[index];
    JKStoryWebViewController *storyWebViewController = [[JKStoryWebViewController alloc] init];

    storyWebViewController.storyID = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%zd", cell.story.id];
    [self.navigationController pushViewController:storyWebViewController animated:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.waterflowView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
