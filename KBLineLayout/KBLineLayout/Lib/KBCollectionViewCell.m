//
//  KBCollectionViewCell.m
//  KBLineLayout
//
//  Created by kangbing on 15/11/6.
//  Copyright © 2015年 kangbing. All rights reserved.
//

#import "KBCollectionViewCell.h"
#import "YYWebImage.h"

@interface KBCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation KBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    
    if (self == [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
      
        _imageView.layer.cornerRadius = 20;
        _imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imageView];
    }

    return self;


}

- (void)setUrl:(NSURL *)url{
    
    
    [self.imageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur | YYWebImageOptionProgressive];
    
}



@end
