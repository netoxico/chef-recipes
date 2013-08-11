
%w{mysql-server mysql-client libmysqlclient-dev python-mysqldb}.each do |pkg|
    package pkg do
        action :install
    end
end

if node.has_key?("mysql")
   execute "Set MySql root password" do
       command "mysqladmin -u root password " + node[:mysql][:root_password]
   end
end
