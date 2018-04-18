//
//  UIImage+ImageHelper.m
//  AfNetowrkExample
//
//  Created by YoungJeXu on 2/21/17.
//  Copyright © 2017 HT. All rights reserved.
//

#import "UIImage+ImageHelper.h"

@implementation UIImage (ImageHelper)

-(UIImage *)scaleToFitWidth:(CGFloat)width{
    CGFloat ratio = width / self.size.width;
    CGFloat height = self.size.height * ratio;
    
    NSLog(@"W:%f H:%f",width,height);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0.0f,0.0f,width,height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
