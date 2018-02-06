//
//  WalletHistoryEntity+Extension.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 01.02.2018.
//  Copyright © 2018 QTUM. All rights reserved.
//

#import "WalletHistoryEntity+CoreDataClass.h"

@interface WalletHistoryEntity (Extension) <HistoryElementProtocol>

@property (strong, nonatomic) QTUMBigNumber *amount;

@end
