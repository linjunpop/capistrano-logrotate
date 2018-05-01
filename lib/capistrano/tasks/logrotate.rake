namespace :load do
  task :defaults do
    set :logrotate_role, :app
    set :logrotate_conf_path, -> { File.join('/etc', 'logrotate.d', "#{fetch(:application)}_#{fetch(:stage)}") }
    set :logrotate_log_path, -> { File.join(shared_path, 'log') }
    set :logrotate_logs_keep, -> { 12 }
    set :logrotate_interval, -> { 'daily' }
    set :logrotate_user, -> { fetch(:user) }
    set :logrotate_group, -> { fetch(:user) }
    set :logrotate_template_path, -> { :default }
  end
end

namespace :logrotate do
  desc 'Setup logrotate config file'
  task :config do
    on roles(fetch(:logrotate_role)) do |role|
      upload_logrotate_template
    end
  end

  def upload_logrotate_template
    logrotate_template_path = fetch(:logrotate_template_path)
    if logrotate_template_path == :default
      logrotate_template_path = File.expand_path("../../templates/logrotate.erb", __FILE__)
    end

    if File.file?(logrotate_template_path)
      erb = File.read(logrotate_template_path)
      config_path = File.join(shared_path, 'logrotate_conf')
      upload! StringIO.new(ERB.new(erb).result(binding)), config_path
      sudo :mv, config_path, fetch(:logrotate_conf_path)
      sudo :chown, "root:root", fetch(:logrotate_conf_path)
    end
  end
end
