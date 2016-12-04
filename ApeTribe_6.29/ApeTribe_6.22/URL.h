//
//  URL.h
//  XMLForOSC_6_23_2
//
//  Created by guan song on 16/6/23.
//  Copyright © 2016年 hexiulian. All rights reserved.
//

#ifndef URL_h
#define URL_h


#endif /* URL_h */

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//===================Mine============================
#define SERVER @"https://www.oschina.net"
/**
 *  参数说明
 *  client_id  ：应用ID
 *  redirect_uri :回调code的地址
 *  response_type  ：响应类型值（code）接口固定
 */
#define OAUTH2_URL @"https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=Vp4sfXhFHT3BxW7TCAhS&redirect_uri=http://www.iosschool.org/auth/index.php"
//登录地址
#define kAccessTokenURL @"https://www.oschina.net/action/openapi/token?"
//登录参数
/**
 *  参数说明
 *  client_id 应用ID
 *  redirect_uri  回调地址
 *  dataType  返回参数类型
 *  client_secret  应用私钥
 *  grant_type  接口固定值（uthorization_code）
 *  code  第一次请求回来的授权码
 *
 *  @return
 */
#define LOGINPARAM @"client_id=Vp4sfXhFHT3BxW7TCAhS&redirect_uri=http://www.iosschool.org/auth/index.php&dataType=xml&client_secret=a8ZUv2pVp363EW4heRSlvF4IPK9ctJsu&grant_type=authorization_code&code="
//iOS js交互，自动填写表单内容，直接返回用户信息
#define JS(email,pwd)[NSString stringWithFormat:@"var  $email = document.getElementById(\"f_email\");$email.value = \"%@\";var $pwd = document.getElementById(\"f_pwd\");$pwd.value = \"%@\";$(\"input[name='authorize']\").click();",email,pwd]
// 第二次登陆
#define AGAINJS @"$(\"input[name='authorize']\").click();"

#define URL_LOGIN_LIST @"action/openapi/user"
#define PARAM_LOGIN_LIST(access_token,dataType) @{@"access_token":access_token,@"dataType":dataType}
// 用户本人
#define URL_USERINFO_LIST @"action/openapi/my_information"
#define PARAM_USERINFO_LIST(access_token,dataType) @{@"access_token":access_token,@"dataType":dataType}
// 一般用户
#define URL_USER_LIST @"action/openapi/user_information"
#define PARAM_USER_LIST(access_token,userId,friendId,dataType) @{@"access_token":access_token,@"user":@(userId),@"friend":@(friendId),@"dataType":dataType}
//#define PARAM_USER_LIST(access_token,userId,friend_name,dataType) @{@"access_token":access_token,@"user":@(userId),@"friend_name":friend_name,@"dataType":dataType}

#define URL_FAVORITE_LIST @"action/openapi/favorite_list"
// type：0-全部|1-软件|2-话题|3-博客|4-新闻|5代码|7-翻译
#define PARAM_FAVORITE_LIST(type,page,pageSize,access_token,dataType) @{@"type":@(type),@"page":@(page),@"pageSize":@(pageSize),@"access_token":access_token,@"dataType":dataType}

#define URL_FRIEND_LIST @"action/openapi/friends_list"
#define PARAM_FRIEND_LIST(page,pageSize,relation,access_token,dataType) @{@"page":@(page),@"pageSize":@(pageSize),@"relation":@(relation),@"access_token":access_token,@"dataType":dataType}
// 更新关系：关注，取消关注
#define URL_UPDATE_RELATION_LIST @"action/openapi/update_user_relation"
// friend:对方用户id
#define PARAM_UPDATE_RELATION_LIST(friend,relation,access_token,dataType) @{@"friend":@(friend),@"relation":@(relation),@"access_token":access_token,@"dataType":dataType}




#define URL_ACTIVE_LIST @"action/openapi/active_list"
// catalog:类别ID [ 0、1所有动态,2提到我的,3评论,4我自己 ]
// user:用户ID
#define PARAM_ACTIVE_LIST(user,catalog,page,pageSize,access_token,dataType) @{@"user":@(user),@"catalog":@(catalog),@"page":@(page),@"pageSize":@(pageSize),@"access_token":access_token,@"dataType":dataType}

#define PARAM_OTHER_ACTIVE_LIST(user,catalog,page,pageSize,access_token,dataType) @{@"user":@(user),@"catalog":@(catalog),@"page":@(page),@"pageSize":@(pageSize),@"access_token":access_token,@"dataType":dataType}

#define URL_MSG_LIST @"action/openapi/message_list"
#define PARAM_MSG_LIST(page,pageSize,access_token,dataType) @{@"page":@(page),@"pageSize":@(pageSize),@"access_token":access_token,@"dataType":dataType}

#define URL_MINE_BLOG_LIST @"action/openapi/user_blog_list"
#define PARAM_MINE_BLOG_LIST(authoruid,page,pageSize,access_token,dataType) @{@"authoruid":@(authoruid),@"page":@(page),@"pageSize":@(pageSize),@"access_token":access_token,@"dataType":dataType}

//================api===========


//#define URL_LOGIN_LIST @"login_validate"
//#define PARAM_LOGIN_LIST(username,pwd) @{@"username":username,@"pwd":pwd}
//
//#define URL_USERINFO_LIST @"my_information"
//#define PARAM_USERINFO_LIST(uid) @{@"uid":@(uid)}
#define URL_FRIENDS_LIST @"friends_list"
// relation：0:粉丝 1：关注的
// all：0：分页 1：不分页
#define PARAM_FRIENDS_LIST(uid,page,pageSize,relation,all) @{@"uid":@(uid),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize),@"relation":@(relation),@"all":@(all)}

#define URL_PORTRAIT_UPDATE_LIST @"action/openapi/portrait_update"
#define PARAM_PORTRAIT_UPDATE_LIST(access_token,dataType) @{@"access_token":access_token,@"dataType":dataType}

#define URL_FEEDBACK_LIST @"user_report_to_admin"
#define PARAM_FEEDBACK_LIST(app,report,msg) @{@"app":@(app),@"report":@(report),@"msg":msg}

//========================================================


#define  URL_HTTP_PREFIX @"http://www.oschina.net/action/api/"
#define  URL_HTTP_OPENPREFIX @"http://www.oschina.net/action/openapi/"
//--------------------------------  G
#define URL_NEW_LIST @"news_list"
#define URL_NEW_DETAIL_LIST @"news_detail"
#define PARAM_NEW_LIST(catalog,pageIndex,pageSize) @{@"catalog":@(catalog),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}


#define URL_BLOGGER_LIST @"blog_list"
#define URL_BLOGGER_DETAIL_LIST @"blog_detail"
#define PARAM_BLOGGER_LIST(type,pageIndex,pageSize) @{@"type":type,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}


#define URL_EVENT_LIST @"event_list"
#define URL_EVENT_DETAIL_LIST @"post_detail"
#define PARAM_EVENT_LIST(uid,pageIndex,pageSize) @{@"type":uid,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

#define URL_ANSWER_LIST @"post_list"
#define PARAM_ANSWER_LIST(catalog,pageIndex,pageSize) @{@"catalog":@(catalog),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}
#define URL_POST_DETAIL @"post_detail"
#define PARAM_POST_TAG_LIST(tag,pageIndex,pageSize) @{@"tag":tag,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

#define URL_COMMENT_LIST @"comment_list"
#define PARAM_COMMENT_LIST(catalog,ID,pageIndex,pageSize) @{@"catalog":@(catalog),@"id":@(ID),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

#define URL_ADD_FAVORITE @"favorite_add"

#define URL_DELETE_FAVORITE @"favorite_delete"

#define PARAM_FAVORITE(uid,objid,type) @{@"uid":@(uid),@"objid":@(objid),@"type":@(type)}

#define URL_COMMENT_PUB @"comment_pub"
#define PARAM_COMMENT_PUB(catalog,id,uid,content,isPostToMyZone) @{@"catalog":@(catalog),@"id":@(id),@"uid":@(uid),@"content":content,@"isPostToMyZone":@(isPostToMyZone)}

#define URL_EVENT_APPLY @"event_apply"
#define PARAM_EVENT_APPLY(eventID,user,name,gender,mobile,company,job) @{@"event":@(eventID),@"user":@(user),@"name":name,@"gender":gender,@"mobile":mobile,@"company":company,@"job":job}
//---------------------------------------------



#define PARAM_ANSWER_LIST(catalog,pageIndex,pageSize) @{@"catalog":@(catalog),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

//----------------------漫谈--------------------------
#define URL_TWEET_LIST @"tweet_list"
#define PARAM_TWEET_LIST(uid,pageSize,pageIndex) @{@"uid":uid,@"pageSize":@(pageSize),@"pageIndex":@(pageIndex)}

#define URL_TWEET_DETAIL @"tweet_detail"
#define PARAM_TWEET_DETAIL(id)@{@"id":@(id)}

#define URL_TWEET_COMMENT @"comment_list"
#define PARAM_TWEET_COMMENT(catalog,id,pageIndex,pageSize) @{@"catalog":@(catalog),@"id":@(id),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

#define URL_TWEET_LIKELIST @"tweet_like_list"
#define PARAM_TWEET_LIKELIST(tweetid,pageIndex,pageSize) @{@"tweetid":@(tweetid),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}

#define URL_TWEET_LIKE @"tweet_like"
#define PARAM_TWEET_LIKE(uid,tweetid,ownerOfTweet) @{@"uid":@(uid),@"tweetid":@(tweetid),@"ownerOfTweet":@(ownerOfTweet)}

#define URL_TWEET_UNLIKE @"tweet_unlike"
#define PARAM_TWEET_UNLIKE(uid,tweetid,ownerOfTweet) @{@"uid":@(uid),@"tweetid":@(tweetid),@"ownerOfTweet":@(ownerOfTweet)}

#define URL_TWEET_DELETE @"tweet_delete"
#define PARAM_TWEET_DELETE(uid,tweetid)@{@"uid":@(uid),@"tweetid":@(tweetid)} 

//---------------------------------------------------


#define URL_SOFTWARE_LIST @"software_list"
#define URL_SOFTWARECATALOG_LIST @"softwarecatalog_list"
#define URL_SOFTWARETAG_LIST @"softwaretag_list"
#define URL_SOFTWARE_DETAIL @"software_detail"
#define URL_TWEET_PUB @"tweet_pub"
#define URL_ROCK_ROCK @"rock_rock"
#define URL_FINF_USER @"find_user"
#define URL_FRIENDS_LIST @"friends_list"
#define URL_SOFTWARE_TWEET_LIST @"software_tweet_list"
#define URL_SOFTWARE_TWEET_PUB @"software_tweet_pub"
#define URL_COMMENT_PUB @"comment_pub"
#define URL_FAVORITE_ADD @"favorite_add"
#define URL_FAVORITE_DELETE @"favorite_delete"
#define URL_SEARCH_LIST @"search_list"
#define PARAM_SOFTWARE_DETAIL(ident) @{@"ident":@"ident"}










