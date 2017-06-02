//
//  NewsController.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 07.02.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsCoordinatorDelegate;
@class NewsDataSourceAndDelegate;

@interface NewsController : BaseViewController

@property (strong,nonatomic) NewsDataSourceAndDelegate* delegateDataSource;
@property (weak,nonatomic) id <NewsCoordinatorDelegate> delegate;

-(void)reloadTableView;
-(void)failedToGetData;

@end
