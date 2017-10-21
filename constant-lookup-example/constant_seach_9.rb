class First
  module Foo
  end
end
# 一个类的单例类的祖先不包括类本身，它们从Class类开始
class << First
  puts ancestors
  #=> [#<Class:First>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject]
end
