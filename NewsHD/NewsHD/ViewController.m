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

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *titleScrollView;
@property (nonatomic,weak) UIScrollView *contentScrollView;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,strong) NSMutableArray *titleBtns;

@end

@implementation ViewController

//懒加载
- (NSMutableArray *)titleBtns{
    
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    
    return _titleBtns;
}

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
    //iOS7 以后，导航控制器中ScrollView顶部会添加64的额外滚动区域，需如下设置去掉
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //5. 处理标题点击
}

#pragma mark --添加题滚动视图
- (void)setupTitleScrollView{
    
    //创建titleScrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    //titleScrollView.backgroundColor = [UIColor redColor];
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
    
    //设置ContentScrollView的属性
    
    //弹簧
    self.contentScrollView.bounces = NO;
    //分页
    self.contentScrollView.pagingEnabled = YES;
    //指示器
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    self.contentScrollView.delegate = self;
    
    
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

#pragma mark --选中标题 (封装)
- (void)setSelectedBtn:(UIButton *)button
{
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectedBtn = button;
    
}

#pragma mark --设置所有顶部标题
- (void)setupAllTitles{

    NSInteger count = self.childViewControllers.count;
     CGFloat btnX = 0;
     CGFloat btnH = self.titleScrollView.bounds.size.height;
     CGFloat btnW = 100;
    //监听按钮点击
    for (int i= 0; i< count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [btn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        //把标题按钮保存到对应的数组
        [self.titleBtns addObject:btn];
        
        //默认选中第一个
        if (i== 0) {
            [self titleClicked:btn];
        }
        
        
        [self.titleScrollView addSubview:btn];
        
        
    }
    //设置标题的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(btnW * count, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置内容的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);
}


#pragma mark --处理标题点击
- (void)titleClicked:(UIButton*)button{
    
    NSInteger index = button.tag;
       //1. 标题颜色变色
    [self setSelectedBtn:button];
    
       //2. 把对应的子控制器的view添加上去
//    UIViewController *vc = self.childViewControllers[i];
//    CGFloat x = i * ScreenW;
//    vc.view.frame = CGRectMake(x, 0, ScreenW,
//
//    self.contentScrollView.bounds.size.height);
//
//
//    [self.contentScrollView addSubview:vc.view];
    
    [self addSubControllerView:index];
    
    CGFloat x = index * ScreenW;
       //3.内容滚动视图滚动到对应的位置
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}

#pragma mark --把对应的子控制器的view添加上去

- (void)addSubControllerView:(NSInteger)index{
    
    // 把对应的子控制器的view添加上去
    UIViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) {//vc.viewLoaded   //>=ios9
        return;
    }
    
    CGFloat x = index * ScreenW;
    vc.view.frame = CGRectMake(x, 0, ScreenW,
                               
                               self.contentScrollView.bounds.size.height);
    
    
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取标题按钮当前下标
    NSInteger  index = scrollView.contentOffset.x / ScreenW;
    //获取标题按钮
   // UIButton *titleBtn = self.titleScrollView.subviews[index];
     UIButton *titleBtn = self.titleBtns[index];
    //1.选中标题（按钮）
    [self setSelectedBtn:titleBtn];
    //2. 把对应的子控制器的view添加上去
    [self addSubControllerView:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
