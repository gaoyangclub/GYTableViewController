//
//  Mock.m
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "Mock.h"
#import "TVStyle.h"

static NSArray<NSString *> *_bannerUrlGroup;
static NSArray<HotModel *> *_hotModels;
static NSArray<FundModel *> *_fundModels;
static NSArray<FundModel *> *_fundNewModels;

static NSArray<DishesModel *> *_dishesModels;

static PraiseModel *_praiseModel;
static NSArray<StoreModel *> *_storeModels;

static NSArray<ExpressModel *> *_expressModels;

static NSArray<WeiboModel *> *_weiboModels;

@implementation Mock

//----------  start ----------
#pragma mark RefreshDemo数据
+ (NSArray<NSString *> *)bannerUrlGroup {
    if (!_bannerUrlGroup) {
        _bannerUrlGroup = @[
                            @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                            @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                            ];
    }
    return _bannerUrlGroup;
}

+ (NSArray<HotModel *> *)hotModels {
    if (!_hotModels) {
        _hotModels = @[
                       [HotModel initWithParams:@"大盘走势" iconName:@"fundHot01"],
                       [HotModel initWithParams:@"投资咨询" iconName:@"fundHot02"],
                       [HotModel initWithParams:@"收益排行" iconName:@"fundHot03"],
                       [HotModel initWithParams:@"我的关注" iconName:@"fundHot04"]
                       ];
    }
    return _hotModels;
}

+ (NSArray<FundModel *> *)fundModels {
    if (!_fundModels) {
        _fundModels = @[
                        [FundModel initWithParams:@"开放式" iconName:TVStyle.iconKaiFang des:@"国泰医药行业指数分级" rate:@"100%"],
                        [FundModel initWithParams:@"股票式" iconName:TVStyle.iconGuPiao des:@"光大国企改革主题股票" rate:@"100%"],
                        [FundModel initWithParams:@"债券型" iconName:TVStyle.iconZhaiQuan des:@"华泰铂锐稳本增利债券A" rate:@"100%"],
                        [FundModel initWithParams:@"混合型" iconName:TVStyle.iconHunHe des:@"中海医药精选灵活配置A" rate:@"100%"],
                        [FundModel initWithParams:@"货币基金" iconName:TVStyle.iconHuoBi des:@"华商现金增利货币A" rate:@"100%"],
                        [FundModel initWithParams:@"短期理财" iconName:TVStyle.iconDuanQi des:@"融通七天债A" rate:@"100%"],
                        [FundModel initWithParams:@"指数型" iconName:TVStyle.iconZhiShu des:@"易方达银行指数分级" rate:@"100%"],
                        [FundModel initWithParams:@"保本型" iconName:TVStyle.iconBaoBen des:@"长城保本混合" rate:@"100%"],
                        [FundModel initWithParams:@"创新型" iconName:TVStyle.iconChuangXin des:@"华夏医疗健康混合A" rate:@"100%"],
                        ];
    }
    return _fundModels;
}

+ (NSArray<FundModel *> *)fundNewModels {
    if (!_fundNewModels) {
        _fundNewModels = @[
                           [FundModel initWithParams:@"QDII" iconName:TVStyle.iconZhuZhuang des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:TVStyle.iconZhuZhuang des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:TVStyle.iconZhuZhuang des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:TVStyle.iconZhuZhuang des:@"易方达恒生ETF链接" rate:@"100%"],
                           ];
    }
    return _fundNewModels;
}

//----------  end ----------

//----------  start ----------
#pragma mark FrameDemo数据
+ (NSArray<DishesModel *> *)dishesModels {
    if (!_dishesModels) {
        _dishesModels = @[
                          [DishesModel initWithParams:@"苹果iphone X" iconName:@"https://img13.360buyimg.com/n7/jfs/t10675/253/1344769770/66891/92d54ca4/59df2e7fN86c99a27.jpg" des:@"亮黑色 64G 移动网络" price:@"9999" linkUrl:@"https://item.jd.com/5089253.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 8Plus" iconName:@"https://img10.360buyimg.com/n7/jfs/t9313/81/1352027902/75682/4abc569f/59b85834Ne59b864d.jpg" des:@"金色 64G 电信网络" price:@"7999" linkUrl:@"https://item.jd.com/5089255.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 8" iconName:@"https://img10.360buyimg.com/n7/jfs/t9085/22/907696059/71305/93f88c62/59b85847N20776d8e.jpg" des:@"玫瑰金 64G 联通网络" price:@"6999" linkUrl:@"https://item.jd.com/5089225.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 7Plus" iconName:@"https://img10.360buyimg.com/n7/jfs/t3250/72/1629247361/133742/e0c6726d/57d11c72N093250ec.jpg" des:@"银白色 32G 铁通网络" price:@"4999" linkUrl:@"https://item.jd.com/3133853.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 7" iconName:@"https://img12.360buyimg.com/n7/jfs/t3298/58/1622979569/120892/64989235/57d0d400Nfd249af4.jpg" des:@"黑色 32G 移动联通电信三网" price:@"4799" linkUrl:@"https://item.jd.com/3133827.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 6sPlus" iconName:@"https://img14.360buyimg.com/n7/jfs/t5140/192/441974492/110823/74933487/590006eeN1b438869.jpg" des:@"玫瑰金 32G 全网通" price:@"3488" linkUrl:@"https://item.jd.com/10889864874.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 6s" iconName:@"https://img10.360buyimg.com/n7/jfs/t8542/157/1597800234/74065/167610de/59bca2d3N524ff9a0.jpg" des:@"深空灰 16G 全网通" price:@"3568" linkUrl:@"https://item.jd.com/10523877650.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 6" iconName:@"https://img12.360buyimg.com/n7/jfs/t10171/45/2516117655/281637/4283887d/59f8519dN09f49351.jpg" des:@"土豪金 16G 移动网络" price:@"2135" linkUrl:@"https://item.jd.com/19036593197.html"],
                          
                          [DishesModel initWithParams:@"苹果iphone 5s" iconName:@"https://img11.360buyimg.com/n7/jfs/t10246/79/382654964/320569/45768bfc/59cdf9ebNbba2edac.jpg" des:@"金色 16G 电信网络" price:@"2135" linkUrl:@"https://item.jd.com/11464031106.html"],
                          
                          ];
    }
    return _dishesModels;
}

//----------  end ----------

//----------  start ----------
#pragma mark GapDemo数据
+ (PraiseModel *)praiseModel {
    if (!_praiseModel) {
        _praiseModel = [PraiseModel initWithParams:@"附近生活圈" hotModels:@[
                                                                         [HotModel initWithParams:@"老张牛肉面" iconName:@"https://img.meituan.net/msmerchant/6208ee8e69966ac794b0478c3f370e7f535324.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         [HotModel initWithParams:@"大雄家烧味" iconName:@"http://p1.meituan.net/mogu/c42e4c0fc12f25be4e35285951726a05245231.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         [HotModel initWithParams:@"谢大牛馆" iconName:@"https://img.meituan.net/msmerchant/c4d8a1cb9685fbbb22e121c7e637dcdc830432.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         ]];
    }
    return _praiseModel;
}

+ (NSArray<StoreModel *> *)storeModels {
    if (!_storeModels) {
        _storeModels = @[
                         [StoreModel initWithParams:@"金草帽炭火烤肉（望京店)" iconName:@"http://p0.meituan.net/600.600/deal/c8cc7a1c865e0b65504c5cafda09020f48188.jpg@1275w_1275h_1e_1c" hot:@"4.1分" des:@"周一至周日 全天" discount:@"9折"],
                         [StoreModel initWithParams:@"福口居（北太平庄店）" iconName:@"https://img.meituan.net/600.600/msmerchant/3ff5b78217da04bd79839e2b9a19ca02683868.jpg@1275w_1275h_1e_1c" hot:@"5分" des:@"人均￥63" discount:@"6折"],
                         [StoreModel initWithParams:@"比格比萨（西单明珠餐厅）" iconName:@"http://p0.meituan.net/600.600/mogu/92d839a7e0ef51b6dec3d1e2ba997bb5267281.jpg@1275w_1275h_1e_1c" hot:@"3.7分" des:@"西城区明珠商场8层" discount:@"5折"],
                         [StoreModel initWithParams:@"韩时烤肉（枫蓝国际购物中心店）" iconName:@"https://img.meituan.net/600.600/msmerchant/a5bd62d75978e6434d87735872c1b1b3287453.jpg@1275w_1275h_1e_1c" hot:@"4.5分" des:@"人均￥69" discount:@"8折"],
                         [StoreModel initWithParams:@"狗不理包子（前门店）" iconName:@"http://p0.meituan.net/600.600/deal/201211/09/_1109143551.jpg@1275w_1275h_1e_1c" hot:@"3.2分" des:@"西城区前门大栅栏街29-31号" discount:@"7折"],
                         [StoreModel initWithParams:@"虾吃虾涮（长楹天街店）" iconName:@"http://p0.meituan.net/600.600/deal/925a2357b79e829f92819a9b2e421c84294677.jpg@1275w_1275h_1e_1c" hot:@"4.5分" des:@"人均￥65" discount:@"5折"],
                         [StoreModel initWithParams:@"神话烤鱼香锅川菜（五道口店）" iconName:@"http://p0.meituan.net/600.600/mogu/71b47ffe74bf1c30e684ea61fec6c280206798.jpg@1275w_1275h_1e_1c" hot:@"4.1分" des:@"海淀区五道口华联商场往南300米" discount:@"9折"],
                         ];
    }
    return _storeModels;
}
//----------  end ----------


//----------  start ----------
#pragma mark RelateDemo数据
+ (NSArray<ExpressModel *> *)expressModels {
    if (!_expressModels) {
        _expressModels = @[
                           [ExpressModel initWithParams:@"货物已完成配送，感谢选择百世快递" year:@"2017-09-13" time:@"11:51"],
                           [ExpressModel initWithParams:@"配送员开始配送，请您准备收货" year:@"2017-09-13" time:@"07:41"],
                           [ExpressModel initWithParams:@"货物已分配，等待配送" year:@"2017-09-13" time:@"07:33"],
                           [ExpressModel initWithParams:@"货物已到达【广州体育站】" year:@"2017-09-13" time:@"06:21"],
                           [ExpressModel initWithParams:@"货物已完成分拣【广州亚-分拣中心】" year:@"2017-09-12" time:@"20:10"],
                           [ExpressModel initWithParams:@"货物已到达【广州亚-分拣中心】" year:@"2017-09-12" time:@"15:58"],
                           [ExpressModel initWithParams:@"货物已交付百世快递" year:@"2017-09-12" time:@"15:43"],
                           [ExpressModel initWithParams:@"货物已到达【广州总-分拣中心】" year:@"2017-09-12" time:@"15:31"],
                           
                           [ExpressModel initWithParams:@"货物已完成配送，感谢选择百世快递" year:@"2017-09-13" time:@"11:51"],
                           [ExpressModel initWithParams:@"配送员开始配送，请您准备收货" year:@"2017-09-13" time:@"07:41"],
                           [ExpressModel initWithParams:@"货物已分配，等待配送" year:@"2017-09-13" time:@"07:33"],
                           [ExpressModel initWithParams:@"货物已到达【广州体育站】" year:@"2017-09-13" time:@"06:21"],
                           [ExpressModel initWithParams:@"货物已完成分拣【广州亚-分拣中心】" year:@"2017-09-12" time:@"20:10"],
                           [ExpressModel initWithParams:@"货物已到达【广州亚-分拣中心】" year:@"2017-09-12" time:@"15:58"],
                           [ExpressModel initWithParams:@"货物已交付百世快递" year:@"2017-09-12" time:@"15:43"],
                           [ExpressModel initWithParams:@"货物已到达【广州总-分拣中心】" year:@"2017-09-12" time:@"15:31"],
                           ];
    }
    return _expressModels;
}

//----------  end ----------

//----------  start ----------
#pragma mark AutoHeightDemo数据
+ (NSArray<WeiboModel *> *)weiboModels {
    if (!_weiboModels) {
        _weiboModels = @[
                         [WeiboModel initWithParams:@"https://tvax4.sinaimg.cn/crop.0.0.512.512.180/7f9147a5ly8floqz4q2g3j20e80e8t8x.jpg" name:@"美食推荐" title:@"牛肉的各种吃法，分分钟让你口水直流" content:@"这些才是你该喝的饮料 【24种果蔬汁收藏夹】良心经验总结，这些蔬果一起榨汁最好喝！健健康康的果蔬汁喝起来吧~ ​​​​" imageUrl:@"https://tc.sinaimg.cn/maxwidth.800/tc.service.weibo.com/mmbiz_qpic_cn/6a1acdf39e872fac4a820c23cd333bb1.jpg"],
                         [WeiboModel initWithParams:@"https://tvax2.sinaimg.cn/crop.0.1.640.640.180/750c9a31ly8fgh2qosgznj20hs0huwfj.jpg" name:@"美妆博主" title:@"好用的水乳推荐" content:@"这大概是史上最全的口红种草了！不用All in也能拥有全世界最美的色号" imageUrl:@"https://wx3.sinaimg.cn/mw690/e75982c5gy1fn8z95so7xj20dn09ttav.jpg"],
                         [WeiboModel initWithParams:@"https://tva3.sinaimg.cn/crop.2.0.176.176.180/a180de74jw1ev38avqrrtj2052052t96.jpg" name:@"Happy" title:@"#刘若英#现场版《我们没有在一起》" content:@"奶茶说：在我小的时候，我常常觉得只要戴上皇冠，我就觉得自己是公主，披上一个被单我就觉得自己是超人，可以去拯救全世界。 但是人越长越大才发现，别说拯救全世界，有时候我连我自己都拯救不了，尤其在面对感情的时候，真的不是你一个人付" imageUrl:@"https://n.sinaimg.cn/sinacn21/112/w1027h685/20180323/3d2f-fysnevm3029472.jpg"],
                         [WeiboModel initWithParams:@"https://tva2.sinaimg.cn/crop.0.0.180.180.180/6232a59ajw1e8qgp5bmzyj2050050aa8.jpg" name:@"上帝之鹰" title:@"答案很简单" content:@"已经向当地公安部门报案相信党和政府能处理好此事，感谢大家的支持！ 感谢 @共青团中央 @人民日报 @紫光阁 @环球日报 @新华社 @南京玄武警方在线 @澎湃新闻 @现代快报 @中国青年报 @北朝论坛 @经略幽燕我童贯 @党人碑 @-逆光飞行- @观察者网  以及所有公开、私信支持过我的人们！" imageUrl:@"https://wx3.sinaimg.cn/mw690/6232a59agy1fplossl070j20go0cmdgp.jpg"],
                         [WeiboModel initWithParams:@"https://tva4.sinaimg.cn/crop.0.0.498.498.180/006zZHjLjw8f81ao3rzx6j30du0dut9a.jpg" name:@"爱情那点小事" title:@"好的事情总会来，你要等" content:@"张艺兴以往都是干净利落的出现在众人面前的，这次却颠覆了以往的帅气形象。头发一缕一缕的随意的在头前，感觉像是倒了两斤发胶，而且张艺兴虽然带着口罩，依然能够看出来神情非常的疲惫" imageUrl:@"https://wx4.sinaimg.cn/large/006zZHjLgy1fpnn03aak6j30jg0b7q3d.jpg"],
                         [WeiboModel initWithParams:@"https://tvax2.sinaimg.cn/crop.0.3.1242.1242.180/006Mjqfkly8fk6gd6vgusj30yi0yomzf.jpg" name:@"一句话触碰心灵" title:@"知名情感博主" content:@"这不几天前的一条微博让这些吃惯群众纷纷祝贺，网友们纷纷猜测是不是颖宝宝要正式公布爱情了啊？在之前网友们都有发现颖宝恋爱的依据。尤其是在《楚乔传》期间赵丽颖跟林更新两人多次撒糖，加之大结局意犹未尽，不禁让人多想。更是有网友放上两人甜蜜照，难道真是这样。​​​​" imageUrl:@"https://wx4.sinaimg.cn/crop.0.0.597.335.1000/006Mjqfkly1fphabu85apj30gl09c74o.jpg"],
                         [WeiboModel initWithParams:@"https://tvax1.sinaimg.cn/crop.91.0.248.248.180/006VkRyEly8fiovxohk27g30b406wnpd.gif" name:@"情侣小事" title:@"知名情感博主" content:@"以前，谢娜叫他杰哥，2018年2月1号以后，谢娜叫他杰爸，两个双胞胎女儿的到来，也成全了张杰、谢娜，让二人的人生得以圆满，娱乐圈少了一段美好的CP，多了一个幸福的四口之家。从此，张杰不再为了能够跟谢娜在一起而努力，而是为了妻女而奋斗" imageUrl:@"https://wx2.sinaimg.cn/large/0072fnqPly4fpb5ilgsu9j30hs0a03yr.jpg"],
                         [WeiboModel initWithParams:@"https://tvax1.sinaimg.cn/crop.0.1.750.750.180/006b09Gmly8fgy1w1wduoj30ku0kwmz4.jpg" name:@"DragonKnight_G字反黑组" title:@"饮冰十年，热血难凉。护龙之姿，日久绵长" content:@"爱豆马上入伍，GD饭最近都在倒数着日子佛系追星，从昨晚开始，IU李知恩超级话题大主持人，47万关注大粉【拉黑举报主页：O姨惑】却带头连发十几条带GD大名的微博污染GD广场，刷GD黑话题上榜，扬言改id为诅咒GD的名字日常谩骂，带领小粉丝们" imageUrl:@"https://wx4.sinaimg.cn/wap720/006b09Gmgy1fpnywgriasj31120ku41z.jpg"],
                         [WeiboModel initWithParams:@"https://tvax1.sinaimg.cn/crop.355.25.522.522.180/6a89551bly8fmv157njkwj20q40fdn0l.jpg" name:@"卷卷Jocelyn" title:@"知名娱乐博主" content:@"我发表了头条文章:《爆红不到三年，为何王凯拿下改革开放献礼主流正剧？》" imageUrl:@"https://wx4.sinaimg.cn/wap720/6a89551bgy1fppxkzfyqhj21120kuq5a.jpg"],
                         [WeiboModel initWithParams:@"https://tvax3.sinaimg.cn/crop.0.0.996.996.180/8a2a1923ly8fpgtezlbx5j20ro0rodju.jpg" name:@"有一丢丢白" title:@"教育博主" content:@"这几天,中美贸易战话题刷爆朋友圈。中美贸易战似乎一触即发,全球市场人心惶惶,不少国家的股市已进入暴跌状态。 然而民众对于“中美贸易战”似乎还没有清醒的认识,有的高喊要全面开战,打经济战,打政治战,有的希望中国政府隐忍不发,顺应美国,避免遭遇更大的损失。这场贸易战的真相是怎样?中国会怎么应对?关于中美贸易战,这8项事实应该弄明白" imageUrl:@"https://wx2.sinaimg.cn/large/8a2a1923ly1fpr68lldwoj20dw07twei.jpg"],
                         
                         ];
    }
    return _weiboModels;
}

//----------  end ----------

@end
