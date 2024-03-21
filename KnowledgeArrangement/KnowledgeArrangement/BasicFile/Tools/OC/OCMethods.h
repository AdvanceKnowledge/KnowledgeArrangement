//
//  OCMethods.h
//  Recycling
//
//  Created by 无名 on 2019/4/10.
//  Copyright © 2019 FoodShopping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
// 用户信息在沙盒中的路径
#define UserDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserData.data"]
@interface OCMethods : NSObject
+ (BOOL)mytextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

+ (NSString *)getDataPath;

@end

NS_ASSUME_NONNULL_END
