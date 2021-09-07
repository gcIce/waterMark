//
//  NSDictionary+safe.h
//  XingXiaoBao
//
//  Created by iOS on 2020/4/21.
//  Copyright © 2020 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (safe)
-(id)safeValueForKey:(NSString *)key;
-(id)safeValueForKey:(NSString *)key defaultVal:(id)val;
@end

@interface NSDictionary (NilSafe)

@end

@interface NSMutableDictionary (NilSafe)

@end

NS_ASSUME_NONNULL_END
