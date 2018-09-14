//
//  AutoHeightTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/28.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "AutoHeightTableViewController.h"
#import "WeiboModel.h"
#import "AutoHeightWeiboCell.h"

@interface AutoHeightTableViewController ()

@property (nonatomic,strong) NSArray<WeiboModel *> *weiboModels;

@end

@implementation AutoHeightTableViewController

//----------  start ----------
#pragma mark monk数据
/** 以下作为前端mock的数据，模拟从后台返回的数据结构，真实操作为触发刷新后请求后台获取 **/
- (NSArray<WeiboModel *> *)weiboModels {
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
#pragma mark 使用该控件
- (BOOL)useGYTableView {
    return YES;
}

#pragma mark 触发下拉刷新(交互或代码)
- (void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:CELL_AUTO_HEIGHT cellClass:AutoHeightWeiboCell.class sourceArray:self.weiboModels]];
        }]];
        endRefreshHandler(YES);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
}


@end
