require 'sinatra/base'

class Base < Sinatra::Base
  not_found do
    status 404
  end
end

class Protected < Base

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'foo' && password == 'bar'
  end

  get '/' do
    'secret'
  end

  get '/:file' do
    file = File.join(File.dirname(__FILE__), 'files', params[:file])

    if File.exist? file
      send_file file
    else
      raise Sinatra::NotFound
    end
  end
end

class Public < Base
  get '/' do
    '<h1>SCC file server</h1>'
  end
end
