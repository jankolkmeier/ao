doctype 5
html ->
    head ->
        meta charset: 'utf-8'
        meta name: "viewport", content: "width=device-width, initial-scale=1, maximum-scale=1"
        title "#{@title or 'Augmented Office'}"
        link rel: 'stylesheet', href: '/style.css'
        script
            src:'http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js',
            type:'text/javascript'
    body ->
        @body
