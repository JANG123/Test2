//
//  RegisteredView.h
//  CaoDu
//
//  Created by jang on 16/3/21.
//  Copyright © 2016年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteredView : UIView
@property(nonatomic,strong) TextTypeView *phoneText;
@property(nonatomic,strong) TextTypeView *codeText;
@property(nonatomic,strong) TextTypeView *passWordText;
@property(nonatomic,strong) TextTypeView *confirmText;
@property(nonatomic,strong) TextTypeView *recomText;
@property(nonatomic,strong) UIButton *nextButton;
@end
