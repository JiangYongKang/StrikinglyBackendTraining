class First
  module Foo
  end
end

class Last
  module Foo
  end
  # 如果传入一个快块进入 class_eval 或 module_eval 或 instance_eval 或 define_method
  # 这不会改变常量查找的位置
  puts Foo                      #=> Last::Foo
  puts First.class_eval { Foo } #=> Last::Foo
end
