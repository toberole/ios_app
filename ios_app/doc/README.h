// 解析json
/*
 
 NSJSONReadingMutableContainers：
    返回可变容器，NSMutableDictionary或NSMutableArray。
 
 NSJSONReadingMutableLeaves：
    返回的JSON对象中字符串的值为NSMutableString
 
 NSJSONReadingAllowFragments：
    允许JSON字符串最外层既不是NSArray也不是NSDictionary，
 但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
 
 
 //判断类中是否包含某个方法的实现
 BOOL class_respondsToSelector(Class cls, SEL sel)
 //获取类中的方法列表
 Method *class_copyMethodList(Class cls, unsigned int *outCount)
 //为类添加新的方法,如果方法该方法已存在则返回NO
 BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
 //替换类中已有方法的实现,如果该方法不存在添加该方法
 IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types)
 //获取类中的某个实例方法(减号方法)
 Method class_getInstanceMethod(Class cls, SEL name)
 //获取类中的某个类方法(加号方法)
 Method class_getClassMethod(Class cls, SEL name)
 //获取类中的方法实现
 IMP class_getMethodImplementation(Class cls, SEL name)
 //获取类中的方法的实现,该方法的返回值类型为struct
 IMP class_getMethodImplementation_stret(Class cls, SEL name)
 
 //获取Method中的SEL
 SEL method_getName(Method m)
 //获取Method中的IMP
 IMP method_getImplementation(Method m)
 //获取方法的Type字符串(包含参数类型和返回值类型)
 const char *method_getTypeEncoding(Method m)
 //获取参数个数
 unsigned int method_getNumberOfArguments(Method m)
 //获取返回值类型字符串
 char *method_copyReturnType(Method m)
 //获取方法中第n个参数的Type
 char *method_copyArgumentType(Method m, unsigned int index)
 //获取Method的描述
 struct objc_method_description *method_getDescription(Method m)
 //设置Method的IMP
 IMP method_setImplementation(Method m, IMP imp)
 //替换Method
 void method_exchangeImplementations(Method m1, Method m2)
 
 //获取SEL的名称
 const char *sel_getName(SEL sel)
 //注册一个SEL
 SEL sel_registerName(const char *str)
 //判断两个SEL对象是否相同
 BOOL sel_isEqual(SEL lhs, SEL rhs)
 
 //通过块创建函数指针,block的形式为^ReturnType(id self,参数,...)
 IMP imp_implementationWithBlock(id block)
 //获取IMP中的block
 id imp_getBlock(IMP anImp)
 //移出IMP中的block
 BOOL imp_removeBlock(IMP anImp)
 
 //调用target对象的sel方法
 id objc_msgSend(id target, SEL sel, 参数列表...)
 
 */
