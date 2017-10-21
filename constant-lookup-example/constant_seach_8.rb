class First
  module Foo
  end
end
# 在一个类的单例类中，你不能访问类本身定义的常量
class << First
  Foo
  # constant_seach_8.rb:6:in `singleton class': uninitialized constant #<Class:First>::Foo (NameError)
        # from constant_seach_8.rb:5:in `<main>'
end
