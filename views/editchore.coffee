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
    div "Name: "
    input type:'text', class:'editchore name', name:'name',
        placeholder:'Chore Name', value:"#{@chore?.name or ''}"
    div "Extra information: "
    input type:'text', class:'editchore desc', name:'desc',
        placeholder:'Description', value:"#{@chore?.desc or ''}"
    for prop,opts of choreProps
        div "Chore #{prop}: "
        checkedThis = false
        for opt in opts
            if opt == 'fixed' or opt == 'once'
                input type:'radio', class:"editchore #{prop}", name:"#{prop}",
                    value:"#{opt}", disabled:'yes', unchecked:'yes'
                span class:"grey", -> "#{opt}"
            else
                if (not @chore and not checkedThis) or @chore?[prop] == opt
                    checkedThis = true
                    input type:'radio', class:"editchore #{prop}", name:"#{prop}",
                        value:"#{opt}", checked:'yes'
                else
                    input type:'radio', class:"editchore #{prop}", name:"#{prop}",
                        value:"#{opt}", unchecked:'yes'
                span "#{opt}"
        br ""
    for impact,types of @scenario.scenes
        for type,scenes of types
            div class:"#{impact} #{type} scene", ->
                div "#{type}: "
                select name:"#{impact}_#{type}", class:"sceneselect #{type}", ->
                    for name,scene of scenes
                        if name == @chore?[type]
                            option value:"#{name}", selected:'yes', -> "#{scene.desc}"
                        else
                            option value:"#{name}", -> "#{scene.desc}"
                for name,scene of scenes
                    div class:"#{type} #{name} parameters", ->
                        for id,param of scene.parameters
                            div "#{param.desc}: "
                            select name:"#{type}_#{name}_#{id}", class:"#{name} #{id}", ->
                                for item in @scenario.parameters[param.type]
                                    checked = false
                                    if @chore
                                        for p in @chore["#{type}_parameters"]
                                            if p.name == id and p.value == item
                                                checked = true
                                    if checked
                                        option value:"#{item}", selected:'yes', -> "#{item}"
                                    else
                                        option value:"#{item}", -> "#{item}"

    br ""
    if @chore
        input type:'hidden', name:'id', value:"#{@chore.id}"
    div class:'center', ->
        input type:'submit', value:'Save', class:"button"
        if @chore
            a href:"/chores/remove/#{@chore.id}", class:"button", -> "Delete"
            a href:"/chore/#{@chore.id}", class:"button", -> "Cancel"
        else
            a href:"/chores", -> "Cancel"#

coffeescript ->
    $(document).ready () ->
        impact = $("input[name='impact']:checked").val()
        occurence = $("input[name='occurence']:checked").val()
        conflict = ""
        progress = ""
        updateVals = () ->
            progress = $("select[name='"+impact+"_progress']").val()
            conflict = $("select[name='"+impact+"_conflict']").val()

        updateScenes = () ->
            updateVals()
            $(".scene").hide 0
            $("."+impact).show 10
            updateProgressparameters()

        updateProgressparameters = () ->
            updateVals()
            $(".parameters.conflict").hide 0
            $(".parameters.progress").hide 0
            $("."+conflict).show 10
            $("."+progress).show 10

        $("input[name='impact']").change () ->
            impact = $(this).val()
            updateScenes()

        $("input[name='occurence']").change () ->
            occurence = $(this).val()
            updateScenes()

        $("select.sceneselect").change () ->
            updateProgressparameters()

        updateVals()
        updateScenes()

