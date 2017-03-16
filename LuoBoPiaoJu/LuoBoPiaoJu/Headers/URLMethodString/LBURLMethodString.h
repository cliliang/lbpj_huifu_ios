//
//  LBURLMethodString.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#define UIKIT_EXTERN	        extern __attribute__((visibility ("default")))
#import <Foundation/Foundation.h>

/**
 *  ------------ 登录
 */
extern NSString *const url_login;
/**
 *  ------------ 注册
 */
extern NSString *const url_regist;
/**
 *  ------------ 常见问题分类查询
 */
extern NSString *const url_questionSearch;
/**
 *  ------------ 常见问题
 */
extern NSString *const url_question;
/**
 *  ------------ 上传用户头像
 */
extern NSString *const url_updateHeadPic;
/**
 *  ------------ 活动中心
 */
extern NSString *const url_activity;
/**
 *  ------------ 吐槽
 */
extern NSString *const url_feedBack;
/**
 *  ------------ 联系我们
 */
extern NSString *const url_contactUs;
/**
 *  ------------ 签到
 */
extern NSString *const url_signIn;
/**
 *  ------------ 用户消息中心
 */
extern NSString *const url_messageCenter;
/**
 *  ------------ 上传票据
 */
extern NSString *const url_uploadTicket;
/**
 *  ------------ 产品
 */
extern NSString *const url_product;
/**
 *  ------------ 验证码
 */
extern NSString *const url_yanZhengMa;
/**
 *  ------------ 验证输入验证码是否正确
 */
extern NSString *const url_yanzhengmaSure;
/**
 *  ------------ 修改密码
 */
extern NSString *const url_changePassword;
/**
 *  ------------ 用户读取消息
 */
extern NSString *const url_readMessage;
/**
 *  ------------ 消息一键已读
 */
extern NSString *const url_readAllMessage;
/**
 *  ------------ 检查用户
 */
extern NSString *const url_jianChaYongHu;
/**
 *  ------------ 修改手机号
 */
extern NSString *const url_changePhoneNumber;
/**
 *  ------------ 存管通 - 开户
 */
extern NSString *const url_KaiHu;
/**
 *  ------------ 存管通_绑定银行卡
 */
extern NSString *const url_bindingBankCard;
/**
 *  ------------ 充值
 */
extern NSString *const url_huifuCongzhi;
/**
 *  ------------ 提现
 */
extern NSString *const url_huifuTixian;
/**
 *  ------------ 支付
 */
extern NSString *const url_huifuZhifu;
/**
 *  ------------ 更新用户
 */
extern NSString *const url_updateUser;
/**
 *  ------------ 获得银行卡 的 银行名称
 */
extern NSString *const url_whichBank;
/**
 *  ------------ 查找银行卡
 */
extern NSString *const url_searchBankCard;
/**
 *  ------------ 查询我的订单, 投资中, 还款中, 已还款
 */
extern NSString *const url_searchThreeTypeOrder;
/**
 *  ------------ 查询所有公告, 不分页
 */
extern NSString *const url_searchAllNews;
/**
 *  ------------ 总资产
 */
extern NSString *const url_getAllMoney;
/**
 *  ------------ 获取手机端首页Banner图
 */
extern NSString *const url_HuoQuShouYeBanner;
/**
 *  ------------ 首页接口
 */
extern NSString *const url_Shouyejiekou;
/**
 *  ------------ 交易记录
 */
extern NSString *const url_jiaoYiJiLu;
/**
 *  ------------ 查询我的萝卜快赚投资数据
 */
extern NSString *const url_wodeluobokuaizhuan;
/**
 *  ------------ 得到可赎回列表
 */
extern NSString *const url_keshuhuiList;
/**
 *  ------------ 赎回接口
 */
extern NSString *const url_ShuHui;
/**
 *  ------------ 产品详情接口
 */
extern NSString *const url_chanPinXiangQing;
/**
 *  ------------ 单个产品的交易记录
 */
extern NSString *const url_DanGeJiaoYiJiLu;
/**
 *  ------------ 购买产品非本息
 */
extern NSString *const url_goumaiFeibenxi;
/**
 *  ------------ 购买产品本息
 */
extern NSString *const url_goumaiBenxi;
/**
 *  ------------ 上传吐槽接口
 */
extern NSString *const url_shangChuanTuCao;
/**
 *  ------------ 汇付可支持银行卡列表(所有)
 */
extern NSString *const url_AllBankCardList;
/**
 *  ------------ 修改手势密码
 */
extern NSString *const url_ChangeGesturePassword;
/**
 *  ------------ 推送: 给服务器上传 deviceToken
 */
extern NSString *const url_Push_UploadDeviceToken;
/**
 *  ------------ 查询是否有未读消息
 */
extern NSString *const url_isHaveNotReadMessage;
/**
 *  ------------ 查询福利中心优惠券
 */
extern NSString *const url_searchBenefitBill;
/**
 *  ------------ 查询福利中心优惠券使用记录
 */
extern NSString *const url_searchBenefitBillRecord;
/**
 *  ------------ 邀请记录，查询所有邀请接口
 */
extern NSString *const url_searchAllInvitedList;
/**
 *  ------------ 体验金详情
 */
extern NSString *const url_experienceMoneyDetail;
/**
 *  ------------ 体验金购买接口
 */
extern NSString *const url_experienctMoneyBuy;
/**
 *  ------------ 签到的接口
 */
extern NSString *const url_signInNew;
/**
 *  ------------ 红包列表接口
 */
extern NSString *const url_getHongBaoList;
/**
 *  ------------ 领取红包接口
 */
extern NSString *const url_getHongBaoMoney;
/**
 *  ------------ 发现列表接口
 */
extern NSString *const url_getFaXianList;
/**
 *  ------------ 购买页查询可用红包
 */
extern NSString *const url_searchUsableHongbao;
/**
 *  ------------ 刮刮乐领取
 */
extern NSString *const url_lingquGuaGuaLe;
/**
 *  ------------ 验证token接口，给后台传token，后台吧user里的token改变
 */
extern NSString *const url_judgeToken;
/**
 *  ------------ 签到记录接口
 */
extern NSString *const url_signInRecord;
/**
 *  ------------ 设置签到提醒接口
 */
extern NSString *const url_setSignInAlert;
/**
 *  ------------ 查询萝卜币
 */
extern NSString *const url_getLuoboBiCount;
/**
 *  ------------ 兑换萝卜币
 */
extern NSString *const url_exchangeLuoboBi;
/**
 *  ------------ 新首页产品接口;
 */
extern NSString *const url_shouYeProduct;
/**
 *  ------------ 广告业接口;
 */
extern NSString *const url_guangGaoImageUrl;
/**
 *  ------------ 新活期接口;
 */
extern NSString *const url_HuoQi_2_2_6;
/**
 *  ------------ 快速注册;
 */
extern NSString *const url_fastRegist;
/**
 *  ------------ 快速登录;
 */
extern NSString *const url_fastLogin;
/*
 *  ------------ 解绑;
 */
extern NSString *const url_jieBang;
/*
 *  ------------ 获取appStore版本号;
 */
extern NSString *const url_appStoreVersion;











