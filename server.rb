require 'sinatra/base'
require 'yaml'

class Base < Sinatra::Base
  set :upload_dir, File.join(File.dirname(__FILE__), 'files')

  not_found do
    status 404
  end
end

class Protected < Base
  set :credentials, YAML.load_file('credentials.yml')
  set :username, credentials['username']
  set :password, credentials['password']

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == settings.username && password == settings.password
  end

  get '/' do
    'Protected ;-)'
  end

  get '/:file' do
    file = File.join(settings.upload_dir, params[:file])

    if File.exist? file
      send_file file
    else
      raise Sinatra::NotFound
    end
  end

  post '/upload' do
    File.open("#{settings.upload_dir}/#{params[:file][:filename]}", "w") do |f|
      f.write(params[:file][:tempfile].read)
    end

    status 202
  end

end

class Public < Base
  get '/' do
    '<h1>SCC file server</h1>'
  end
end
