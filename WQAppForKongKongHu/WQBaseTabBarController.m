//
//  WQBaseTabBarController.m
//  WQAppForKongKongHu
//
//  Created by 王祺祺 on 2016/10/28.
//  Copyright © 2016年 wangqiqi. All rights reserved.
//

#import "WQBaseTabBarController.h"

@interface WQBaseTabBarController ()

@end

@implementation WQBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem * item1 = [self.tabBar.items objectAtIndex:0];
    [self createItem:item1 defaultImage:@"tab_icon_home" selectImage:@"tab_icon_home_pressed"];
    UITabBarItem * item2 = [self.tabBar.items objectAtIndex:1];
    [self createItem:item2 defaultImage:@"tab_icon_fo" selectImage:@"tab_icon_fo_pressed"];
    
    UITabBarItem * item3 = [self.tabBar.items objectAtIndex:2];
    [self createItem:item3 defaultImage:@"tab_icon_publish" selectImage:@"tab_icon_publish_pressed"];
    
    UITabBarItem * item4 = [self.tabBar.items objectAtIndex:3];
    [self createItem:item4 defaultImage:@"tab_icon_message" selectImage:@"tab_icon_message_pressed"];
   
    UITabBarItem * item5 = [self.tabBar.items objectAtIndex:4];
    [self createItem:item5 defaultImage:@"tab_icon_user" selectImage:@"tab_icon_user_pressed"];
    


}

-(void)createItem:(UITabBarItem *)item defaultImage:(NSString *)deImage selectImage:(NSString *)selImage
{
    item.image = [[UIImage imageNamed:deImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
}
@end
