//
//  ViewController.m
//  KBLineLayout
//
//  Created by kangbing on 15/11/6.
//  Copyright © 2015年 kangbing. All rights reserved.
//

#import "ViewController.h"
#import "KBFlowLayout.h"
#import "KBCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *urls;

@end

static NSString *cellID = @"collecViewLinecell";

@implementation ViewController

- (NSArray *)urls{
    
    if (_urls == nil) {
        _urls = @[@"http://e.hiphotos.baidu.com/image/pic/item/e7cd7b899e510fb34395d1c3de33c895d0430cd1.jpg",
                  @"http://china.ilife.cn/images/upload/info/beauty/other_images/8_2016216100557_1.jpg",
                  @"http://www.wanhuajing.com/pic/1603/2412/5749668/1_446_670.jpg",
                  @"http://www.zsnews.cn/data/photo/Backup/2016/04/01/tw_2016419493228438.jpg",
                  @"http://photocdn.sohu.com/20131121/Img390514614.jpg",
                  @"http://image2.tibet.cn/images2/2016/3/27/20163271459036028850_0.jpg",
                  @"http://sports.gywb.cn/image/attachement/jpg/site2/20160318/5545981594865126281.jpg"];
    }

    return _urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 创建布局
    KBFlowLayout *layout = [[KBFlowLayout alloc]init];
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[KBCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.urls.count * 20;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    KBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.url = self.urls[indexPath.item % self.urls.count];
    
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
