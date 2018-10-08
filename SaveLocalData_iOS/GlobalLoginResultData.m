//
//  GlobalLoginResultData.m
//  SaveLocalData_iOS
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 rsdznjj. All rights reserved.
//

#import "GlobalLoginResultData.h"
static GlobalLoginResultData *sharedObj = nil; //第一步：静态实例，并初始化。

@implementation GlobalLoginResultData

+ (GlobalLoginResultData *) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}


+(void)clearGlobalAllData
{
    [[GlobalLoginResultData sharedInstance] clearGlobalAllData];
}

/*清除登录缓存信息*/
-(void)clearGlobalAllData
{
    
}

#pragma mark - 根据不同的key 存数据模型对象 比如 设备id（设备其余信息） 用户id（用户其余信息） 回话id（回话内容）
- (void)saveDataWithModel:(UserModel *)model keyString:(NSString *)keyStr {//想存储全部的信息你还要用一个for循环将data 放入 dataArray中
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:modelData forKey:keyStr];
    [defaults synchronize];
}

#pragma mark 根据不同的key 获取不同的数据 外部需要用对象接收
- (NSData *)getDataWithModelKeying:(NSString *)keyStr {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyStr];
    return data;
}


- (NSString *)getDocumentFilePath {
    NSString *documentFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return documentFilePath;
}

//- (void)setUserModles:(UserModel *)userModles {
//    if ([userModles isKindOfClass:[NSNull class]] || userModles == nil) {
//        _userModles = nil;
//    } else {
//        _userModles = userModles;
//    }
//}
//
//- (UserModel *)userModles {
//    self.userModles = userModles;
//}


@end
