module Foo
  module Inner
  end
end

# 跳过的命名空间的常量不可用。这是因为外部命名空间未添加到 Module.nesting。
module Foo::Join
  Inner
  # constant_seach_2.rb:7:in `<module:C>': uninitialized constant A::C::B (NameError)
  # Did you mean?  A::B
        # from constant_seach_2.rb:6:in `<main>'
end
