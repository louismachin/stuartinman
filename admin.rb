$sessions = []

helpers do
    def env
        path = './environment.json'
        return {} unless File.file?(path)
        file = File.open(path)
        data = JSON.load(file)
        file.close
        return data
    end

    def password?(attempt)
        return env.dig('passwords').include?(attempt)
    end

    def session?
        token = request.cookies['_stuartinman']
        $sessions.include?(token)
    end

    def new_session
        token = Array.new(12) { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
        $sessions = $sessions + [token]
        return token
    end

    def delete_session
        token = request.cookies['_stuartinman']
        return unless token
        $sessions = $sessions - [token]
    end

    def protect!
        redirect '/admin/login' unless session?
    end
end

get '/admin' do
    protect!
    redirect '/admin/upload'
end

get '/admin/login' do
    redirect '/admin' if session?
    erb :login
end

get '/admin/logout' do
    delete_session
    redirect '/'
end

post '/admin/login' do
    data = JSON.parse(request.body.read)
    password = data.dig('password')
    if password?(password)
        response.set_cookie('_stuartinman', value: new_session, path: '/', max_age: '3600')
        status 200
        content_type :json
        { success: true }.to_json
    else
        status 401
        content_type :json
        { success: false }.to_json
    end
end