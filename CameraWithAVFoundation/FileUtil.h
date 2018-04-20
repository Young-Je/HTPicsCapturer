//
//  FileUtil.h
//  AfNetowrkExample
//
//  Created by YoungJeXu on 2/21/17.
//  Copyright © 2017 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^CallBackBlock)(NSDictionary* retDict);
@interface FileUtil : NSObject

//@property (nonatomic, copy) CallBackBlock callback;

+(BOOL) fileExistsInProject:(NSString *)fileName;

+ (void) saveImageWithFixedNameAndGetPath: (UIImage *) image callBackBlock:(CallBackBlock)callBack;
+(NSString*) saveImageWithRandomNameAndGetPath: (UIImage *) image;

@end
