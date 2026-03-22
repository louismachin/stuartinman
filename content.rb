Content = Struct.new(
    :title,
    :section,
    :medium,
    :dimensions,
    :year,
    :description,
    :published,
    :featured,
    :filename,
    :uploaded_at,
    :uri,
)

def load_content(section)
    result = []
    Dir["./public/uploads/#{section}/*.json"].each do |path|
        file = File.open(path)
        data = JSON.load(file)
        file.close
        result << Content.new(
            data.dig('title'),
            data.dig('section'),
            data.dig('medium'),
            data.dig('dimensions'),
            data.dig('year'),
            data.dig('description'),
            data.dig('published'),
            data.dig('featured'),
            data.dig('filename'),
            data.dig('uploaded_at'),
            "/uploads/#{section}/#{data.dig('filename')}",
        )
    end
    return result
end

helpers do
    def paintings
        load_content('paintings')
    end

    def drawings
        load_content('drawings')
    end

    def photographs
        load_content('photographs')
    end

    def archive
        load_content('archive')
    end
end