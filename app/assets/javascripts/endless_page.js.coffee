(-> $.widget "custom.endlessPage",
      options:
        query: ''
        request_path: '/'
      _create: ->
        self = this
        page = 1
        loading = false
        spinner = @element.find('#spinner')
        

        $(window).scroll ->
          return if loading
          if self.nearBottomOfPage() and self.pageNotLast()
            loading = true
            spinner.show()
            page++
            $.ajax
              url: self.options.request_path + "?page=" + page + "&previous_event_date=" + self.previousEventDate() + "&" + self.options.query
              type: "get"
              cache: true
              dataType: "script"
              success: ->
                loading = false
                spinner.hide()
                
      nearBottomOfPage: -> $(window).scrollTop() > $(document).height() - $(window).height() - 200
      pageNotLast: -> !@element.find('#last-page').size()
      previousEventDate: -> @element.find('#container .date').last().attr('data-date')
) jQuery
