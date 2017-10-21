module First
  module Foo
  end
  module Bar
    module Inner
      # 会先寻找 First::Bar::Inner::Foo (不存在)
      # 再寻找 First::Bar::Inner (仍然不存在)
      # 最后寻找 First::Foo (存在)
      # Module.nesting 当前代码所在的路径
      puts Foo, Module.nesting
      #=> First::Foo [First::Bar::Inner, First::Bar, First]
    end
  end
end
