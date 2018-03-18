//
//  ViewController.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/17.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "ViewController.h"

@interface TestTableViewCell : MJTableViewCell

@end
@implementation TestTableViewCell

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 18) + 30; //生成3-10范围的随机数
        NSMutableArray* sourceArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < count; i++) {
            [sourceArray addObject:[NSString stringWithFormat:@"数据: %lu",i]];
        }
        [self.tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:[TestTableViewCell class] sourceArray:sourceArray]];
        }]];
//        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];

//        for (NSUInteger i = 0; i < count; i++) {
//            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
//
//            [sourceData addObject:
//             [CellVo initWithParams:50 cellClass:[TestTableViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",i]]];
//        }
//        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:0 headerClass:NULL headerData:NULL]];
        
        handler(sourceArray.count > 0);
//    });
}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler lastSectionVo:(SectionVo*)lastSectionVo{
    NSLog(@"上拉加载中!");
    int64_t delay = 1.0 * NSEC_PER_SEC;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 10); //生成0-2范围的随机数
        if (count <= 0) {
            handler(NO);
            return;
        }
        NSUInteger startIndex = [lastSectionVo getRealDataCount];
        NSMutableArray* sourceArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < count; i++) {
            [sourceArray addObject:[NSString stringWithFormat:@"数据: %lu",startIndex + i]];
        }
        [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:[TestTableViewCell class] sourceArray:sourceArray]];
//        SourceVo* svo = self.tableView.getLastSource;
//        NSMutableArray<CellVo*>* sourceData = svo.data;
//        NSUInteger startIndex = [svo getRealDataCount];
//        for (NSUInteger i = 0; i < count; i++) {
//            [sourceData addObject:
//             [CellVo initWithParams:50 cellClass:[TestTableViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",startIndex + i]]];
//        }
        handler(YES);
//    });
}



@end
