class Notifications
    constructor: ->
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length > 0

    setup: ->
        console.log(@notifications)
        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )

jQuery ->
    new Notifications
