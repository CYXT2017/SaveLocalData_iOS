//
//  GlobalLoginResultData.h
//  SaveLocalData_iOS
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 rsdznjj. All rights reserved.
//类似用viewmodel功能 处理业务逻辑相关类

#import <Foundation/Foundation.h>
#import "UserModel.h"
//NS_ASSUME_NONNULL_BEGIN

@interface GlobalLoginResultData : NSObject

@property (nonatomic, strong) UserModel *userModles;//这个可以直接用 里面存用户信息 token等等

+ (GlobalLoginResultData *) sharedInstance;

+(void)clearGlobalAllData;

- (void)saveDataWithModel:(UserModel *)model keyString:(NSString *)keyStr;

- (NSData *)getDataWithModelKeying:(NSString *)keyStr;

- (NSString *)getDocumentFilePath;
@end

//NS_ASSUME_NONNULL_END
