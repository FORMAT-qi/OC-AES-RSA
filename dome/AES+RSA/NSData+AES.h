//
//  NSData+AES.h
//  Smile
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密

- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密-CBC
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密-CBC

@end
