//
//  APIManager.m
//  dashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "APIManager.h"
static NSString *const kAPIQueue    = @"com.ePazer.APIQueue";

@interface APIManager()

@property (nonatomic, strong) AFNetworkReachabilityManager           *_NetworkReachabilityManager;
@property (nonatomic, strong) AFHTTPSessionManager                   *_SessionManager;
@property (nonatomic, strong) NSURLSession                           *_FileTranserSessionManager;
@property (nonatomic, strong) NSString                               *_apiTextDocumentPath;

@end
@implementation APIManager
@synthesize     _NetworkReachabilityManager;
@synthesize     _SessionManager;
@synthesize     _FileTranserSessionManager;
@synthesize     _apiTextDocumentPath;

/**To access the singleton methods*/
+(APIManager*)APIManager    {
    static APIManager *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIManager alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    if ((self = [super init])) {
        // initialize the singleton object
        if (!_SessionManager)   {
            _SessionManager = [AFHTTPSessionManager manager];
            _SessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            _SessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
            [_SessionManager.requestSerializer setTimeoutInterval:1000];
            _SessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:kContentTypeJSON];
            [_SessionManager.requestSerializer setValue:kContentTypeJSON forHTTPHeaderField:kContentType];
            [_SessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            [_SessionManager.requestSerializer setTimeoutInterval:1000];
            [_SessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            _FileTranserSessionManager = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            /***********************************************************************************/
            dispatch_queue_attr_t queueAttrs = dispatch_queue_attr_make_with_qos_class(
                                                                                       DISPATCH_QUEUE_SERIAL,
                                                                                       QOS_CLASS_USER_INITIATED /* Same as DISPATCH_QUEUE_PRIORITY_HIGH */,
                                                                                       0
                                                                                       );
            dispatch_queue_t apiResponseQueue = dispatch_queue_create([kAPIQueue UTF8String], queueAttrs);
            [_SessionManager setCompletionQueue:apiResponseQueue];
        }
    }
    return self;
}

#pragma mark- API Request Mathods Implementation
//mathod to intialize the manager class
-(void)initializeNetworkObject  {
    [self initializeAFManager];
}

/**To initialize the networkReachabilityManager object*/
-(void)initializeAFManager {
    _NetworkReachabilityManager = [AFNetworkReachabilityManager managerForDomain:kReachableServer];
    [_NetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
                break;
            default:
                break;
        }
    }];
    
    [_NetworkReachabilityManager startMonitoring];
}

/**Get current network status*/
-(BOOL)getNetworkStatus {
    if(_NetworkReachabilityManager.reachable)  {
        return YES;
    }
    else    {
        return NO;
    }
}

#pragma mark - Base method to get data from server
-(void)apiRequestWithAPI:(NSString *)apiName parameters:(NSDictionary *)parameters
                 success:(iSuccess) success failure:(iFailure) failure    {
    //   if(_NetworkReachabilityManager.reachable)  {
    NSString* apiURL = [NSString stringWithFormat:@"%@/api/%@", [[APIRequestHelper requestHelper] getBaseURL],
                        [[APIRequestHelper requestHelper] getAPIKeyword:apiName]];
    
    NSString *apiURL1 = @"http://dev.icanstay.com/api/Loginapi/Login?userName=icanstay&password=ics@2016";
    
    /************************Temp Code*******************************/
#ifdef DEBUG
    if(parameters)  {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"APIURL: %@ \n%@", apiURL, jsonString);
    }
#endif
    /************************Temp Code*******************************/
    [_SessionManager POST:apiURL1 parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self checkStatus:responseObject status:^(Status statusCode, NSString *message){
            if(statusCode == StatusSuccess){
                success(StatusSuccess, responseObject);
            }
            else
                failure(StatusFail, message);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(StatusFail, [error localizedDescription]);
        
    }];
    apiURL = nil;
    //    }
    //    else    {
    //        //To manage the dead lock in two thread. We must execute code on completionQueue asynchronously.
    //        dispatch_async([_SessionManager completionQueue], ^{
    //            failure(StatusFail, @"Device does not connect to internet.");
    //        });
}
//}

#pragma mark - Base method to get data from server without parametres
-(void)apiRequestWithOutParameters:(NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure    {
    
  //  id parameters = nil;
    [_SessionManager POST:apiURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(StatusSuccess, responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(StatusFail, [error localizedDescription]);
        
    }];
    apiURL = nil;
}


#pragma mark - Base method to upload the image
/**This method is used to upload the multiple images to server. Array must have object of nsdata*/
-(void) apiRequestToUploadImagesWithAPI:(NSString *)apiName
                             parameters:(NSDictionary *)parameters
                                 images:(NSArray *)imageStore
                                success:(iSuccess) success failure:(iFailure)failure   {
    if(_NetworkReachabilityManager.reachable)  {
        NSString* apiURL = [NSString stringWithFormat:@"%@/api/%@", [[APIRequestHelper requestHelper] getBaseURL], [[APIRequestHelper requestHelper] getAPIKeyword:apiName]];
        /************************Temp Code*******************************/
#ifdef DEBUG
        if(parameters)  {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"APIURL: %@ \n%@", apiURL, jsonString);
        }
#endif
        /************************Temp Code*******************************/
        [_SessionManager POST:apiURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [imageStore enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull imageDict, NSUInteger idx, BOOL * _Nonnull stop) {
                [formData appendPartWithFileData:[imageDict objectForKey:@"UploadDataImage"]
                                            name:[imageDict objectForKey:@"Upload Image Name"]
                                        fileName:kDefaultImageName
                                        mimeType:kContentTypeImage];
            }];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self checkStatus:responseObject status:^(Status statusCode, NSString *message){
                if(statusCode == StatusSuccess){
                    success(StatusSuccess, responseObject);
                }
                else
                    failure(StatusFail, message);
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(StatusFail, [error localizedDescription]);
        }];
        apiURL = nil;
    }
    else    {
        //To manage the dead lock in two thread. We must execute code on completionQueue asynchronously.
        dispatch_async([_SessionManager completionQueue], ^{
            failure(StatusFail, @"Device does not connect to internet.");
        });
    }
}

/**Download file from server and save to target URL (document directory URL). If error occured, return nil*/
-(void) downloadFileWithServerURL:(NSString *) serverURL completion:(iCompletion) completion {
    if(_NetworkReachabilityManager.reachable)  {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]];
        [[_FileTranserSessionManager dataTaskWithRequest:request
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           if(error)    {
                                               completion(StatusFail, nil);
                                           }
                                           else {
                                               completion(StatusSuccess, data);
                                           }
                                       }] resume];
        
        request = nil;
    }
    else    {
        //To manage the dead lock in two thread. We must execute code on completionQueue asynchronously.
        dispatch_async([_SessionManager completionQueue], ^{
            completion(StatusFail, nil);
        });
    }
}

#pragma mark- Check the API response
-(void)checkStatus:(id) responseObject status:(iSuccess) success  {
#ifdef DEBUG
    NSLog(@"APIRESPONSE: %@",responseObject);
    
#endif
    
    if([[responseObject objectForKey:kStatus] integerValue] ==  HTTPSuccessStatus)  {
        success(StatusSuccess, [responseObject objectForKey:kMessage]);
        
    }
    else    {
        success(StatusFail, [responseObject objectForKey:kMessage]);
    }
}

#pragma  mark - -------------------- API Methods -----------------------------

/************** Login Api **********************/
- (void)loginApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* Dashboard detail Api **********************/
- (void)dashBoardDetailApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* VoucherSaleReport_Daywise **********************/
- (void)VoucherSaleReportDaywise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* VoucherSaleReport_Monthwise **********************/
- (void)VoucherSaleReportMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* VoucherSaleReport_Monthwise Two Previous **********************/
- (void)VoucherSaleReportTwoBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* VoucherSaleReport_Monthwise Previous **********************/
- (void)VoucherSaleReportPreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* VoucherSaleReport_Monthwise BeforePreviousMonth  **********************/
- (void)VoucherSaleReportBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* VoucherSaleReport_Yearwise **********************/
- (void)VoucherSaleReportYearwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* User registration DayWise **********************/
- (void)userRegDayWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* User registaration Month wise **********************/
- (void)userRegMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* User registaration Month wise **********************/
- (void)userRegPreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* User registaration Month wise **********************/
- (void)userRegBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* User registaration two previous month **********************/
- (void)userRegTwoBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* user registaration year wise **********************/
- (void)userRegYearWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* user registaration All **********************/
- (void)UserRegReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/*********************  App downloads Detail ****************/
- (void)AppDownLoadsDetailApi:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [_SessionManager GET:apiURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(StatusSuccess, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(StatusFail, [error localizedDescription]);
        
    }];
    apiURL = nil;
}
/******************* Voucher Sale Report All **********************/
- (void)VoucherSaleReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}


/******************* Voucher Sold New Existing User Check **********************/
- (void)VoucherSoldNewExistingUserCheck:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* Inventory Details **********************/
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
/******************* Inventory Detail Tomorrow **********************/
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}

/******************* Inventory Detail Day after Tomorrow **********************/
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure {
    
    [self apiRequestWithOutParameters:apiURL success:^(Status iStatus, id response) {
        success(iStatus, response);
    }failure:^(Status iStatus, NSString *errorMessage){
        failure(iStatus, errorMessage);
    }];
}
@end
