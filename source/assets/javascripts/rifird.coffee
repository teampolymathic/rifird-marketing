#= require_self

$ ->

  #-----------  Youtube JS API Setup  -----------#

  tag = document.createElement('script')
  tag.src = 'https://www.youtube.com/iframe_api'
  firstScriptTag = document.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag  

  #-----------  Open Modal / Start Video  -----------#

  $('.modal-link').on 'click touch', ->
    $('.modal-wrapper').addClass('show-modal')

    setInterval( ->
      width = $('.youtube-wrapper').outerWidth()
      height = $('.youtube-wrapper').outerHeight()

      window.player = new YT.Player 'youtube-block',
        width: width
        height: height
        videoId: 'D8oJc56ZZ5o'
        playerVars: 
          hd: 1
          fs: 1
          rel: 0
          version: 3
          autoplay: 1
          showinfo: 0
          showsearch: 0
          modestbranding: 1
          wmode: 'transparent'
    , 330) unless $('iframe').length

  #-----------  Close Modal / End Video  -----------#

  $('.modal-wrapper').on 'click touch', ->
    $(@).removeClass('show-modal')
    $(window.player).pauseVideo()

  #-----------  Submit Email to Mailchimp  -----------#

  $('form').on 'submit', (evt) ->
    evt.preventDefault()

    data = {}
    for input in $(@).serializeArray()
      data[input.name] = input.value

    request = 
      id: 'd6f8a4fca1'
      apikey: 'a53308723161bb8289f7356314c00976-us10'
      send_welcome: false
      email:
        email      : data.email
      merge_vars: 
        name       : data.name
        phone      : data.phone
        business   : data.business

    url = "https://us10.api.mailchimp.com/2.0/lists/subscribe.json?" + $.param(request)

    console.log url

    $.ajax({type: 'POST', url: url}).done (response) ->
      console.log response
