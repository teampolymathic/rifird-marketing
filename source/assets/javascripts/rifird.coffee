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
    errBlock = $('.error-state').removeClass('error').text('')

    formData =
      u: 'a73775c281ff7645c2e1c94db'
      id: 'd6f8a4fca1'

    for input in $('form.bounds-wrapper').serializeArray()
      formData[input.name] = input.value

    $('input', @).prop('disabled', true)

    $.ajax
      type: 'POST'
      data: formData
      dataType: 'jsonp'
      crossDomain: true
      url: 'http://getrifird.us10.list-manage.com/subscribe/post-json?c=?'
      
      success: (data, text) =>
        if data.result == 'success'
          msg = 'Thanks! The Rifird Orientation email is on the way. Check your inbox!'
        else
          msg = data.msg.substring(4)
          $('input', @).prop('disabled', false)

        errBlock.addClass(data.result).text(msg)

      error: (data, text) =>
        msg = data.msg.substring(4)
        $('input', @).prop('disabled', false)
        errBlock.addClass(data.result).text(msg)

  #-----------  Error Block Removal  -----------#

  $(document).on 'click touch', ->
    $('.error-state').removeClass('error').removeClass('success').text('')

  #-----------  Backdrop Carousel  -----------#
  
  setInterval( ->
    current = $('.backdrop-block.selected')
    next = if current.next('.backdrop-block').length then current.next('.backdrop-block') else $('.backdrop-block').first()
    current.removeClass('selected')
    next.addClass('selected')
  , 7000) unless !$('.backdrop-wrapper')
