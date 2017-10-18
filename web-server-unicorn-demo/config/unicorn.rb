# TODO: 启动 unicorn
# $ unicorn
# TODO: 带配置文件的方式启动
# $ unicorn -c config/unicorn.rb
# TODO: 启动生产环境
# $ unicorn -c config/unicorn.rb --env production
# TODO: 后台运行
# $ unicorn -c config/unicorn.rb --env production --daemonize
# TODO: 也可以通过 unicorn_rails 启动.
#       unicorn_rails 命令更适用于 rails 项目，unicorn 命令适用于非 rails 项目。
# $ unicorn_rails -c config/unicorn.rb

module Rails
  class <<self
    def root
      File.expand_path(__FILE__).split('/')[0..-3].join('/')
    end
  end
end

# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# https://bogomips.org/unicorn/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See https://bogomips.org/unicorn/Unicorn/Configurator.html for complete
# documentation.

# TODO: 设置 worker_processes 数量
# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 4

# TODO: 设置运行 worker processes 的用户和组
# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):
# user "unprivileged_user", "unprivileged_group"

# TODO: 设置 unicorn 工作目录，SIGUSR2 将启动一个新的 unicorn 实例在这个目录。
# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory Rails.root # available in 0.94.0+

# TODO: 监听地址，可以使是tcp地址，也可以是UNIX domain sockets
# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
# TODO: listen to port 3000 on the IPv6 loopback interface
# listen "[::1]:3000"
# TODO: listen to port 3000 on the loopback interface
# listen "127.0.0.1:3000"
# TODO: listen on the given Unix domain socket
listen "#{Rails.root}/.unicorn.sock", :backlog => 64
# TODO: listen to port 3000 on all TCP interfaces
listen 8080, :tcp_nopush => true

# TODO: 设置 worker processes 的超时时间
# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# TODO: 设置pid文件的位置
# feel free to point this anywhere accessible on the filesystem
pid "#{Rails.root}/tmp/pids/unicorn.pid"

# TODO: 设置 Logger 输出的位置
# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
# TODO: 重定向 stderr 到指定文件
stderr_path "#{Rails.root}/log/unicorn.stderr.log"
# TODO: 重定向 stdout 到指定文件
stdout_path "#{Rails.root}/log/unicorn.stdout.log"

# TODO: 在 forking worker processes 之前预加载程序
# combine Ruby 2.0.0+ with "preload_app true" for memory savings
preload_app true

# TODO: 禁止 rewindability，可以提高上传的性能，降低 io 和内存使用
rewindable_input false

# TODO: 检查客户端链接是否断开，防止断开的请求调用。
# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection false

# local variable to guard against running a hook multiple times
run_once = true

# TODO: 在 master fork work之前被调用。
before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  # Occasionally, it may be necessary to run non-idempotent code in the
  # master before forking.  Keep in mind the above disconnect! example
  # is idempotent and does not need a guard.
  if run_once
    # do_something_once_here ...
    run_once = false # prevent from firing again
  end

  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.
  #
  # # This allows a new master process to incrementally
  # # phase out the old master process with SIGTTOU to avoid a
  # # thundering herd (especially in the "preload_app false" case)
  # # when doing a transparent upgrade.  The last worker spawned
  # # will then kill off the old master process with a SIGQUIT.
  # old_pid = "#{server.config[:pid]}.oldbin"
  # if old_pid != server.pid
  #   begin
  #     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
  #     Process.kill(sig, File.read(old_pid).to_i)
  #   rescue Errno::ENOENT, Errno::ESRCH
  #   end
  # end
  #
  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  # sleep 1
end

# TODO: worker fork 之后被调用。
after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end
