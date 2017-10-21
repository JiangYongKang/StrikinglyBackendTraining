class First
  module Foo
  end
end

class Last
  module Foo
  end
  # 如果你将一个 String 传递给这些方法，那么 String 将 Module.nesting
  # 只包含类本身（for class_eval）或只包含对象（for instance_eval）的单例类。
  puts First.class_eval("Foo") #=> First::Foo
end
