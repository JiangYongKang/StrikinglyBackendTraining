# 通过 config.ru 配置启动，可以再终端直接输入 rackup 启动，rackup 会自动查找目录下的
# config.ru 文件，在该文件中加载需要启动的应用
require_relative "rack_basic"

run application
