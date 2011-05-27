# Scenario Loader
module.exports = (u, db) ->
    u.getQuests = () ->
        return ["Deckfight", "Sickness"]

    u.getScenarioVersion = () ->
        return 1306435020
