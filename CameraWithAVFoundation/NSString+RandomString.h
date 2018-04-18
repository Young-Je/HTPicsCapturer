//
//  NSString+RandomString.h
//  CameraWithAVFoundation
//
//  Created by Hutong on 2018/4/17.
//  Copyright © 2018 Gabriel Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RandomString)

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

@end
