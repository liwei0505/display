//
//  UploadImageUtils.m
//  Display
//
//  Created by lee on 2018/1/17.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import "UploadImageUtils.h"

@interface UploadImageUtils()<NSURLSessionDelegate>
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation UploadImageUtils

- (void)upload {
    UIImage *img = [UIImage imageNamed:@"banner"];
    NSData *data = UIImagePNGRepresentation(img);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"front_img"];
    [params setValue:[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"back_img"];
    [params setValue:@"1234567" forKey:@"sessionId"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"error");
        return;
    }
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.116.62:80/userService/submitIDCardPictures"];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSURLSession sharedSession].delegateQueue];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    request.HTTPMethod = @"POST";
    NSString *userAgent = [NSString stringWithFormat:@"iPhone/%@;com.mjsfax.mjs/%@", @"1.0.0", @"1.0.1"];
    [request addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    [dataTask resume];
    
}

//+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(NSMutableDictionary *)dataParams imageParams:(NSMutableDictionary *) imageParams Success:(void(^)(NSDictionary *resultDic)) success Failed:(void(^)(NSError *error))fail {
//    NSArray *keys = [imageParams allKeys];
//    UIImage * image = [imageParams objectForKey:[keys firstObject]];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];//对SSL做处理，防止上传失败
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
//    manager.securityPolicy = securityPolicy;
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 120;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    [manager POST:strUrl parameters:dataParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:[keys firstObject] fileName:[NSString stringWithFormat:@"%@.jpeg",[keys firstObject]] mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation operation, id responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation operation, NSError *error) {
//        if (fail) {
//            fail(error);
//        }
//    }];
//}

@end
