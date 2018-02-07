//
//  ViewController.m
//  NewsHD
//
//  Created by PrinceMei on 2018/2/7.
//  Copyright © 2018年 Fsociety. All rights reserved.
//

#import "ViewController.h"

#import "HeadlineViewController.h"
#import "HotspotViewController.h"
#import "SocietyViewController.h"
#import "SubscribeViewController.h"
#import "ScienceViewController.h"
#import "VideoViewController.h"

@interface ViewController ()

@property (nonatomic,weak) UIScrollView *titleScrollView;
@property (nonatomic,weak) UIScrollView *contentScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //0. 添加标题
    self.navigationItem.title = @"网易新闻";
    
    
    //1. 添加标题滚动视图
    
    [self setupTitleScrollView];
    
    //2. 添加内容滚动视图
    
    
    [self setupContentScrollView];
    
    //3. 创建标题视图控制器
    [self setupAllChildTitesViewController];
    
    //4. 设置所有顶部标题
    [self setupAllTitles];
}

#pragma mark --添加题滚动视图
- (void)setupTitleScrollView{
    
   
    //创建titleScrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    titleScrollView.backgroundColor = [UIColor redColor];
    CGFloat y = self.navigationController.navigationBarHidden? 20 : 64;
    
    titleScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, 44);
    
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
}


#pragma mark --添加内容滚动视图
- (void)setupContentScrollView{
    
    //创建titleScrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.backgroundColor = [UIColor greenColor];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    
    contentScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y);
    
    
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
}

#pragma mark --创建标题视图控制器

- (void)setupAllChildTitesViewController{
    //头条
    HeadlineViewController *vc1 = [[HeadlineViewController alloc] init];
    vc1.title = @"头条";
    [self addChildViewController:vc1];
    
    //热点
    HotspotViewController *vc2 = [[HotspotViewController alloc] init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    
    
    //视频
    VideoViewController *vc3 = [[VideoViewController alloc] init];
    vc3.title = @"视频";
    [self addChildViewController:vc3];
    
    //社会
    SocietyViewController *vc4 = [[SocietyViewController alloc] init];
    vc4.title = @"社会";
    [self addChildViewController:vc4];
    
    //订阅
    SubscribeViewController *vc5 = [[SubscribeViewController alloc] init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    
    //科技
    ScienceViewController *vc6 = [[ScienceViewController alloc] init];
    vc6.title = @"科技";
    [self addChildViewController:vc6];
    
    
}


#pragma mark --设置所有顶部标题
- (void)setupAllTitles{

    NSInteger count = self.childViewControllers.count;
     CGFloat btnX = 0;
     CGFloat btnH = self.titleScrollView.bounds.size.height;
     CGFloat btnW = 100;
    
    for (int i= 0; i< count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [self.titleScrollView addSubview:btn];
        
        
    }
    
    self.titleScrollView.contentSize = CGSizeMake(btnW * count, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
