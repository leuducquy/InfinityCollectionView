//
//  ViewController.h
//  InfinityCollectionView
//
//  Created by codelovers on 10/3/17.
//  Copyright © 2017 codelovers. All rights reserved.
//

#import <UIKit/UIKit.h>
@import InfiniteCollectionView;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCLv;

@property (weak, nonatomic) IBOutlet InfiniteCollectionView *clV;



@end

