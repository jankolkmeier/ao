h2 "Edit/Add Group"

form method:'post', action:"/groups/save", ->
    input type:'text', class:'editgroup, name', name:'name',
        placeholder:'Group Name', value:"#{@group?.name or ''}"
    input type:'submit', value:'Save Group',class:'blue'
if @error?.errors?.name
    div class:'error', -> "Name invalid"
if @group
    form method:'post', action:"/groups/remove/#{@group.id}", ->
        input type:'submit', class:'red', value:'Remove Group'
    a href:"/group/#{@group.id}", -> "Cancel"
else
    a href:"/groups", -> "Cancel"
