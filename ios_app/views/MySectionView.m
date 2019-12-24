#import "MySectionView.h"

@interface MySectionView()

@property (weak, nonatomic) UIButton *btn_section;
@property (weak, nonatomic) UILabel *lbl_section;

@property (assign,nonatomic) SectionState state;
@property (nonatomic,assign) NSInteger section_index;
@property (weak,nonatomic) id<MySectionViewDelegate> delegate;

@end

@implementation MySectionView

+ (MySectionView *)sectionView{
    UIView * v = [[[NSBundle mainBundle]loadNibNamed:@"section_item" owner:nil options:nil]lastObject];
    MySectionView * sv = [[MySectionView alloc]init];
    sv.btn_section = [v viewWithTag:1];
    sv.lbl_section = [v viewWithTag:2];
    [sv.btn_section addTarget:sv action:@selector(btn_section_clicked) forControlEvents:UIControlEventTouchUpInside];
    [sv.contentView addSubview:v];
    return sv;
}

/// 当前控件fream发生改变的时候 会回调这个方法
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"**** layoutSubviews ****");
}

- (void)setBtnTxt:(NSString *)txt{
    [self.btn_section setTitle:txt forState:UIControlStateNormal];
}

- (void)setLlbTxt:(NSString *)txt{
    self.lbl_section.text = txt;
}

-(void)setSectionIndex:(NSInteger)index{
    self.section_index = index;
}

-(void)setstate:(SectionState)state{
    self.state = state;
}

-(void)setMyDelegate:(id<MySectionViewDelegate>)delegate{
    self.delegate = delegate;
}

-(void)btn_section_clicked{
    if ([self.delegate respondsToSelector:@selector(mySectionViewOnclicked:)]) {
        if (self.state == OPENED) {
            self.state = CLOSED;
        }else{
             self.state = OPENED;
        }
        [self.delegate mySectionViewOnclicked:self];
    }
}

- (SectionState)getstate{
    return self.state;
}

- (NSInteger)getSectionIndex{
    return self.section_index;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"state = %d,index = %ld", self.state,self.section_index];
}

@end
