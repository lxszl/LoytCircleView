//
//  TestCollectionViewCell.m
//  CollectionViewEndless
//
//  Created by nercita on 16/4/28.
//  Copyright © 2016年 nercita. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation TestCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}





-(UILabel *)label{
    
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
//        [label setText:@"sdsdsdssd"];
        [label setTextColor:[UIColor blackColor]];
        label.backgroundColor = [UIColor cyanColor];
        _label = label;
        [self.contentView addSubview:label];
    }
    return _label;
}


-(void)setTestTitle:(NSString *)testTitle{
    
    _testTitle = testTitle;
    [self.label setText:testTitle];
    [self.label sizeToFit];
}

@end
