get '/admin/upload' do
    protect!
    erb :upload
end

post '/admin/upload' do
    protect!
    title     = params[:title]
    section   = params[:section]
    medium    = params[:medium]
    dims      = params[:dimensions]
    year      = params[:year]
    desc      = params[:description]
    published = params[:published] == '1'
    featured  = params[:featured] == '1'

    files = Array(params['media'])

    uploaded = files.map do |file|
        filename, tempfile = file[:filename], file[:tempfile]

        dest = File.join('public', 'uploads', section, filename)
        FileUtils.mkdir_p(File.dirname(dest))
        FileUtils.cp(tempfile.path, dest)

        meta = {
            title:       title,
            section:     section,
            medium:      medium,
            dimensions:  dims,
            year:        year,
            description: desc,
            published:   published,
            featured:    featured,
            filename:    filename,
            uploaded_at: Time.now.iso8601
        }

        meta_path = File.join('public', 'uploads', section, "#{File.basename(filename, '.*')}.json")
        File.write(meta_path, JSON.pretty_generate(meta))

        { filename: filename, path: "/uploads/#{section}/#{filename}" }
    end

    content_type :json
    { success: true, files: uploaded }.to_json
end