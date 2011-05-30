h2 "Edit/Add Chore"

form method:'post', action:"/chores/save", ->
    input type:'text', class:'editchore, name', name:'name',
        placeholder:'Chore Name', value:"#{@chore?.name or ''}"
    for prop,opts of { 'occurence':['random','fixed','onetime'], 'impact':['individual','group'] }
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
    b "Reward: "
    select name:'progress', ->
        for name,v of @scenario.individual_progress
            if name == @chore?.progress
                option value:"#{name}", checked:'yes', -> "#{v.desc}"
            else
                option value:"#{name}", -> "#{v.desc}"
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
