page = require('webpage').create()
_ = require 'underscore'

capture_image = (url, selector, file='target.png', callback) ->
  page.viewportSize = {
    width: 1280
    height: 10240
  }

  page.open url, (status) ->
    setTimeout( ->
      rect = page.evaluate( (selector) ->
        rect = document.querySelector(selector).getBoundingClientRect()
        return rect
      , selector)

      page.clipRect = _.pick(rect, [ 'left', 'top', 'width', 'height' ])
      page.render file
      callback null
      return
    3000)
    return
  return

url = 'http://coc.blmarket.net'
selector = '.col-lg-12'

capture_image url, selector, '/tmp/target.png', (err) ->
  console.log err
  phantom.exit()
  return
