div id:'top', ->
    h1 "#{@chore.name}"
    h2 "Reward: #{@scenario.scenes[@chore.impact].progress[@chore.progress].desc}"

div id:'scale', ->
    div id:'pointer', style:"margin-top:#{100-@collectons}px", ->
        span "< #{@collectons}% Payoff for your group"

form action:"/chores/do/#{@chore.id}", method:'POST', ->
    input type:'submit', value:'I just did it!', class:'button blue'

a href:"/chores/startconflict/#{@chore.id}", class:'button red', ->
    span 'Somebody else should do it...'
