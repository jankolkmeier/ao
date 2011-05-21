h1 -> "Database Error"
div class:'error', ->
    "#{@error.msg or 'no message'}"
if @error?.error
    div class:'trace', -> "#{@error.error}"
a href:"#{@redirect or '/'}", ->
    span -> "Try here"
