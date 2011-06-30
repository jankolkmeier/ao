div class:'center', ->
    form method:'post', id:'removeForm', action:"/chores/remove/#{@chore.id}", ->
        input type:'submit', class:'red', value:'Sure?'
    a href:"/chores/#{@chore.id}", -> "Cancel"
