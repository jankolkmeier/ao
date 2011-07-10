div id:'top', ->
    h1 "#{@chore.name}"
    h2 "Reward: #{@scenario.scenes[@chore.impact].progress[@chore.progress].desc}"

div id:'scale', ->
    div id:'pointer', style:"margin-top:#{100-@collectons}px", ->
        span "< #{@collectons}% Payoff for your group"

a href:"/chores/do/#{@chore.id}", class:'button blue', ->
    span 'I just did it!'
a href:"/chores/startconflict/#{@chore.id}", class:'button red', ->
    span 'Somebody else should do it...'
