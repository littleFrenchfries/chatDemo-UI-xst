//
//  XSTabBar.m
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/14.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "XSTabBar.h"

static CGFloat XSTabBarItemWidth;

@interface XSTabBar()

@property (nonatomic, copy) NSArray *tabBarButtonArray;

@end

@implementation XSTabBar

- (void)setPlusButton:(UIButton *)plusButton{
    _plusButton = plusButton;
    [self addSubview:plusButton];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat taBarWidth = self.bounds.size.width;
    XSTabBarItemWidth = (taBarWidth - self.plusButton.frame.size.height) / self.XSTabbarItemsCount;
    NSArray *sortedSubviews = [self sortedSubviews];
    self.tabBarButtonArray = [self tabBarButtonFromTabBarSubviews:sortedSubviews];
    __weak typeof(self) weakSelf = self;
    [self.tabBarButtonArray enumerateObjectsUsingBlock:^(UIView * _Nonnull childView, NSUInteger buttonIndex, BOOL * _Nonnull stop) {
        //调整UITabBarItem的位置
        CGFloat childViewX;
        if (buttonIndex >= weakSelf.tabBarButtonArray.count/2) {
            childViewX = buttonIndex * XSTabBarItemWidth + weakSelf.plusButton.frame.size.width;
        } else {
            childViewX = buttonIndex * XSTabBarItemWidth;
        }
        //仅修改childView的x和宽度,yh值不变
        childView.frame = CGRectMake(childViewX,
                                     CGRectGetMinY(childView.frame),
                                     XSTabBarItemWidth,
                                     CGRectGetHeight(childView.frame)
                                     );
    }];
    
    self.plusButton.frame = ({
        CGRect frame = self.plusButton.frame;
        CGFloat tabBarHeight = self.bounds.size.height;
        frame.origin.y = tabBarHeight - self.plusButton.frame.size.height;
        frame.origin.x = self.tabBarButtonArray.count/2*XSTabBarItemWidth;
        frame;
                              });
    //bring the plus button to top
    [self bringSubviewToFront:self.plusButton];
    if (self.isHaveTitle) {
    }else{
        [self offsetTabBarSwappableImageViewToFit:5];
    }
}

- (NSArray *)tabBarButtonFromTabBarSubviews:(NSArray *)tabBarSubviews {
    NSMutableArray *tabBarButtonMutableArray = [NSMutableArray arrayWithCapacity:tabBarSubviews.count - 1];
    [tabBarSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonMutableArray addObject:obj];
        }
    }];
    return [tabBarButtonMutableArray copy];
}

- (NSArray *)sortedSubviews {
    NSArray *sortedSubviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * formerView, UIView * latterView) {
        CGFloat formerViewX = formerView.frame.origin.x;
        CGFloat latterViewX = latterView.frame.origin.x;
        return  (formerViewX > latterViewX) ? NSOrderedDescending : NSOrderedAscending;
    }];
    return sortedSubviews;
}

/*!
 *  Capturing touches on a subview outside the frame of its superview.
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL canNotResponseEvent = self.hidden || (self.alpha <= 0.01f) || (self.userInteractionEnabled == NO);
    if (canNotResponseEvent) {
        return nil;
    }
    if (!self.plusButton && ![self pointInside:point withEvent:event]) {
        return nil;
    }
    if (self.plusButton) {
        CGRect plusButtonFrame = self.plusButton.frame;
        BOOL isInPlusButtonFrame = CGRectContainsPoint(plusButtonFrame, point);
        if (!isInPlusButtonFrame && (point.y < 0) ) {
            return nil;
        }
        if (isInPlusButtonFrame) {
            return self.plusButton;
        }
    }
    NSArray *tabBarButtons = self.tabBarButtonArray;
    if (self.tabBarButtonArray.count == 0) {
        tabBarButtons = [self tabBarButtonFromTabBarSubviews:self.subviews];
    }
    for (NSUInteger index = 0; index < tabBarButtons.count; index++) {
        UIView *selectedTabBarButton = tabBarButtons[index];
        CGRect selectedTabBarButtonFrame = selectedTabBarButton.frame;
        if (CGRectContainsPoint(selectedTabBarButtonFrame, point)) {
            return selectedTabBarButton;
        }
    }
    return nil;
}

- (void)offsetTabBarSwappableImageViewToFit:(CGFloat)swappableImageViewDefaultOffset {
    NSArray<UITabBarItem *> *tabBarItems = self.items;
    [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIEdgeInsets imageInset = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);
        obj.imageInsets = imageInset;
//        obj.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
