//
//  LXGlobalLoadingView.h
//  LingXi
//
//  Created by lsp on 2020/6/22.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LXGlobalLoadingType_White,
    LXGlobalLoadingType_Blue,
} LXGlobalLoadingType;

typedef NS_ENUM(NSUInteger, LXGlobalLoadingMaskType) {
    LXGlobalLoadingMaskTypeNone = 0,
    LXGlobalLoadingMaskTypeAllow,
};

@interface LXGlobalLoadingView : UIView

/// 全局加载样式
/// @param hudType 蓝色/白色
/// @param maskType 导航栏是否允许返回
/// @param view 父视图
-(instancetype)initWithType:(LXGlobalLoadingType)hudType maskType:(LXGlobalLoadingMaskType)maskType superView:(UIView *_Nullable)view;

/// 全局加载样式(带文字标题)
/// @param hudType 蓝色/白色
/// @param title 标题
/// @param maskType 导航栏是否允许返回
-(instancetype)initWithType:(LXGlobalLoadingType)hudType title:(NSString *)title maskType:(LXGlobalLoadingMaskType )maskType superView:(UIView * _Nullable)view;

- (void)showLoading;
- (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
