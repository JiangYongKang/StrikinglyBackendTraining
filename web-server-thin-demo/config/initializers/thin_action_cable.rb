# TODO: 这两行代码原本是用于 Action cable 的，直接从 thin 的 README.me 复制过来的。
# 但是它会报错，真奇怪。报错信息如下：
# /Users/vincent/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/actioncable-5.1.4/lib/action_cable/engine.rb:37:
# in `block (3 levels) in <class:Engine>': undefined method `use_faye=' for
# #<ActionCable::Server::Configuration:0x007f9a575370c0> (NoMethodError)
#
# Rails.application.config.action_cable.use_faye = true
# Faye::WebSocket.load_adapter 'thin'
