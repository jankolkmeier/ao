div id:'top', ->
    h1 "#{@chore.name}"
    h2 "Reward: #{@scenario.scenes[@chore.impact].progress[@chore.progress].desc}"

div id:'scale', ->
    if @chore.impact == 'individual'
        div id:'pointer', style:"margin-top:#{100-@hedons}px", ->
            span "< #{@hedons}% Payoff for you"
    else
        div id:'pointer', style:"margin-top:#{100-@collectons}px", ->
            span "< #{@collectons}% Payoff for your group"


form action:"/chores/do/#{@chore.id}", method:'POST', ->
    input type:'submit', value:'I just dit it!', class:'button blue'
if @chore.impact == 'individual'
    a href:"/chores/startconflict/#{@chore.id}", class:'button red', ->
        span 'Remind someone else to do this...'
else
    a href:"/chores/startconflict/#{@chore.id}", class:'button red', ->
        span 'Tell group that this needs to be done by someone!'
