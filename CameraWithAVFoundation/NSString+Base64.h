//
//  NSString+Base64.h
//  AllInOneCard
//
//  Created by YO MAN on 2017/7/27.
//  Copyright © 2017年 薛洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

@end
