//
//  ViewController.m
//  SaveLocalData_iOS
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 rsdznjj. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "GlobalLoginResultData.h"
#import "滴滴/testlala.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self plist];
//    [self archive];
//    [self decode];
//    [self archiveWithModel];
//    [self decodeWithModel];
//    [self saveDataForUserDefaults];
    
    //获取Caches缓存文件夹下文件大小和清除其文件夹下数据
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *str = [self getCacheSizeWithFilePath:cachePath];
//    BOOL  isClear = [self clearCacheWithFilePath:cachePath];
}

#pragma mark -  userDefaults存储对象 需存储多个对象时 可以把nsdata 放到数组中、
- (void)saveDataForUserDefaults {
    UserModel *model = [[UserModel alloc] init];
    model.name = @"djkfas";
    model.age = 20;
    model.height = 99;

    [[GlobalLoginResultData sharedInstance] setUserModles:model];
    NSLog(@"-----%@",[GlobalLoginResultData sharedInstance].userModles.name);
    
    [[GlobalLoginResultData sharedInstance] saveDataWithModel:model keyString:@"oneModel"];
    NSData *modelData = [[GlobalLoginResultData sharedInstance] getDataWithModelKeying:@"oneModel"];
    UserModel *student = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    NSLog(@"=======-%@",student.name);
}

#pragma mark - plist 属性列表
- (void)plist {//plist存储的不是数组就是字典 如果对象是NSString、NSDictionary、NSArray、NSData、NSNumber等类型，就可以使用writeToFile:atomically:方法直接将对象写到属性列表文件中
//    [string writeToFile:txtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    // 字符串读取的方法
//    NSString *resultStr = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    
//    [array writeToFile:filePath atomically:YES];
//    NSLog(@"filePath is %@", filePath);
//    // 从文件中读取数据数组的方法
//    NSArray *resultArr = [NSArray arrayWithContentsOfFile:filePath];

    #pragma mark // 获取到Caches文件夹路径
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    #pragma mark  temp文件夹路径
//    NSString *tmpPath = NSTemporaryDirectory();
    NSString *cachePath = [[GlobalLoginResultData sharedInstance] getDocumentFilePath];
    
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"personInfo.plist"];
    // 将数据封装成字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1000wwqs啊啊大2121201" forKey:@"qq"];
    [dict setObject:@"18" forKey:@"age"];
    // 将字典持久化到沙盒文件中
    [dict writeToFile:filePath atomically:YES];
    
    // 从文件中读取数据字典的方法
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"======%@", resultDic[@"qq"]);
}

#pragma mark - 归档单个对象
- (void)archive{
    UserModel *p1 = [[UserModel alloc] init];
    p1.name = @"test";
    NSString *documentFilePath = [[GlobalLoginResultData sharedInstance] getDocumentFilePath];
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"personModel"];
    [NSKeyedArchiver archiveRootObject:p1 toFile:filePath];
    NSLog(@"%@", p1.name);
//    NSArray *array = [NSArray arrayWithObjects:@”a”,@”b”,nil];
//    [NSKeyedArchiver archiveRootObject:array toFile:path];//数组归档
}

#pragma mark  解档单个对象
- (void)decode{
    NSString *documentFilePath = [[GlobalLoginResultData sharedInstance] getDocumentFilePath];
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"personModel"];
    UserModel *p1  = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath] ;
    //下面的方法可以根据key值获取多个对象中对应key的value数据====  key == person1
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
////    NSKeyedUnarchiver *unarchiver  = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    UserModel *p1 =  [unarchiver decodeObjectForKey:@"person1"];
    NSLog(@"%@", p1.name);
//    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//数组解档
}

#pragma mark  归档多个对象
- (void)archiveWithModel {
    //新建一块可变数据区（临时存储空间，以便随后写入文件，或者存放从磁盘读取的文件内容）
    NSMutableData *data = [[NSMutableData alloc] init];
    //将数据区连接到NSKeyedArchiver对象
    NSKeyedArchiver *archiver =  [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    UserModel *p1 = [[UserModel alloc] init];
    p1.name = @"test";
    //存档对象 存档的数据都会存储到NSMutableData中
    [archiver encodeObject:p1 forKey:@"person1"];
    
    UserModel *person2 = [[UserModel alloc] init];
    person2.name = @"dev";
    [archiver encodeObject:person2 forKey:@"person2"];
    //结束存档
    [archiver finishEncoding];
    
    NSString *filePath = [[[GlobalLoginResultData sharedInstance] getDocumentFilePath] stringByAppendingPathComponent:@"personModel"];
    //将存档的数据保存到本地
    [data writeToFile:filePath atomically:YES];
}

#pragma mark 解档多个对象
- (void)decodeWithModel {
    NSString *documentFilePath = [[GlobalLoginResultData sharedInstance] getDocumentFilePath];
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"personModel"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //反归档对象 会调用对象的initWithCoder方法 所以需要实现该方法
    UserModel *p1 =  [unarchiver decodeObjectForKey:@"person1"];
    UserModel *person2 =  [unarchiver decodeObjectForKey:@"person2"];
    //结束解归档
    [unarchiver finishDecoding];
    NSLog(@"%@  %@ ", p1.name, person2.name);
}



#pragma mark - 获取path路径下文件夹大小
- (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr){
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        // 7. 计算总大小
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    if (totleSize > 1000 * 1000) {
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
    } else if (totleSize > 1000) {
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
    } else {
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return totleStr;
}


#pragma mark  清除path文件夹下缓存大小
- (BOOL)clearCacheWithFilePath:(NSString *)path{
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr) {
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}

#pragma mark  - 测试 masonry 自行导入
- (void)testGCDandMasonry {
    //主线程中调用主队列+同步   ====== 死锁
    //    NSLog(@"当前是%@",[NSThread currentThread]);
    //    NSLog(@"start");
    //    //获得主队列
    //    dispatch_queue_t queue = dispatch_get_main_queue();
    //    //同步函数
    //    dispatch_sync(queue, ^{
    //        NSLog(@"------ %@",[NSThread currentThread]);
    //    });
    //    NSLog(@"end");
    
    //子线程中调用 主队列 + 同步函数  ====不会死锁  只是会同步顺序执行！！！
    NSLog(@"当前是主线程=%@",[NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"当前是子线程=%@",[NSThread currentThread]);
        NSLog(@"start");
        //获得主队列
        dispatch_queue_t queue = dispatch_get_main_queue();
        //同步函数
        dispatch_sync(queue, ^{
            NSLog(@"------ %@",[NSThread currentThread]);
        });
        NSLog(@"end");
    });
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 300, 60)];
    bgview.backgroundColor = UIColor.redColor;
    [self.view addSubview:bgview];
    
    //    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [bgview addSubview:btn1];
    //    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(20);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        //        make.centerY.equalTo(bgview);
    //    }];
    //
    //    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [bgview addSubview:btn3];
    //    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.left.mas_equalTo(btn2.mas_right).offset(30);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        make.right.mas_equalTo(-20);
    //    }];
    //
    //    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [bgview addSubview:btn2];
    //    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(btn1.mas_right).offset(30);
    //        make.right.mas_equalTo(btn3.mas_left).offset(-30);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        make.width.equalTo(btn3);
    //        make.width.equalTo(btn1);
    //    }];
    //    btn1.backgroundColor = UIColor.grayColor;
    //    btn2.backgroundColor = UIColor.blackColor;
    //    btn3.backgroundColor = UIColor.blueColor;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgview addSubview:btn1];
    //    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(20);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        //        make.centerY.equalTo(bgview);
    //    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgview addSubview:btn2];
    //    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(btn1.mas_right).offset(30);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        make.width.equalTo(btn1);
    //    }];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgview addSubview:btn3];
    //    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(btn2.mas_right).offset(30);
    //        make.top.mas_equalTo(10);
    //        make.bottom.mas_equalTo(-10);
    //        make.right.mas_equalTo(-20);
    //        make.width.equalTo(btn2);
    //    }];
    
    
    btn1.backgroundColor = UIColor.grayColor;
    btn2.backgroundColor = UIColor.blackColor;
    btn3.backgroundColor = UIColor.blueColor;
    
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:btn1];
    [arr addObject:btn2];
    [arr addObject:btn3];
    //设置水平排列布局
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
//    // 根据父视图设置垂直布局 ---高度
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
//    }];

}


@end
