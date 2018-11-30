App.notification = App.cable.subscriptions.create('NotificationChannel',
  connected: ->
  disconnected: ->
  received: (data) ->
    if data
      $('span.noti-circle').addClass 'red-dot'
      Notification = window.Notification or window.mozNotification or window.webkitNotification
      Notification.requestPermission (permission) ->
        if permission == 'granted'
          instance = new Notification(data.username.split('@')[0] + '님이 회원님의 게시글에 댓글을 달았습니다.',
                         icon: '/assets/notification.svg',
                         body: data.title)
          setTimeout (->
            instance.close()
            return
          ), 5000
        return
    return
)