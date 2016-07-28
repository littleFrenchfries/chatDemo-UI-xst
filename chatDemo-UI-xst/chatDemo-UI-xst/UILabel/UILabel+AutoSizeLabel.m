//
//  UILabel+AutoSizeLabel.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/27.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "UILabel+AutoSizeLabel.h"

@implementation UILabel (AutoSizeLabel)


+(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    float height = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    return height;
}

//根据字符串的的长度来计算UITextView的高度
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    float height = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, height);
    return height;
}

-(float)widthForString:(NSString *)value fontSize:(float)fontSize andheight:(float)height{
    float width = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.width;
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, height);
    return width;
}

+(float)widthForString:(NSString *)value fontSize:(float)fontSize andheight:(float)height{
    float width = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.width;
    return width;
}

@end
