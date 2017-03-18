//
//  AppDelegate.m
//  LocalNotification
//
//  Created by 孙承秀 on 16/12/23.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerNotification];
    
    
    UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, 300)];
    text.text = launchOptions.description;
    [self.window.rootViewController.view addSubview:text];
    // launchOptions,
    NSLog(@"%@",launchOptions);
    // 是点击通知进来的,是用户点击了本地通知，启动的app,这里只有在app被强制退出的时候，点击通知进来的时候才会被调用，否则不会被调用.
    if (launchOptions != nil) {
        
        if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]
 != nil) {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"通知" message:@"您收到一条消息，从app退出的情况下进入的" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert1 show];
            self.window.rootViewController.view.backgroundColor= [UIColor greenColor];
            NSLog(@"从后台进入前台了");
            self.window.rootViewController.view.backgroundColor = [UIColor redColor];
        }
           }
    return YES;
}

#pragma mark - 注册通知,ios 8.0 之后
- (void)registerNotification{

    
    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    
    // 创建一组行为
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    // 设置组标识
    category.identifier = @"localNotification";
    
    // 添加行为
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc]init];
    // 设置行为标识
    action.identifier = @"shuaige";
    action.title = @"帅哥";
    
    // 用户点击这个动作，只在前台点击的还是在后台点击的，后台模式，当弹出输入框输入信息之后，点击确定不会进入到APP不会进入到前台，依然停留在后台.
    action.activationMode = UIUserNotificationActivationModeBackground;
    
    // 必须要被解锁行为才会被执行，如果mode为前台则这个设置无效
    action.authenticationRequired = NO;
    
    // 是否为破坏性行为，会用一个红色的按钮形式来显示
    action.destructive = YES;
    
    // 行为2
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc]init];
    action1.identifier = @"美女";
    action1.title = @"美女";
    // 前台模式的话，弹出输入框，输入内容后点击进来会进入到程序里面。进入到前台
    action1.activationMode = UIUserNotificationActivationModeForeground;
    action1.behavior = UIUserNotificationActionBehaviorTextInput;
    action1.parameters = @{UIUserNotificationTextInputActionButtonTitleKey : @"进来"};
    
    // 需要解锁后才可以输入
    action1.authenticationRequired = YES;
    action1.destructive = NO;
    
    // ios9.0之后
    // 会出现一个输入框
    action.behavior = UIUserNotificationActionBehaviorTextInput;
    action.parameters = @{UIUserNotificationTextInputActionButtonTitleKey : @"来吧"};
    [category setActions:@[action , action1] forContext:UIUserNotificationActionContextMinimal];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:[NSSet setWithObject:category]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 接收到通知，当接收到通知，点击通知，从后台进入到前台调用的方法
// 当这个程序完全关闭的时候，不会受到这个方法.此方法只有在不被推出的时候调用
// 这个方法即使是在前台也会调用
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"接收到通知");
    // 当点击通知的时候一些处理方法
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    // UIApplicationStateActive, 前台
    // UIApplicationStateInactive, 从后台进入前台
    // UIApplicationStateBackground 后台
    switch (state) {
            // 当在前台的时候，比如QQ就通知有多少条消息就行
        case UIApplicationStateActive:
        {
            // 在前台的时候，比如说QQ或者一些新闻APP，不会跳转到对应的界面，知识做一个提示
            NSLog(@"在前台");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通知" message:@"您收到一条消息，当前在前台" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
            self.window.rootViewController.view.backgroundColor= [UIColor orangeColor];
            break;
        }
            // 当储蓄退出到后台，点击通知进入到前台的时候，再做一些处理，比如说跳转到响应的界面
        case UIApplicationStateInactive:
        {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"通知" message:@"您收到一条消息，当前从后台进入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert1 show];
            self.window.rootViewController.view.backgroundColor= [UIColor greenColor];
            NSLog(@"从后台进入前台了");
            break;
        }
        case UIApplicationStateBackground:
            NSLog(@"后台");
            break;
        default:
            break;
    }
    

}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    NSLog(@"---%@",identifier);
    completionHandler();
}
// 9.0之后,如果执行了这个方法，上面的方法就不执行了
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler{

    NSLog(@"%@------%@",identifier,responseInfo);
    completionHandler();
}


@end
