//
//  G_FrameParserConfig.m
//  demoTest
//
//  Created by 高诚 on 2021/8/30.
//
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define ssRGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#import "G_FrameParserConfig.h"
#import "NSDictionary+safe.h"

@implementation G_FrameParserConfig
//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        _fontSize = 16.0f;
        _lineSpace = 1.0f;
        _textColor = RGB(108, 108, 108);
        _opaque = 0.5;
    }
    return self;
}

@end
