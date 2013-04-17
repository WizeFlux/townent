(-> $.widget "custom.cityPrompt",
      _create: ->
        self = @
        cities = @element.find("#cities-list .cities-links > a").hide()
      
        @element.find('#yes-button, #close-panel').click (event)->
          event.preventDefault()
          self.hide()

        @element.find('#no-button').click (event)->
          event.preventDefault()
          self.prompt().hide()
          self.citySelector().show()
        
        @element.find('#search-input').keyup ->
          if $(@).val().length > 2
            expr = new RegExp(".*" + $(@).val() + ".*", "i")
            self.nearbyCities().hide()
            $.each cities, ->
              if expr.test($(@).text()) then $(@).show() else $(@).hide()
                
          else
            cities.hide()
            self.nearbyCities().show()
      
      prompt: -> @element.find('#city-prompt')
      nearbyCities: -> @element.find('#nearby-cities')
      citySelector: -> @element.find('#nearby-cities, #city-selector, #cities-list')
      show: -> @element.show()
      hide: -> @element.hide()
) jQuery
