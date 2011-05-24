h2 "Edit/Add Chore"

form method:'post', action:"/chores/save", ->
    input type:'text', class:'editchore, name', name:'name',
        placeholder:'Chore Name', value:"#{@chore?.name or ''}"
    for prop,opts of {'impact':['individual','group'], 'occurence':['random','fixed','onetime'] }
        b "Chore #{prop}: "
        for opt in opts
            if @chore and @chore[prop] == opt
                input type:'radio', class:"editchore, #{prop}", name:"#{prop}",
                    value:"#{opt}", checked:'yes'
            else
                input type:'radio', class:"editchore, #{prop}", name:"#{prop}",
                    value:"#{opt}", unecked:'yes'
            span "#{opt}"
        br ""
    b "Related Quest: "
    select name:'quest', ->
        for quest in @quests
            if quest == @chore?.quest
                option value:"#{quest}", checked:'yes', -> "#{quest}"
            else
                option value:"#{quest}", -> "#{quest}"
    br ""
    if @chore
        input type:'hidden', name:'id', value:"#{@chore.id}"
    input type:'submit', value:'Save Chore',class:'blue'
if @error?.errors?.name
    div class:'error', -> "Name invalid"
if @chore
    form method:'post', action:"/chores/remove/#{@chore.id}", ->
        input type:'submit', class:'red', value:'Remove Chore'
    a href:"/chore/#{@chore.id}", -> "Cancel"
else
    a href:"/chores", -> "Cancel"
