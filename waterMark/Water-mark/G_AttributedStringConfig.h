//
//  G_AttributedStringConfig.h
//  demoTest
//
//  Created by 高诚 on 2021/9/3.
//

#import <Foundation/Foundation.h>
#import "G_FrameParserConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface G_AttributedStringConfig : NSObject
+(NSMutableAttributedString *)attributesWithConfig:(G_FrameParserConfig *)config text:(NSString *)contentTxt context:(CGContextRef)context;
@end

NS_ASSUME_NONNULL_END
