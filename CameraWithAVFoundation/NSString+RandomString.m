//
//  NSString+RandomString.m
//  CameraWithAVFoundation
//
//  Created by Hutong on 2018/4/17.
//  Copyright © 2018 Gabriel Alvarado. All rights reserved.
//

#import "NSString+RandomString.h"

@implementation NSString (RandomString)

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
