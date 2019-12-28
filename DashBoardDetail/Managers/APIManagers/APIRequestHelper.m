//
//  APIRequestHelper.m
//  displayDeviceContact
//
//  Created by Planet on 2/15/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "APIRequestHelper.h"
static NSString *const  kAPIKeyDictName                    = @"API Keywords";
static NSString *const  kBaseURLLive                       = @"BaseURLLive";
static NSString *const  kBaseURLDemo                       = @"BaseURLDemo";
@implementation APIRequestHelper
@synthesize apiDict;

+(nonnull APIRequestHelper*)requestHelper   {
    static APIRequestHelper* _APIHelper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _APIHelper = [[APIRequestHelper alloc] init];
    });
    return _APIHelper;
}

- (id)init {
    if ((self = [super init])) {
        [self initializeAPIDict];
    }
    return self;
}

-(void)dealloc  {
    apiDict = nil;
}

-(void) initializeAPIDict   {
    @synchronized([APIRequestHelper class]) {
        if(!apiDict)    {
            NSString *path = [[NSBundle mainBundle] pathForResource:
                              @"API" ofType:@"plist"];
            apiDict = [[NSDictionary alloc] initWithContentsOfFile:path];
            path = nil;
        }
    }
}

-(NSString*) getBaseURL {
    if(!apiDict)
        [self initializeAPIDict];
    
    return [apiDict valueForKey: kBaseURLLive];
}

-(NSString*)getAPIKeyword:(NSString*)name {
    if(!apiDict)
        [self initializeAPIDict];
    
    return [[apiDict objectForKey:kAPIKeyDictName] objectForKey:name];
}

@end
