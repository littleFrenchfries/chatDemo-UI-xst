//
//  UILabel+AutoSizeLabel.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/27.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoSizeLabel)

//根据字符串的长度来计算高度
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

//根据字符串的高度来计算宽度
-(float)widthForString:(NSString *)value fontSize:(float)fontSize andheight:(float)height;
+(float)widthForString:(NSString *)value fontSize:(float)fontSize andheight:(float)height;
@end
