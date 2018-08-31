class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup()



  setup: ->
   console.log $("[data-behavior='notifications']")



  jQuery ->
    new Notifications




