

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 1. 实例变量：命名区别于全局变量和局部变量
    1.1 以下划线_作为实例变量名字的前缀，如_student
    1.2 声明位置：
        在.h头文件中
        或者，在.m实现文件的类拓展 中
    1.3 声明形式:
        头文件，写在类似@interface Person : NSObject {...}这样的花括号{...}里面
        实现文件的类拓展中，写在类似@interface Person ()<UIScrollViewDelegate> {...}这样的花括号{...}里面

    1.4 setter、getter方法
        可以自己手动为实例变量在头文件中声明setter、getter方法，并在实现文件中实现setter、getter方法。也可以不声明不实现，但不要再企图调用setter、getter方法了，甚至点语法。

 子类继承不了父类写在类拓展 中的示例变量
 
 2. 属性：自动声明实例变量和存取方法，并实现存取方法
    2.1 声明位置：
        声明头文件或者实现文件的类拓展中
    2.2 声明形式：
        写在@interface与@end之间，花括号{...}之外
        必须有@property修饰词修饰，后面可选择性地添加其他修饰词如(nonatomic, strong) 等

 2.4 存取方法：编译器会自动声明和实现
 @property会让编译器自动声明相应的实例变量和存取方法，并实现存取方法。除非你用其它关键词修饰，专门告诉编译器做什么其它特殊处理。
 即使自动生成存取方法，遇到一些需求时，你也可以再自己重写存取方法。一般添加数据模型示例对象的时候，喜欢重写getter方法，设置一些默认值，这种叫懒加载。
 有一些例外，不会自动生成存取方法：
 1、同时重写了getter setter
 2、同时重写了getter setter
 3、重写只读属性的 getter
 4、使用了@dynamic
 5、@protocol 中定义的属性
 6、category 中定义的属性
 7、重载的属性：当你在子类中重载父类的属性，你必须用 @synthesize 手动合成
 
 重写setter和getter导致的特别情况：
     @property声明的属性，编译器是否会合成存取方法和成员变量有如下三种特别情况
     若手动实现了setter方法，编译器就只会自动生成getter方法
     若手动实现了getter方法，编译器就只会自动生成setter方法
     若同时手动实现了setter和getter方法，编译器就不会自动生成不存在的成员变量 。
 
 指定所生成的方法的方法名称
 getter=你定制的getter方法名称
 setter=你定义的setter方法名称(注意setter方法必须要有 :)
    eg: @property(getter=isMarried)BOOL married;// isMarried就是getter
 
 父类声明在头文件 中的属性，子类无法继承这些属性声明的实例变量，只能看到属性自动生成的存取方法。
 
 @synthesize 与 @dynamic 告诉编译器是否或怎样自动给属性生成存取方法
 @property有两个对应的修饰词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;。 显然，这两个修饰的功能是互斥的。
 @synthesize 与 @dynamic 写在.m文件的@implementation中。
 
 block分类
 1、__NSGlobalBlock__
    存储位置：
        存储在数据区
    生命周期：
        从创建到生命周期结束
    copy操作：
        不做任何操作
    如何判断：
        没有用到外界变量
 2、__NSStackBlock__
    存储位置：
        存储在栈区
    生命周期：
        系统控制 返回就销毁
    copy操作：
        拷贝到堆中
    如何判断：
        只用到了外部的局部变量和成员属性
 3、__NSMallocBlock__
    存储位置：
        存储在堆区
    生命周期：
        有程序猿控制 没有强指针就销毁
    copy操作：
        引用计数+1
    如何判断：
        有copy修饰的成员属性 有强指针引用
 block的循环引用问题
 (1)__block
 在ARC 和 MRC都可以使用，可以修饰对象，也可以修饰基本数据类型，可以在block中重新赋值。
 (2)__weak
 弱引用，只能在ARC下使用，只能修饰对象类型，在block中 只能使用不能修改。
 (1)__strong
 强引用，防止block中的对象 由于弱引用 被释放。

 */

@interface BeanOC : NSObject
{
    // "{}"都是成员变量 成员变量用于类内部 外部不能直接访问 需要通过对外暴露的接口访问
    int _x;
}
// setter
-(void)setX:(int)x;
// getter
-(int)x;
@end

NS_ASSUME_NONNULL_END
