//
//  G_WaterMark.m
//  demoTest
//
//  Created by 高诚 on 2021/9/1.
//

#import "G_WaterMark.h"
#import "G_AttributedStringConfig.h"
#import <CoreText/CoreText.h>

@implementation G_WaterMark
+(UIImage *)addWatermarkWithImg:(UIImage *)image imageViewSize:(CGSize)imageViewSize text:(NSString *)name attribute:(G_FrameParserConfig *)config{
    return  [self addWatermarkWithImg:image imageViewSize:imageViewSize text:name attribute:config waterImage:nil];
}

+(UIImage *)addWatermarkWithImg:(UIImage *)image imageViewSize:(CGSize)imageViewSize text:(NSString *)name attribute:(G_FrameParserConfig *)config waterImage:(nullable UIImage *)waterImage{
    UIGraphicsBeginImageContext(imageViewSize);
    
    [image drawInRect:CGRectMake(0, 0, imageViewSize.width, imageViewSize.height)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //计算大小 覆盖图片
    CGFloat newWidth = sqrt(imageViewSize.width*imageViewSize.width + imageViewSize.height*imageViewSize.height);
    
    config.width = newWidth;
    
    //起点移至中心点
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(imageViewSize.width/2, imageViewSize.height/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation((M_PI * -0.25)));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-imageViewSize.width/2 - (newWidth - imageViewSize.width)/2, -imageViewSize.height/2 - (newWidth - imageViewSize.height)/2));
    
    //画出来的文字会颠倒，使用这个方法给倒回来，参数意思为真正绘图坐标 = 参数*设置的坐标
    CGContextTranslateCTM(context, 0, newWidth);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    NSAttributedString *attrStr = [G_AttributedStringConfig attributesWithConfig:config text:name context:context];
    
    drawText(context, newWidth ,attrStr,waterImage);
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
}



void drawText(CGContextRef myContext,CGFloat contextSize,NSAttributedString * waterStr,UIImage* image){
    
    //3.创建绘制局域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, contextSize,contextSize));
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)waterStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [waterStr length]), path, NULL);
    CTFrameDraw(frame, myContext);
    
    if (image) {
        CFArrayRef lines = CTFrameGetLines(frame);
        NSInteger lineCount = CFArrayGetCount(lines);
        CGPoint lineOrigins[lineCount];
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
        for (NSInteger l = 0; l < lineCount; l++) {
            CTLineRef line = CFArrayGetValueAtIndex(lines, l);
            CFArrayRef ctRuns = CTLineGetGlyphRuns(line);
            NSInteger runCount = CFArrayGetCount(ctRuns);
            for (NSInteger r = 0; r < runCount; r++) {
                CTRunRef run = CFArrayGetValueAtIndex(ctRuns, r);
                //查找图片位置
                CFDictionaryRef attributes = CTRunGetAttributes(run);
                CTRunDelegateRef delegate = CFDictionaryGetValue(attributes, kCTRunDelegateAttributeName);;//获取代理属性
                if (delegate == nil) {
                    continue;
                }
                UIImage *image = [UIImage imageNamed:@"newMenu"];
                CGFloat ascent;  //上行高度
                CGFloat descent; //下行高度
                CGFloat leading = 0; //行距
                CGRect boundsRun;
                //获取宽、高
                CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
                CGFloat t_height = ascent + fabs(descent) + leading;
                boundsRun.size.width = image.size.width/image.size.height * t_height;
                boundsRun.size.height = t_height;
                //获取对应 CTRun 的 X 偏移量
                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                boundsRun.origin.x = lineOrigins[l].x + xOffset + 5;
                boundsRun.origin.y = lineOrigins[l].y - descent - leading - t_height/35.0 *10;//图片原点 t_height/35.0 *10 图片居中显示
                CGContextDrawImage(myContext, boundsRun, image.CGImage);
            }
        }
    }
   
    //6.释放资源
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}




@end
