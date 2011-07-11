doctype 5
html ->
    head ->
        meta charset: 'utf-8'
        meta name: "viewport", content: "width=device-width, initial-scale=1.0, user-saclable=1"
        title "#{@title or 'Augmented Office'}"
        link rel: 'stylesheet', href: '/style.css'
        link href:'http://fonts.googleapis.com/css?family=Geo', rel:'stylesheet', type:'text/css'
        script
            src:'http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js',
            type:'text/javascript'
    body ->
        div id:'homeWrapper', ->
            a href:"/", id:'home', class:'yellow', -> "DASHBOARD"
        div id:'wrapper', ->
            div id:'content', ->
                div id:'wrapper2', ->
                    @body
