//
//  G_WaterMark.h
//  demoTest
//
//  Created by 高诚 on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class G_FrameParserConfig;

@interface G_WaterMark : NSObject
+(UIImage *)addWatermarkWithImg:(UIImage *)image imageViewSize:(CGSize)imageViewSize text:(NSString *)name attribute:(G_FrameParserConfig *)config;
+(UIImage *)addWatermarkWithImg:(UIImage *)image imageViewSize:(CGSize)imageViewSize text:(NSString *)name attribute:(G_FrameParserConfig *)config waterImage:(nullable UIImage *)waterImage;
@end

NS_ASSUME_NONNULL_END
