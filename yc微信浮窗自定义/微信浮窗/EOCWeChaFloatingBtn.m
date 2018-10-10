//
//  EOCWeChaFloatingBtn.m
//  yc微信浮窗自定义
//
//  Created by 杨闯 on 2018/10/10.
//  Copyright © 2018年 杨闯. All rights reserved.
//

#import "EOCWeChaFloatingBtn.h"
#import "EOCSemiCieView.h"
#import "EOCMextiewController.h"
#import "EOCAnmator.h"

@interface EOCWeChaFloatingBtn ()<UINavigationControllerDelegate>{
    CGPoint lastPoint;
    CGPoint pointSelf;
}

@end

@implementation EOCWeChaFloatingBtn
static EOCWeChaFloatingBtn *flotaingBtn;
static EOCSemiCieView *semicieView;
#define fixedSpace 160.f

+ (void)show{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        flotaingBtn = [[EOCWeChaFloatingBtn alloc] initWithFrame:CGRectMake(10.f, 200.f, 60.f, 60.f)];
        semicieView = [[EOCSemiCieView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace)];
    });
    if (!semicieView.superview) {
        semicieView.layer.contents = (__bridge id)[UIImage imageNamed:@"人"].CGImage;
        //添加到界面
        [[[UIApplication sharedApplication]keyWindow] addSubview:semicieView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semicieView];
    }
    if (!flotaingBtn.superview) {
        //添加到界面
        [[[UIApplication sharedApplication]keyWindow] addSubview:flotaingBtn];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:flotaingBtn];
    }
    flotaingBtn.frame = CGRectMake(10.f, 200.f, 60.f, 60.f);
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"人"].CGImage;
    
    return self;
}
#pragma mark - UItouch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    pointSelf = [touch locationInView:self];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *tuch = [touches anyObject];
    CGPoint currentPoint = [tuch locationInView:self.superview];
    
    //四分之一圆动画暂开
    if (CGRectEqualToRect(semicieView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
        semicieView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - fixedSpace, [UIScreen mainScreen].bounds.size.height - fixedSpace, fixedSpace, fixedSpace);
    }
    
    ///计算出来控件的flotaingBtn的center坐标
    CGFloat centerX = currentPoint.x + (self.frame.size.width/2 - pointSelf.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height/2 - pointSelf.y);
    
    ///限制flotaingBtn的center的坐标不超过屏幕范围
//    30.f <= X <= [UIScreen mainScreen].bounds.size.width - 30.f;
//    30.f <= Y <= [UIScreen mainScreen].bounds.size.width - 30.f;
    CGFloat X = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.width - 30.f, centerX));
    CGFloat Y = MAX(30.f, MIN([UIScreen mainScreen].bounds.size.height - 30.f, centerY));
    self.center = CGPointMake(X, Y);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *tuch = [touches anyObject];
    CGPoint currentPoint = [tuch locationInView:self.superview];
    if(CGPointEqualToPoint(lastPoint, currentPoint)){
        //这是点击效果
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.delegate = self;
        EOCMextiewController *nextViewCtrl = [EOCMextiewController new];
        [nav pushViewController:nextViewCtrl animated:YES];
        return;
    }
    
    //四分之一圆动画收缩
    [UIView animateWithDuration:0.2f animations:^{
        
        //判断self和右下角的center直接的距离
        CGFloat disOver = sqrt(pow([UIScreen mainScreen].bounds.size.width - self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height - self.center.y, 2));
        if (disOver <= fixedSpace - 30.f) {
            [self removeFromSuperview];
        }
        
        semicieView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
    }];

    
    //离左右两侧的距离
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(40, self.center.y);
        }];
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, self.center.y);
        }];
    }
}


#pragma mark - UINavigationController delegate method==-=-=-=-=
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if(operation == UINavigationControllerOperationPush){
        EOCAnmator *animer = [EOCAnmator new];
        animer.rectFrame = self.frame;
        return animer;
    }
    return nil;
}



















@end
