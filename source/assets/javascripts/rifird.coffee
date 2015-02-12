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

  $('form.bounds-wrapper').on 'submit', (event) ->
    event.preventDefault()

    $('input[type="submit"]').prop('disabled', true)

    formData =
      u  : 'a73775c281ff7645c2e1c94db'
      id : 'd6f8a4fca1'

    $.ajax
      type: 'POST'
      data: formData
      dataType: 'json'
      crossDomain: true
      contentType: 'application/json'
      url: 'http://getrifird.us10.list-manage.com/subscribe/post'
      
      success: (data) ->
        console.log 'good', data
      
      error: (data) ->
        console.log 'bad', data
