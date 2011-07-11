form method:'post', action:"/register?redirect=#{@redirect or '/'}", ->
    input type:'text', class:'register', id:'name', name: 'name', placeholder:'Full Name'
    input type:'text', class:'register', id:'nick', name: 'nick', placeholder:'Nick'
    input type:'text', class:'register', id:'mail', name: 'mail', placeholder:'Mail'
    input type:'password', class:'register', id:'pass', name: 'pass', placeholder:'Password'
    select name:'groupid', ->
        for group in @groups
            option value:"#{group.id}", -> "#{group.name}"
    input type:'submit', value:'Register'
if @error?.errors?.nick
    div class:'error', -> "Nick not allowed"
if @error?.errors?.pass
    div class:'error', -> "Pass too short"
if @error?.errors?.mail
    div class:'error', -> "Mail invalid"
if @error?.errors?.name
    div class:'error', -> "Name invalid"
div ->
    a class:'button', href:"/login?redirect=#{@redirect or '/'}", ->
        span -> "Login"
