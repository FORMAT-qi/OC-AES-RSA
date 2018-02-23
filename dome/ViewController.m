//
//  ViewController.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import "ViewController.h"
#import "SecurityUtil.h"
@interface ViewController ()
{
    dispatch_source_t _timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmpOiPymBGrDqiFCBfu6LvYU7sC0zgdiYftTdrfeNoC8M/tVAbUYXVSGiMrn/PDNhKfqbUNJM70Qm31wc1znCtvTuOmSdnHTp+7WCaUklCNzDjRQhXRDI7QWdyafgAEKsDsU1Iljzi2lxolDegeJqigpybo6wL+MCZ+DOV8g6ej6Rh475CDV5ClFR9MMo5Ddq9AdQD0CrN/L87sIhdKyF1UguKsDvsPgxyITC3A1L6b7nborqjVs3ovhaa0k8h2cPKLU8Sua0uRkZYqtjW3en6gRDIh5G+7F9iz8HuWhml59Razk/MxyK/drKWLNQ/WqsCdxm/crRsKj4OHzAODX6nwIDAQAB-----END PUBLIC KEY-----";
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCak6I/KYEasOqIUIF+7ou9hTuwLTOB2Jh+1N2t942gLwz+1UBtRhdVIaIyuf88M2Ep+ptQ0kzvRCbfXBzXOcK29O46ZJ2cdOn7tYJpSSUI3MONFCFdEMjtBZ3Jp+AAQqwOxTUiWPOLaXGiUN6B4mqKCnJujrAv4wJn4M5XyDp6PpGHjvkINXkKUVH0wyjkN2r0B1APQKs38vzuwiF0rIXVSC4qwO+w+DHIhMLcDUvpvuduiuqNWzei+FprSTyHZw8otTxK5rS5GRliq2Nbd6fqBEMiHkb7sX2LPwe5aGaXn1FrOT8zHIr92spYs1D9aqwJ3Gb9ytGwqPg4fMA4NfqfAgMBAAECggEAQM7HBn5LP7qPCknekS5IblQu20WIQ9dg0ERFEQwqV8+CPlGAapApdircyzHKPh44jZYhijgxw1sqhRkkimQQLA7y1o6auh8Wfs7x91yQZ2/PmRWoi1FfPGjPZ923f8R0SNkL1vO+YGP8HZaUQ5Z/HpMUuR+f5OPjfVP2jz1GrztnfwDST6g3VV70bxO0J//Z/lE7b0UdIqOpLOpSQOsgmmmUodp04wF834e5QAs//5OkB18amQBlnmgBmt/RmlMWCUNuYNVXdtEE634XPOH1DLRSHy3bZM3c+iVu/rlRkpZmOT5YU0FwJxgBybc2a12tdFsiGcYTa3RCxed8dcYcyQKBgQDMqfulm0naerGuy6yCK7p93VIxpEFpWhADfiF224e01FzXkD32oJ0GJf/2rQFI3cLLChm/W+Hugp9dHgpVrO5ErtePW6umxQ/hDsOenpCBIdbUD9kuepGQR++G45HkEDlhIIUt0CCA18O5nX8NT9oR26Iv3fFKa24KMDXYhS/sFQKBgQDBWWmce+gF7ScwxHvGR5rEpt/1zQ1b+ZZtt/ZcjGdyJxa+x+l2BuVg0yNTj2zoNz8X+d1wxVBqgFMGy/hSal1b0O/peR+Hl9Ag7aSkk4Zb6PNo8g1k4Mdc0FrjHh2J/hrYqIAe+XHw5SP/kBXrA1z14ITlLImkxaXUYaRgwq4U4wKBgH4ZQWYgzpkhPXbAINK3FJlWEr1pQbAigHlWblHoIq3kpitewP7CqNzP7uxSXddCYzFsUL7ZYtPsgToDN0TgXpHM1B2M0q7W/dihmx+Q/OHDMrTH6v07IZKu78LBVfMZl/Di84ttj4ky53HmuxA9odOc6knpyjAbDtqSJ6r3LLadAoGAZF3puNWJKCpnQaV9KvxYluSZNZtv5+Kz99ibBofL2zH3WKmlwyLpR03S9LlrK1AibGvES5nhmKdscgbHrOCR/euD3oqFl3lzDOTPpq79/A/86ulbkpYsZz2xMFydsNg7T2SIvYt3XjlUaoF9HzXrt6cI1X49JU+EOa9GCQSGIUkCgYEAi3h5gbnADPqwnNA6z4Ls31FuBwu9qlOhmrCeSEMv7H1Z2R4iwbRmsixVhSK0+h0bVHghfjMGgyyAu9raH8gtpz2lSTec1/pE3nc/4gABER/5CMhuWCZ3wrfYpAd/jGqVb1v3LUbSL/LzHSaOTdTRJXWGMKCEHygz71Fo9P2pW2w=-----END PRIVATE KEY-----";
    //需要加密的内容
    NSString * originString = @"句号君++";
    /************************
     AES128 加密
     *********************/
    
    //随机生成16位字符串的AES 加密的密钥key
    NSString *key = [SecurityUtil randomlyGenerated16BitString];
    NSLog(@"加密key:%@",key);
    //aes128数据加密
    NSData *encryptStr = [SecurityUtil encryptAES128Data:originString key:key];
    
    //AES基础上增加base64转码
    NSString *encodeBase64 = [SecurityUtil encodeBase64Data:encryptStr];
    NSLog(@"AES128加密:%@",encodeBase64);
    
    
    /************************
     RAS 加密  ASE的KEY
     ****************************/
    
    //给随机KEY 加密
    NSString *encWithPubKey = [SecurityUtil encryptString:key publicKey:pubkey];
    NSLog(@"RSA加密后的key:%@",encWithPubKey);
    
    //解密
    //1. 先私钥解密AES key
    NSString *decWithPrivKey = [SecurityUtil decryptString:encWithPubKey privateKey:privkey];
    NSLog(@"key:%@", decWithPrivKey);
    //2. base64字符串转回data
    NSData *decodeData = [SecurityUtil decodeBase64Data:encodeBase64];
    //3.AES解密
    NSString *decStr = [SecurityUtil decryptAES128Data:decodeData key:decWithPrivKey];
    NSLog(@"解密后的内容:%@", decStr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
