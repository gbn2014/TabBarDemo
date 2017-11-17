//
//  BaseTabBarViewController.m
//  HappyWawa
//
//  Created by RGBVR-LiZhi on 10/30/17.
//  Copyright © 2017 王晗. All rights reserved.
//

#import "BaseTabBarViewController.h"

#import "HomeCtrl.h"
#import "MyDollCtrl.h"
#import "MyCtrl.h"
#import "MyControlViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChildViewControllers: self];
}

- (void)initChildViewControllers: (UITabBarController *)tabBarController {
    // Tab Bar Items - 0
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabbar_home", nil) image:[UIImage imageNamed:@"tabbar_home_deselect"] tag:0];
    [homeItem setSelectedImage:[UIImage imageNamed:@"tabbar_home"]];
    // Tab Bar Items - 1
    UITabBarItem *dollItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabbar_my_doll", nil) image:[UIImage imageNamed:@"tabbar_my_doll_deselect"] tag: 1];
    [dollItem setSelectedImage:[UIImage imageNamed:@"tabbar_my_doll"]];
    // Tab Bar Items - 2
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"tabbar_mine", nil) image:[UIImage imageNamed:@"tabbar_mine_deselect"] tag:2];
    [mineItem setSelectedImage:[UIImage imageNamed:@"tabbar_mine"]];
    
    // 首页
    HomeCtrl *homeVC = [[HomeCtrl alloc] init];
    [homeVC setTabBarItem: homeItem];
    
    ScreenRotationViewController *srvc1 = [[ScreenRotationViewController alloc] initWithRootViewController:homeVC];
    [srvc1 setNavigationBarHidden:true];
    [srvc1 setHidesBottomBarWhenPushed:true];

    // 我的娃娃
    MyDollCtrl *myDollVC = [[MyDollCtrl alloc] init];
    myDollVC.isOther = NO;
    [myDollVC setTabBarItem:dollItem];
    
    ScreenRotationViewController *srvc2 = [[ScreenRotationViewController alloc] initWithRootViewController:myDollVC];
    [srvc2 setNavigationBarHidden:true];
    [srvc2 setHidesBottomBarWhenPushed:true];

    // 我的
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    MyControlViewController *myVC = [sb instantiateViewControllerWithIdentifier:@"MyControl"];
    [myVC setTabBarItem:mineItem];
    
    ScreenRotationViewController *srvc3 = [[ScreenRotationViewController alloc] initWithRootViewController:myVC];
    [srvc3 setNavigationBarHidden:true];
    [srvc3 setHidesBottomBarWhenPushed:true];

    [tabBarController addChildViewController:srvc1];
    [tabBarController addChildViewController:srvc2];
    [tabBarController addChildViewController:srvc3];
    
    [tabBarController.tabBar setTintColor:[GenericTools colorForHex:Tabbar_Theme_Color]];
    tabBarController.hidesBottomBarWhenPushed = true;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger selectIndex = [tabBar.items indexOfObject:item];
    [self animationWithIndex:selectIndex];
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews)
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
            [tabbarbuttonArray addObject:tabBarButton];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@1.2,@1.1,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [[tabbarbuttonArray[index] layer] addAnimation:animation forKey:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
