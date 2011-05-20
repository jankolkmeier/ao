h1 -> "Error"
p -> "#{@error}"
a href:"#{@redirect or '/'}", ->
    span -> "Back"
