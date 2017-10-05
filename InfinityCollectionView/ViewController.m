//
//  ViewController.m
//  InfinityCollectionView
//
//  Created by codelovers on 10/3/17.
//  Copyright © 2017 codelovers. All rights reserved.
//

#import "ViewController.h"
#import "TestCellCollectionViewCell.h"
@import  KTCenterFlowLayout;
@interface ViewController ()<InfiniteCollectionViewDelegate,InfiniteCollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrayItem;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) CGFloat cellSpacing;
@property  (nonatomic) CGPoint pointNow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _clV.infiniteDelegate = self;
    _clV.infiniteDataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _cellWidth = [[UIScreen mainScreen] bounds].size.width  - 60.0;
     _cellHeight = [[UIScreen mainScreen] bounds].size.width / 2 + 90;
    _heightCLv.constant = [[UIScreen mainScreen] bounds].size.width / 2 + 150;
    [_clV layoutIfNeeded];
    _cellSpacing = 10;
    
    _arrayItem = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    [_clV registerNib:[UINib nibWithNibName:@"TestCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCellCollectionViewCell"];
   
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];

    flowLayout.minimumLineSpacing = _cellSpacing;
    flowLayout.minimumInteritemSpacing = _cellSpacing;
    flowLayout.itemSize = CGSizeMake(_cellWidth, _cellHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _clV.decelerationRate = UIScrollViewDecelerationRateFast;
    _clV.collectionViewLayout = flowLayout;
    _clV.pagingEnabled = YES;
   
   
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [_clV addGestureRecognizer:pan];
    [_clV setScrollEnabled:NO];
   
 _timer =  [ NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollCv:) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer*)recognizer{
    CGPoint vel = [recognizer velocityInView:_clV];
    if (vel.x > 0)
    {
        NSArray *arrayIndexPath = [_clV indexPathsForVisibleItems];
        if(arrayIndexPath.count > 0){
          
            NSMutableArray *arrayIndex = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < arrayIndexPath.count ; i++){
                NSIndexPath *indexPath = arrayIndexPath[i];
                NSInteger row = indexPath.row;
                [arrayIndex addObject:[NSNumber numberWithInteger:row]];
                
            }
            NSArray *arrayRow = [arrayIndex mutableCopy];
            NSNumber *min=[arrayRow valueForKeyPath:@"@min.self"];
            
            [_clV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[min integerValue] inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
        }

    }
    else
    {
        NSArray *arrayIndexPath = [_clV indexPathsForVisibleItems];
        if(arrayIndexPath.count > 0){
            NSMutableArray *arrayIndex = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < arrayIndexPath.count ; i++){
                NSIndexPath *indexPath = arrayIndexPath[i];
                NSInteger row = indexPath.row;
                [arrayIndex addObject:[NSNumber numberWithInteger:row]];
                
            }
            NSArray *arrayRow = [arrayIndex mutableCopy];
            NSNumber *max=[arrayRow valueForKeyPath:@"@max.self"];
            [_clV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[max integerValue]  inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
        }

        
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    NSInteger numberOfItems = [collectionView numberOfItemsInSection:section];
    CGFloat combinedItemWidth = (numberOfItems * _cellWidth) + ((numberOfItems - 1) * _cellSpacing);
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    return UIEdgeInsetsMake(20,padding , padding, 20);
}
-(void)scrollCv:(NSTimer*)timer {

  
    NSArray *arrayIndexPath = [_clV indexPathsForVisibleItems];
    if(arrayIndexPath.count > 0){
        NSMutableArray *arrayIndex = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < arrayIndexPath.count ; i++){
            NSIndexPath *indexPath = arrayIndexPath[i];
            NSInteger row = indexPath.row;
            [arrayIndex addObject:[NSNumber numberWithInteger:row]];
            
        }
        NSArray *arrayRow = [arrayIndex mutableCopy];
        NSNumber *max=[arrayRow valueForKeyPath:@"@max.self"];
        [_clV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[max integerValue]  inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    }

    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    // [_timer fire];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView dequeueForItemAt:(NSIndexPath *)dequeueIndexPath cellForItemAt:(NSIndexPath *)usableIndexPath{
    TestCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCellCollectionViewCell" forIndexPath:usableIndexPath];
    cell.titleLabel.text = _arrayItem[usableIndexPath.row];

    
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)scrollView:(UIScrollView *)scrollView pageIndex:(NSInteger)pageIndex{
    
    NSLog(@"%d",pageIndex);
}

-(NSInteger)numberOfItems:(UICollectionView *)collectionView{
    return _arrayItem.count ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
