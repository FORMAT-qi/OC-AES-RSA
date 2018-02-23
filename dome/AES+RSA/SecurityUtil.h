//
//  SecurityUtil.h
//  WYFX_Demo
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject
#pragma mark --  BASE64;
//将string转成BASE64字符串
+ (NSString*)encodeBase64String:(NSString *)input;
//将BASE64字符串转成string
+ (NSString*)decodeBase64String:(NSString *)input;
//将data转成BASE64字符串
+ (NSString*)encodeBase64Data:(NSData *)data;
//将BASE64字符串转成data
+ (NSData*)decodeBase64Data:(NSString *)string;
#pragma mark --  AES256;
//将string转成带密码的data
+ (NSData*)encryptAESData:(NSString*)string key:(NSString *)key;
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSData*)data key:(NSString *)key;
#pragma mark --  AES128;
//将string转成带密码的data --128
+ (NSData*)encryptAES128Data:(NSString*)string key:(NSString *)key;
//将带密码的data转成string --128
+ (NSString*)decryptAES128Data:(NSData*)data key:(NSString *)key;
#pragma mark -- RSA
//随机生成16位字符串
+ (NSString *)randomlyGenerated16BitString;
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
