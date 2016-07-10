role :app, %w{deployer@82.196.9.190}
role :web, %w{deployer@82.196.9.190}
role :db,  %w{deployer@82.196.9.190}

set :rails_env, :production
set :rbenv_ruby, '2.3.0'
set :stage, :production

server '82.196.9.190', user: 'deployer', roles: %w(web app db), primary: true

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------

set :ssh_options, {
 keys: %w(/Users/nick/.ssh/digital-ocean-nmiloserdov),
 forward_agent: true,
 auth_methods: %w(publickey password)
}
