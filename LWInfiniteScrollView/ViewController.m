//
//  ViewController.m
//  LWInfiniteScrollView
//
//  Created by li010 on 2017/8/7.
//  Copyright © 2017年 li010. All rights reserved.
//

#import "ViewController.h"
#import "LWInfiniteScrollViewHelper.h"
#import "LWImageModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LWInfiniteScrollViewHelper *view = [[LWInfiniteScrollViewHelper  alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    LWImageModel *model1 = [[LWImageModel alloc] initWithImageNamge:@"1" pushURL:@"www.1.com"];
    LWImageModel *model2 = [[LWImageModel alloc] initWithImageNamge:@"2" pushURL:@"www.2.com"];
    LWImageModel *model3 = [[LWImageModel alloc] initWithImageNamge:@"3" pushURL:@"www.3.com"];
    LWImageModel *model4 = [[LWImageModel alloc] initWithImageNamge:@"4" pushURL:@"www.4.com"];
    view.imageArr = @[model1, model2, model3, model4];
    view.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    view.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    view.tapActionBlock = ^(id model) {
        LWImageModel *imageModel = model;
        NSLog(@"点击需要跳转的信息 = %@",imageModel.pushURL);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
