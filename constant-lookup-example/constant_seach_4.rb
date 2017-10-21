class SuperClass
  def module
    Foo
  end
end

class Subclass < SuperClass
  module Foo
  end
end

# 父类不可以访问子类中定义的 module
Subclass.new.module
# constant_seach_4.rb:3:in `module': uninitialized constant SuperClass::Foo (NameError)
        # from constant_seach_4.rb:12:in `<main>'
