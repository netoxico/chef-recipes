
%w{mysql-server mysql-client libmysqlclient-dev python-mysqldb}.each do |pkg|
    package pkg do
        action :install
    end
end
