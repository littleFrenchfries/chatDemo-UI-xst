//
//  UIColor+HexColor.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
/**
 *  将16进制的颜色转换成UIColor
 */
+(UIColor *)hex_getColor:(NSString *)hexColor;
@end
