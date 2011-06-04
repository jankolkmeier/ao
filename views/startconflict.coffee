h2 "Start Conflict"

form method:'post', action:"/chores/startconflict", id:'conflictForm', ->
    h3 "Default conflict for chore #{@chore.name}: "
    div class:"#{@chore.impact} conflict scene", ->
        select name:"conflict", class:"sceneselect conflict", ->
            for name,scene of @scenario.scenes[@chore.impact].conflict
                if name == @chore.conflict
                    option value:"#{name}", selected:'yes', -> "#{scene.desc}"
                else
                    option value:"#{name}", -> "#{scene.desc}"
        for name,scene of @scenario.scenes[@chore.impact].conflict
            div class:"conflict #{name} parameters", ->
                for id,param of scene.parameters
                    b "#{param.desc}: "
                    select name:"conflict_#{name}_#{id}", class:"#{name} #{id}", ->
                        for item in @scenario.parameters[param.type]
                            checked = false
                            if @chore
                                for p in @chore["conflict_parameters"]
                                    if p.name == id and p.value == item
                                        checked = true
                            if checked
                                option value:"#{item}", selected:'yes', -> "#{item}"
                            else
                                option value:"#{item}", -> "#{item}"
    br ""
    b "Time (in minutes): "
    input type:'text', name:'time', value:"1"
    if @chore.impact == 'individual'
        select name:"userid", class:"userid conflict", ->
            for user in @users
                option value:"#{user.id}", -> "#{user.name}"
    input type:'hidden', name:'id', value:"#{@chore.id}"
    input type:'submit', value:'Start conflict',class:'blue'
a href:"/chores", -> "Cancel"

coffeescript ->
    $(document).ready () ->
        conflict = $("select[name='conflict']:selected").val()
        updateVals = () ->
            conflict = $("select[name='conflict']").val()

        updateProgressparameters = () ->
            updateVals()
            $(".parameters.conflict").hide 0
            $("."+conflict).show 10

        $("select.sceneselect").change () ->
            updateProgressparameters()

        updateProgressparameters()
