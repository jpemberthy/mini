begin
  require 'bundler'
rescue
  require 'rubygems'
  require 'bundler'
end

require 'yaml'
require 'pp'

Bundler.require(:default)
Dotenv.load

require 'helpers'

class Mini < Sinatra::Base
  set :views, Proc.new { root }

  use Rack::MethodOverride
  use Rack::Session::Cookie, secret: (ENV['COOKIE_SECRET'] || 'secret'),
                             key: (ENV['COOKIE_KEY'] || 'mini_sample'),
                             expire_after: 7200, # 2 hours
                             path: '/'

  use Rack::Flash

  helpers ::Helpers

  get "/" do
    erb :index
  end

  post "/definitions" do
    @definitions = {}

    params["words"].split(",").each do |word|
      @definitions[word] = definition(word.strip)
    end

    erb :index
  end

end
