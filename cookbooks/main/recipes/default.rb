
execute "update-apt" do
    command "sudo apt-get update"
end

%w{ack-grep aptitude vim git-core zsh libxml2-dev libjpeg62-dev zlib1g-dev}.each do |pkg|
    package pkg do
        action :install
    end
end

if node.has_key?("system_packages")
    node[:system_packages].each do |pkg|
        package pkg do
            action :install
        end
    end
end


if node.has_key?("oh_my_zsh")

    zsh_info = node[:oh_my_zsh]

    git "/home/vagrant/.oh-my-zsh" do
        repository "https://github.com/robbyrussell/oh-my-zsh.git"
        reference "master"
        action :checkout
    end

    template "/home/vagrant/.zshrc" do
        source "zshrc.erb"
        owner "vagrant"
        mode "644"
        variables(
            :theme => zsh_info[:theme] || 'robbyrussell',
            :case_sensitive => zsh_info[:case_sensitive] || false,
            :plugins => zsh_info[:plugins] || %w(git)
            )
        action :create_if_missing
    end

    user "vagrant" do
        action :modify
        shell '/bin/zsh'
    end
end
