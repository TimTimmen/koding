class DiscussionActivityOpinionView extends KDView

  constructor:(options, data)->

    super

    @setClass "activity-opinion-container opinion-container kdlistview-activity-opinions"

    @createSubViews data



  createSubViews:(data)->
    @opinionList = new KDListView
      type          : "comments"
      subItemClass  : DiscussionActivityOpinionListItemView
      delegate      : @
    , data

    @opinionController = new OpinionListViewController view: @opinionList

    @addSubView @opinionList
    if data.opinions
      for reply, i in data.opinions when reply? and 'object' is typeof reply
        @opinionList.addItem reply


    @addSubView header = new KDView
      cssClass : "show-more-comments in"

    if data.repliesCount > 0
      header.addSubView linkToContentDisplay = new KDCustomHTMLView
        tagName : "a"
        partial : "View all replies to this discussion ("+data.repliesCount+")"
        attributes:
          href: "#"
        click :->
          appManager.tell "Activity", "createContentDisplay", data
