
//
//  UserModel.m
//  SaveLocalData_iOS
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 rsdznjj. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
    [aCoder encodeDouble:self.height forKey:@"height"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.height = [aDecoder decodeDoubleForKey:@"height"];
    }
    return self;
}

@end
