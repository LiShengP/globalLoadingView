//
//  LXLoadingView.h
//  LingXi
//
//  Created by lsp on 2020/6/26.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LXLoadingViewType_White,
    LXLoadingViewType_Blue,
} LXLoadingViewType;

@interface LXLoadingView : UIView

-(instancetype)initWithType:(LXLoadingViewType)hudType text:(NSString *)text textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
