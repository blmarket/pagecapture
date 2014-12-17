phantom = require 'phantom'
_ = require 'underscore'

url = 'http://imon.navercorp.jp/chart.nhn?instancePhase=release&instanceId=talk-server&entityId=connection-paymentGatewayNotification&entityType=ClientStatistics&attributeId=failCount&type=all&zoom=48&end=201412161300'
url = 'http://imon.navercorp.jp/chart.nhn?instancePhase=release&instanceId=talk-server&entityId=tomcat-http-20088&entityType=tomcat&attributeId=currentThreadsBusy&type=all'

phantom.create (ph) ->
  ph.createPage (page) ->
    page.set('viewportSize', {
      width: 1280
      height: 1024
    })

    page.open url, (status) ->
      page.evaluate ( ->
        rect = document.querySelector('#new_chart_0').getBoundingClientRect()
        return rect
      ), (rect) ->
        console.log JSON.stringify(rect)
        page.set 'clipRect', _.pick(rect, [ 'left', 'top', 'width', 'height' ])
        page.render('target.png')
        ph.exit()
        return
      return
    return
  return
