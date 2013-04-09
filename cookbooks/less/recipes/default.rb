%w{python-software-properties g++ make software-properties-common}.each do |pkg|
    package pkg do
        action :install
    end
end

execute "add-apt-repository" do
    command "sudo add-apt-repository ppa:chris-lea/node.js"
end

execute "update-apt" do
    command "sudo apt-get update"
end

%w{nodejs}.each do |pkg|
    package pkg do
        action :install
    end
end

execute "install less" do
    command "sudo npm install -g less"
end
