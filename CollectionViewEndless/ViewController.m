//
//  ViewController.m
//  CollectionViewEndless
//
//  Created by nercita on 16/4/28.
//  Copyright © 2016年 nercita. All rights reserved.
//

#import "ViewController.h"
#import "TestCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

static const NSTimeInterval changeTime = 3;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 240);
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self addTimer];
}


-(UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _flowLayout;
}


-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240) collectionViewLayout:self.flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.pagingEnabled = YES;
        collectionView.delegate  = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"testCell"];
        _collectionView = collectionView;
    }
    return _collectionView;
}


-(NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = @[@"111111",@"222222",@"333333"];
    }
    return _dataArray;
}


///  addTimer
-(void)addTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:changeTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
///  removeTimer
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 返回巨多个
-(void)nextPage{
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint currentPoint = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:currentPoint];
    NSIndexPath *nextIndex = [NSIndexPath indexPathForItem:currentIndexPath.item+1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:nextIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    self.pageControl.currentPage = nextIndex.item % self.dataArray.count;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
#pragma mark - 返回巨多个
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 100000;
}

#pragma mark - 当前index与数据源总数取余
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testCell" forIndexPath:indexPath];
    cell.testTitle = self.dataArray[indexPath.item % self.dataArray.count];
    return cell;
}

-(UIPageControl *)pageControl{
    
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 230, self.view.bounds.size.width, 10)];
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.numberOfPages = self.dataArray.count;
        pageControl.currentPage = 0;
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - 当前index与数据源总数取余
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems][0];
//    self.pageControl.currentPage = indexPath.item % self.dataArray.count;
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

#pragma mark - 不要再多个地方修改currentPage,否则会错乱
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = (int)(0.5 + self.collectionView.contentOffset.x/self.collectionView.bounds.size.width) % self.dataArray.count;
    self.pageControl.currentPage = index;
}
@end
