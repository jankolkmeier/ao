form method:'post', action:"/chores/save", ->
    input type:'text', class:'register', id:'name', name:'name',
        placeholder:'Chore Name', value:"#{@chore?.name or ''}"
    if @chore
        input type:'hidden', name:'id', value:"#{@chore.id}"
    input type:'submit', value:'Save Chore'
if @error?.errors?.name
    div class:'error', -> "Name invalid"
if @chore
    form method:'post', action:"/chores/remove/#{@chore.id}", ->
        input type:'submit', value:'Remove Chore'
