form method:'post', action:"/login?redirect=#{@redirect or '/'}", ->
    input type:'text', class:'login', id:'nick', name: 'nick', placeholder:'Nick'
    input type:'password', class:'login', id:'pass', name: 'pass', placeholder:'Password'
    input type:'submit', value:'Login'
    br ""
    a class:'button small', href:"/register?redirect=#{@redirect or '/'}", ->
        span -> "Register"
