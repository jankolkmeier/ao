h2 "Good Work!"

div "You did the chore <em>#{@chore.name}</em>. You earned #{@log.hedons} points for you and #{@log.collectons} points for your group."
div ->
    div -> "The points you earned will be used to <em>#{@scenario.scenes[@log.impact]['progress'][@log.scene].desc}</em>"

if @conflict
    div ->
        "You also resolved the conflict #{@conflict.scene} (#{@conflict.desc})!"
