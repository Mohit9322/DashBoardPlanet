//
//  APIRequestHelper.h
//  displayDeviceContact
//
//  Created by Planet on 2/15/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark- HTTP API response codes
static NSInteger const HTTPSuccessStatus = 200;

#pragma mark - API Request Content Types
static NSString *const kReachableServer                                     = @"www.google.com";
static NSString *const kContentType                                         = @"Content-Type";
static NSString *const kContentTypeText                                     = @"text/html";
static NSString *const kContentTypeJSON                                     = @"application/json";
static NSString *const kContentTypeFormData                                 = @"application/x-www-form-urlencoded";
static NSString *const kContentTypeImage                                    = @"image/jpeg";
static NSString *const kDefaultImageName                                    = @"photo.jpg";

#pragma mark -----API Services Name---------
static NSString *const  kAPIGetPasscode                                     = @"GetPasscode";
static NSString *const  kAPICreateUserProfile                               = @"CreateUserProfile";
static NSString *const  kAPIGetUserProfile                                  = @"GetUserProfile";
static NSString *const  kEditUseProfile                                     = @"EditUseProfile";
static NSString *const  kContactVerification                                = @"ContactVerification";

static NSString *const  kAPILoginApi                                        = @"Loginapi";
static NSString *const  kAPIGroupInvitationAction                           = @"GroupInvitationAction";
static NSString *const  kAPIGetGroupInvitationDetails                       = @"GetGroupInvitationDetails";
static NSString *const  kAPIGetUserGroups                                   = @"GetUserGroups";
static NSString *const  kAPIGetGroupPost                                    = @"GetGroupPost";
static NSString *const  kAPIGetGroupUpdates                                 = @"GetGroupUpdates";
static NSString *const  kAPIGetPostUpdates                                  = @"GetPostUpdates";

static NSString *const  kAPISetLikePost                                     = @"SetLikePost";
static NSString *const  kAPISetFavoritePost                                 = @"SetFavoritePost";
static NSString *const  kAPIRemoveUserFromGroup                             = @"RemoveUserFromGroup";

static NSString *const  kMyConnection                                       = @"MyConnection";
static NSString *const kAPIGetConnectionSentRequest                         = @"GetConnectionSentRequest";
static NSString *const kAPIGetConnectionRecievedRequest                     = @"GetConnectionRecievedRequest";
static NSString *const  kAPIInviteContact                                   = @"InviteContact";
static NSString *const  kAPIRemoveMyConnection                              = @"RemoveMyConnection";

static NSString *const  kAPIAcceptConnectionRequest                         = @"AcceptRequestReceived";
static NSString *const  kAPIRejectConnectionRequest                         = @"RejectRequestReceived";
static NSString *const  kAPICancelSentRequest                               = @"CancelSentRequest";
static NSString *const  kAPIInviteSocialContact                             = @"InviteSocialContact";

static NSString *const  kAPIGetMyConnectionFriends                          = @"GetMyConnectionFriends";
static NSString *const  kAPIGetMyConnectionGroups                           = @"GetMyConnectionGroups";

static NSString *const  kAPIGetMyRequestedGroups                            = @"GetMyRequestedGroups";
static NSString *const  kAPISendGroupRecommendations                        = @"SendGroupRecommendations";
static NSString *const  kAPIRemoveRecommendedGroups                         = @"RemoveRecommendedGroups";
static NSString *const  kAPIGetRecommendedGroups                            = @"GetRecommendedGroups";
static NSString *const  kAPIShowInterest                                    = @"ShowInterest";
static NSString *const  kAPIRemoveRequestedGroup                            = @"RemoveRequestedGroup";
static NSString *const  kAPICancelInvitationGroup                           = @"CancelInvitationGroup";

static NSString *const  kAPIGetSurveyDetails                                = @"GetSurveyDetails";
static NSString *const  kAPISubmitSurvey                                    = @"SubmitSurvey";

#pragma mark - API Base Key
static NSString *const  kSuccess                                            = @"Success";
static NSString *const  kResult                                             = @"Result";
static NSString *const  kRecords                                            = @"Records";

#pragma mark - Message Displayed In API Response
@interface APIRequestHelper : NSObject     {
    
}
@property(nonatomic, strong)NSDictionary *apiDict;

+(APIRequestHelper*)requestHelper;
-(NSString*) getBaseURL;
-(NSString*)getAPIKeyword:(NSString*)name;

@end
