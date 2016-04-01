//
//  KBFlowLayout.m
//  KBLineLayout
//
//  Created by kangbing on 15/11/6.
//  Copyright © 2015年 kangbing. All rights reserved.
//

#import "KBFlowLayout.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@implementation KBFlowLayout



- (instancetype)init{
    
    if (self == [super init]) {
        
        self.itemSize = CGSizeMake(kScreenW - 50, kScreenH - 150);
        self.minimumLineSpacing = 20;
        self.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    }


    return self;

}

//  这个方法中放所有的item的属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    // 获取屏幕的中心的x值
    CGFloat screenCenterX = self.collectionView.contentOffset.x +  self.collectionView.frame.size.width * 0.5;
    
//    NSLog(@"%f",screenCenterX);
    
    // 获取所有cell属性值的集合
    NSArray *cellAttributes = [super layoutAttributesForElementsInRect:rect];
    
    // 创建一个可变数组
    NSMutableArray *mua = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attribute in cellAttributes) {
        
        // 屏幕中心点-cell中心点
        CGFloat offsetX = screenCenterX - attribute.center.x;
        // 往中心移动，值减小, scale变大
        CGFloat scaleF= offsetX / self.itemSize.width;
        
        // fabs 求float类型的绝对值
        CGFloat scale = 1 + 0.18 * (1- fabs(scaleF));
        attribute.transform = CGAffineTransformMakeScale(1, scale);
      
        
        [mua addObject:attribute];
    }
    

    return mua;


}

/**
 *  cell最终停留的位置
 *
 *  @param proposedContentOffset 当我们停止拖拽的时候本来要停到的位置
 *  @param velocity              拖拽的力度
 *
 *  @return 位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    //    1.获取中点的x值
    CGFloat screenCenterX = proposedContentOffset.x +  self.collectionView.bounds.size.width * 0.5;
    //    2.获取可视范围
    
//    NSLog(@"%f",proposedContentOffset.x);
//    NSLog(@"----%f",screenCenterX);
    CGRect visualRect;
    CGPoint orgion = proposedContentOffset;
    CGSize  size = self.collectionView.frame.size;
    visualRect.origin = orgion;
    visualRect.size = size;
    //    3.获取可视范围内的所有的属性
    NSArray *cellAttributes = [self layoutAttributesForElementsInRect:visualRect];
    
    //
    CGFloat minDelat = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attribute in cellAttributes) {
  
        if (fabs(attribute.center.x - screenCenterX) < minDelat) {
            
            minDelat = attribute.center.x - screenCenterX;
            
            NSLog(@"%f",minDelat);
            
            NSLog(@"差%f",attribute.center.x - screenCenterX);
        }
    }
    return CGPointMake(proposedContentOffset.x + minDelat, proposedContentOffset.y);
    
   
    


}

//当显示的界面发生变化，返回yes就会重新刷新数据，重新设置item的属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}



@end
