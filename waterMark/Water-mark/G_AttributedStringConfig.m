//
//  G_AttributedStringConfig.m
//  demoTest
//
//  Created by 高诚 on 2021/9/3.
//

#import "G_AttributedStringConfig.h"
#import <CoreText/CoreText.h>

@implementation G_AttributedStringConfig

+(NSMutableAttributedString *)attributesWithConfig:(G_FrameParserConfig *)config text:(NSString *)contentTxt context:(nonnull CGContextRef)context{
    CGContextSetTextDrawingMode (context, kCGTextFill); //文字绘制模式
    
    CGContextSetAlpha(context, config.opaque); //context背景透明
    NSMutableDictionary *attrDic = [self attributeDicWithConfig:config];

    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:contentTxt attributes:attrDic];
    
    CGFloat height = 0.0;
    CGFloat t_imgH = [attributeString boundingRectWithSize:CGSizeMake(config.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    while (height < config.width) {
        CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(config.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        NSAttributedString *as = [self parseImageDataFromNSDictionary:@{@"height":[NSNumber numberWithFloat:t_imgH],@"width":[NSNumber numberWithFloat:config.spaceSize]} config:config];
        [attributeString appendAttributedString:as];
        
        [attributeString appendAttributedString:[[NSAttributedString alloc] initWithString:contentTxt attributes:attrDic]];

        height = rect.size.height;
    }
    return attributeString;
}

+(NSMutableDictionary *)attributeDicWithConfig:(G_FrameParserConfig *)config{
    CGFloat fontSize = config.fontSize;
    CGFloat lineSpcing = config.lineSpace;
    //4.设置绘制内容
    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), fontSize, NULL);//

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing  = lineSpcing;
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)ctFont;
    dict[(id)kCTParagraphStyleAttributeName] = paragraphStyle;
    CFRelease(ctFont);
    return  dict;
}



#pragma mark - 添加设置CTRunDelegate信息的方法
static CGFloat ascentCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void *ref){
    
    return 0;
}
static CGFloat widthCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}
+(NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(G_FrameParserConfig *)config{
    
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)dict);
    
    //使用0xFFFC作为空白占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableDictionary *attributes = [self attributeDicWithConfig:config];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}


@end
