
%w{python-setuptools python-dev}.each do |pkg|
    package pkg do
        action :install
    end
end

execute "easy-install-pip" do
    command "easy_install pip"
end

execute "mkdir-pip-cache" do
    command "sudo mkdir -p /home/vagrant/.pip/cache/"
end

cookbook_file "/home/vagrant/.pip/pip.conf" do
    source "pip.conf"
    mode 0640
    owner "vagrant"
    group "vagrant"
    action :create_if_missing
end

["virtualenv", "virtualenvwrapper"].each do |pkg|

    execute "pip-install-#{pkg}" do
        command "pip install #{pkg}"
    end

end


if node.has_key?("python_global_packages")
    node[:python_global_packages].each do |pkg|
        execute "pip-global-install-#{pkg}" do
            command "pip install #{pkg}"
        end
    end
end

script "setup-virtualenv" do
    interpreter "zsh"
    user "root"
    cwd "/tmp"
    code "
    mkdir -p /home/vagrant/.virtualenvs
    export WORKON_HOME=/home/vagrant/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    "
end

cookbook_file "/home/vagrant/.virtualenvs/postactivate" do
    source "postactivate"
    mode 0640
    owner "vagrant"
    group "vagrant"
    action :create
end

execute "chown-home" do
    command "sudo chown -R vagrant /home/vagrant"
end