//
//  ViewController.m
//  LocalNotification
//
//  Created by 孙承秀 on 16/12/23.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发送通知按钮
    UIButton *sendBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2, 100, 100, 50)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"发送通知" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendNotification) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:sendBtn];
    
    // 取消发送通知按钮
    UIButton *cancelSendBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2, 200, 100, 50)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"取消通知" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancelSendNotification) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:cancelSendBtn];
    
    // 查看通知按钮
    UIButton *viewBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2, 300, 100, 50)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"查看通知" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(viewNotification) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:viewBtn];
}

#pragma mark - 发送通知
- (void)sendNotification{

    // 创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.category = @"localNotification";
    // 通知内容
    localNotification.alertBody = @"帅哥，进来一下呗";
    
    // 设置锁屏滑动文字
    localNotification.hasAction = YES;
    localNotification.alertAction = @"进去";
    
    // 设置滑动通知的时候的启动图片,ios 9.0之后基本不好用
    localNotification.alertLaunchImage = @"LaunchImage1";
    
    // 设置通知出现在通知中心的时候，标题，iOS8.2之后
    localNotification.alertTitle = @"斗地主";
    
    // 设置通知的声音
    //localNotification.soundName = @"";
    
    // 设置通知的个数显示
    localNotification.applicationIconBadgeNumber = 2;
    
    // 通知触发时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    
    
    // 触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

// 取消发送通知
- (void)cancelSendNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

// 查看通知
- (void)viewNotification{

    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@",arr);

}
@end
