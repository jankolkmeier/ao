choreProps = {
    'occurence': [
        'random'
        'fixed'
        'once'
    ]
    'impact': [
        'individual'
        'group'
    ]
}

h2 "Edit/Add Chore"

form method:'post', action:"/chores/save", id:'choreForm', ->
    b "Name"
    input type:'text', class:'editchore name', name:'name',
        placeholder:'Chore Name', value:"#{@chore?.name or ''}"
    b "Description"
    input type:'text', class:'editchore desc', name:'desc',
        placeholder:'Description', value:"#{@chore?.desc or ''}"
    for prop,opts of choreProps
        b "Chore #{prop}: "
        checkedThis = false
        for opt in opts
            if (not @chore and not checkedThis) or @chore?[prop] == opt
                checkedThis = true
                input type:'radio', class:"editchore #{prop}", name:"#{prop}",
                    value:"#{opt}", checked:'yes'
            else
                input type:'radio', class:"editchore #{prop}", name:"#{prop}",
                    value:"#{opt}", unecked:'yes'
            span "#{opt}"
        br ""
    for impact,types of @scenario.scenes
        for type,scenes of types
            div class:"#{impact} #{type} scene", ->
                b "#{type}: "
                select name:"#{impact}_#{type}", class:"sceneselect #{type}", ->
                    for name,scene of scenes
                        if name == @chore?[type]
                            option value:"#{name}", checked:'yes', -> "#{scene.desc}"
                        else
                            option value:"#{name}", -> "#{scene.desc}"
                for name,scene of scenes
                    div class:"#{type} #{name} params", ->
                        for id,param of scene.params
                            b "#{param.desc}: "
                            select name:"#{type}_#{name}_#{id}", class:"#{name} #{id}", ->
                                for item in @scenario[param.type]
                                    checked = false
                                    if @chore
                                        for p in @chore["#{type}_params"]
                                            if p.name == name and p.value == item
                                                checked = true
                                    if checked
                                        option value:"#{item}", checked:'yes', -> "#{item}"
                                    else
                                        option value:"#{item}", -> "#{item}"

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

coffeescript ->
    $(document).ready () ->
        impact = occurence = conflict = progress = ""
        impact = $("input[name='impact']").val()
        occurence = $("input[name='occurence']").val()
        updateVals = () ->
            progress = $("select[name='"+impact+"_progress']").val()
            conflict = $("select[name='"+impact+"_conflict']").val()

        updateScenes = () ->
            updateVals()
            $(".scene").hide 0
            $("."+impact).show 10
            updateProgressParams()

        updateProgressParams = () ->
            updateVals()
            $(".params.conflict").hide 0
            $(".params.progress").hide 0
            $("."+conflict).show 10
            $("."+progress).show 10

        $("input[name='impact']").change () ->
            impact = $(this).val()
            updateScenes()

        $("input[name='occurence']").change () ->
            occurence = $(this).val()
            updateScenes()

        $("select.sceneselect").change () ->
            updateProgressParams()

        updateVals()
        updateScenes()

