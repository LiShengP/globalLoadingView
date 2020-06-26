//
//  LXLoadingView.m
//  LingXi
//
//  Created by lsp on 2020/6/26.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import "LXLoadingView.h"

@interface LXLoadingView ()

@property (nonatomic, assign)LXLoadingViewType hudType;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UILabel *textL;

@end

@implementation LXLoadingView

- (instancetype)initWithType:(LXLoadingViewType)hudType text:(NSString *)text textColor:(UIColor *)textColor {
    if (self = [super init]) {
        self.hudType = hudType;
        self.text = text;
        self.textColor = textColor;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
    [self addSubview:imageView];
    [imageView autoCenterInSuperview];
    
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for(int i = 1; i <= 3; i++){
        NSString *imgNameStr = @"";
        if (self.hudType == LXLoadingViewType_Blue) {
            imgNameStr = [NSString stringWithFormat:@"common_loading_blue_%d",i];
        }else {
            imgNameStr = [NSString stringWithFormat:@"common_loading_white_%d",i];
        }
        [images addObject:[UIImage imageNamed:imgNameStr]];
    }
    
    imageView.animationDuration = 0.8;
    imageView.animationImages = images;
    // 开始播放
    [imageView startAnimating];
    
    [self addSubview:self.textL];
    [self.textL autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:8];
    [self.textL autoAlignAxisToSuperviewAxis:ALAxisVertical];
    if (_text && _text.length > 0) {
        self.textL.text = _text;
        self.textL.textColor = _textColor;
        self.textL.hidden = NO;
    }else {
        self.textL.hidden = YES;
    }
    
}

-(UILabel *)textL {
    if (!_textL) {
        _textL = [UILabel newAutoLayoutView];
        _textL.textAlignment = NSTextAlignmentCenter;
        _textL.numberOfLines = 0;
        _textL.font = [UIFont lx_fontRegularOfSize:14];
        [_textL sizeToFit];
    }
    return _textL;
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake(kDeviceWidth - 40, 100);
}

@end
