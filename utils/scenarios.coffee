# Scenario Loader
module.exports = (u, db) ->
    u.getQuests = () ->
        return ["Deckfight", "Sickness"]
