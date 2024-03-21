//
//  OCMethods.m
//  Recycling
//
//  Created by 无名 on 2019/4/10.
//  Copyright © 2019 FoodShopping. All rights reserved.
//

#import "OCMethods.h"

@implementation OCMethods

+ (NSString *)getDataPath{
    
    return UserDataPath;
}


//Field价格输入限制
+ (BOOL)mytextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    else
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
    {
        return NO;
    }
    
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        
    }
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
    {
        return NO;
    }
    return YES;
}

// 为 layer 的动画设置不同的 anchor point，但是又不想改变 view 原来的 position，则需要做一些转换。
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    // 分别计算原来锚点和将更新的锚点对应的坐标点，这些坐标点是相对该 view 内部坐标系的。
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    
    // 如果当前 view 有做过 transform，这里要同步计算。
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    
    // position 是当前 view 的 anchor point 在其父 view 的位置。
    CGPoint position = view.layer.position;
    // anchor point 的改变会造成 position 的改变，从而影响 view 在其父 view 的位置，这里把这个位移给计算回来。
    position.x = position.x + newPoint.x - oldPoint.x;
    position.y = position.y + newPoint.y - oldPoint.y;
    
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.layer.anchorPoint = anchorPoint; // 设置了新的 anchor point 会改变位置。
    view.layer.position = position; // 通过在 position 上做逆向偏移，把位置给移回来。
}

@end
