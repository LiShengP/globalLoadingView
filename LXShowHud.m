//
//  LXShowHud.m
//  LingXi
//
//  Created by lsp on 2020/6/24.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import "LXShowHud.h"
#import "LXLoadingView.h"

@interface LXShowHud () <MBProgressHUDDelegate>

{
    MBProgressHUD *_hud;
}

@property (nonatomic, assign) LXLoadingViewType hudType;
@property (nonatomic, assign) MBProgressHUDAnimation animationStyle;
@property (nonatomic, copy) NSString * text;//显示的文字
@property (nonatomic, copy) UIColor * textColor;//显示的文字颜色

@end

@implementation LXShowHud

- (instancetype)initWithView:(UIView *)view
{
    if (!view) {
        return nil;
    }
    if (self = [super init]) {
        //自定义view
        _hud = [[MBProgressHUD alloc] initWithView:view];
        //取消背景框
        _hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.f];
        _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        [view addSubview:_hud];
    }
    return self;
}

+ (instancetype)showHudInView:(UIView *)view Text:(NSString *)text textColor:(UIColor *)color hudType:(LXLoadingViewType)hudType {
    LXShowHud * hud = [[LXShowHud alloc] initWithView:view];
    hud.text = text;
    hud.textColor = color;
    hud.hudType = hudType;
    [hud animationShow:YES];
    return hud;
}

-(void)animationShow:(BOOL)show {
    //自定义
    LXLoadingView *loadingView = [[LXLoadingView alloc]initWithType:_hudType text:_text textColor:_textColor];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.animationType = MBProgressHUDAnimationFade;
    _hud.delegate = self;
    _hud.customView = loadingView;
    [_hud showAnimated:YES];
}

-(MBProgressHUDAnimation)animationStyle {
    return _animationStyle;
}

-(void)hudWasHidden:(MBProgressHUD *)hud {
    [_hud removeFromSuperview];
    _hud = nil;
}

-(void)hideAnimation:(BOOL)hide {
    [_hud hideAnimated:hide];
    [_hud.customView removeFromSuperview];
    [_hud removeFromSuperview];
    _hud = nil;
}

@end
