//
//  G_FrameParserConfig.h
//  demoTest
//
//  Created by 高诚 on 2021/8/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface G_FrameParserConfig : NSObject
//配置属性
@property (nonatomic ,assign)CGFloat width;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat spaceSize;
@property (nonatomic, assign)CGFloat lineSpace;
@property (nonatomic, assign)CGFloat opaque;
@property (nonatomic, strong)UIColor *textColor;
@end

NS_ASSUME_NONNULL_END
