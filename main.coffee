phantom = require 'phantom'
_ = require 'underscore'

url = 'http://imon.navercorp.jp/chart.nhn?instancePhase=release&instanceId=talk-server&entityId=connection-paymentGatewayNotification&entityType=ClientStatistics&attributeId=failCount&type=all&zoom=48&end=201412161300'
url = 'http://imon.navercorp.jp/chart.nhn?instancePhase=release&instanceId=talk-server&entityId=tomcat-http-20088&entityType=tomcat&attributeId=currentThreadsBusy&type=all'

selector = '#new_chart_0'

capture_image = (url, selector, file='target.png', callback) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      page.set('viewportSize', {
        width: 1280
        height: 10240
      })

      page.open url, (status) ->
        setTimeout( ->
          page.evaluate( (selector) ->
            rect = document.querySelector(selector).getBoundingClientRect()
            return rect
          , (rect) ->
            console.log JSON.stringify(rect)
            page.set 'clipRect', _.pick(rect, [ 'left', 'top', 'width', 'height' ])
            page.render('target.png')
            ph.exit()
            callback null
            return
          , selector)
          return
        5000)
        return
      return
    return
  return

url = 'http://blackhand.linecorp.com/#/dashboard/db/generated-charts'
selector = '.main-view-container'

capture_image url, selector, 'target.png', ->
  console.log arguments
  return
