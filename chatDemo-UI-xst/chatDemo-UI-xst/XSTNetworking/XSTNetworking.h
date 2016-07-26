//
//  XSTNetworking.h
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/11.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFURLRequestSerialization.h"
#ifdef DEBUG
#define XSTLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define XSTLog( s, ... )
#endif

typedef NS_ENUM(NSUInteger,REQUEST_TYPE){
    GET = 1,//GET请求
    POST = 2//POST请求
};

/*
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^downloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);

typedef NSURLSessionTask XSTURLSessionTask;

typedef void(^successBlock)(id dataSources);

typedef void(^errorBlock)(NSError * error);

typedef NS_ENUM(NSInteger, HYBNetworkStatus) {
    kXSTNetworkStatusUnknown          = -1,//未知网络
    kXSTNetworkStatusNotReachable     = 0,//网络无连接
    kXSTNetworkStatusReachableViaWWAN = 1,//2，3，4G网络
    kXSTNetworkStatusReachableViaWiFi = 2,//WIFI网络
};

@interface XSTNetworking : NSObject

/**
 *  清除缓存
 */
+ (void)clearCaches;

/**
 *  检查网络
 */
+ (void)detectNetwork;

/**
 *  获取所有的网络请求任务
 */
+ (NSMutableArray *)allTasks;

/**
 *  取消所有的请求
 */
+ (void)cancelAllRequest;

/**
 *  取消单个网络请求
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *  网络请求
 *
 *  @param url         请求url
 *  @param connectType 请求类型
 *  @param params      请求参数
 *  @param progress    请求进度
 *  @param data        成功返回数据
 *  @param Error       失败返回数据
 *
 *  @return 当前请求任务
 */
+(XSTURLSessionTask *)requestWithURL:(NSString *)url
                                type:(REQUEST_TYPE)connectType
                               Param:(NSDictionary *)params
                            progress:(downloadProgress)progress
                             Success:(successBlock)data
                               error:(errorBlock)Error;


/*
 *
 *  用于指定网络请求接口的基础url
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/**
 *
 *	获取缓存总大小/bytes
 *
 *	@return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *	默认不会自动清除缓存，如果需要，可以设置自动清除缓存，并且需要指定上限。当指定上限>0M时，
 *  若缓存达到了上限值，则每次启动应用则尝试自动去清理缓存。
 *
 *	@param mSize				缓存上限大小，单位为M（兆），默认为0，表示不清理
 */
+ (void)autoToClearCacheWithLimitedToSize:(NSUInteger)mSize;


/**
 *
 *	图片上传接口，若不指定baseurl，可传完整的url
 *
 *	@param image			图片对象
 *	@param url				上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail				上传失败回调
 *
 *	@return
 */
+ (XSTURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(downloadProgress)progress
                               success:(successBlock)success
                                  fail:(errorBlock)fail;

/**
 *
 *	上传文件操作
 *
 *	@param url						上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 *	@param success				上传成功回调
 *	@param fail					上传失败回调
 *
 *	@return
 */
+ (XSTURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(downloadProgress)progress
                                 success:(successBlock)success
                                    fail:(errorBlock)fail;


/*
 *
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (XSTURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(downloadProgress)progressBlock
                               success:(successBlock)success
                               failure:(errorBlock)failure;
@end
