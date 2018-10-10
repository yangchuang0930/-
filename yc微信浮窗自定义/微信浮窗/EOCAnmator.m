//
//  EOCAnmator.m
//  yc微信浮窗自定义
//
//  Created by 杨闯 on 2018/10/10.
//  Copyright © 2018年 杨闯. All rights reserved.
//

#import "EOCAnmator.h"
#import "EOCAnimatorImageView.h"

@implementation EOCAnmator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.f;//跳转的动画时间
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //transitionContext 包含了 fromVIew fromViewController toView toviewController centainerview
    // a-跳转-b
    UIView *centainerView = [transitionContext containerView];
    UIView *toview = [transitionContext viewForKey:UITransitionContextToViewKey];
    [centainerView addSubview:toview];//
    
    EOCAnimatorImageView *image = [[EOCAnimatorImageView alloc]initWithFrame:toview.bounds];
    [centainerView addSubview:image];
    //截屏
    UIGraphicsBeginImageContext(toview.frame.size);
    [toview.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    [image setImage:UIGraphicsGetImageFromCurrentImageContext()];
    toview.hidden = YES;
    //image 他是floatingbtn的frame 展开的toView的frame
    
    [image startAnimatewintView:toview fromeRect:_rectFrame toRect:toview.frame];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES];//移除fromview he  fromviewController
    });
    
}
@end
