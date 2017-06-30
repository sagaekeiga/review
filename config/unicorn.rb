worker_processes 2
working_directory "/home/anime/review/current" #appと同じ階層を指定

timeout 3600


listen "/var/run/unicorn/review.sock"
pid "/var/run/unicorn/review.pid"


stderr_path "/home/anime/review/current/log/unicorn.log"
stdout_path "/home/anime/review/current/log/unicorn.log"


preload_app true