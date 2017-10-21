class SuperClass
  module Foo
  end
end
class Subclass < SuperClass
  # 子类的内部类不能访问父类的 module
  class InnerClass
    Foo
    # constant_seach_10.rb:7:in `<class:InnerClass>': uninitialized constant Subclass::InnerClass::Foo (NameError)
    # Did you mean?  Subclass::Foo
        # from constant_seach_10.rb:6:in `<class:Subclass>'
        # from constant_seach_10.rb:5:in `<main>'
  end
end
