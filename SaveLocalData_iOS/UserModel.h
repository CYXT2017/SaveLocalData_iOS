//
//  UserModel.h
//  SaveLocalData_iOS
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 rsdznjj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject <NSCoding>


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int  age;
@property (nonatomic, assign) double  height;


@end

NS_ASSUME_NONNULL_END
