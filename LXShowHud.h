//
//  LXShowHud.h
//  LingXi
//
//  Created by lsp on 2020/6/24.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXShowHud : NSObject

/// 局部加载loading
/// @param view 父视图
/// @param text 提示文字
/// @param color 提示文字颜色
/// @param hudType hud颜色：蓝色/白色
+ (instancetype)showHudInView:(UIView * _Nonnull)view Text:(NSString * _Nullable)text textColor:(UIColor * _Nullable)color hudType:(LXLoadingViewType)hudType;

- (void)hideAnimation:(BOOL)hide;

- (void)animationShow:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
