//
//  EOCAnimatorImageView.m
//  yc微信浮窗自定义
//
//  Created by 杨闯 on 2018/10/10.
//  Copyright © 2018年 杨闯. All rights reserved.
//

#import "EOCAnimatorImageView.h"

@interface EOCAnimatorImageView()<CAAnimationDelegate> {
    CAShapeLayer *shapelayer;
    UIView *toView;
}
@end
@implementation EOCAnimatorImageView

- (void)startAnimatewintView:(UIView *)theView fromeRect:(CGRect)fromrect toRect:(CGRect)torect{
    
    toView = theView;
    
    shapelayer = [CAShapeLayer layer];
    shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:fromrect cornerRadius:30.f].CGPath;
    self.layer.mask = shapelayer;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:torect cornerRadius:30.f].CGPath;
    anim.duration = .5f;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [shapelayer addAnimation:anim forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //动画完成
    toView.hidden = NO;
    [shapelayer removeAllAnimations];
    [self removeFromSuperview];
}
@end
