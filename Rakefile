task :run do
    require 'sinatra'

    APP_ROOT = File.expand_path(__dir__)

    configure do
        # sinatra
        set :bind, '0.0.0.0'
        set :port, '4534'
        set :public_folder, File.join(APP_ROOT, 'public')
        set :views, File.join(APP_ROOT, 'views')
        set :environment, :production
        disable :protection
    end

    get '/' do
        erb :index
    end

    Sinatra::Application.run!
end