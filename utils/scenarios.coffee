# Scenario Loader
module.exports = (u, db) ->
    u.getQuests = () ->
        return ["Deckfight", "Sickness"]

    u.loadScenarioFile = (cb) ->
        
