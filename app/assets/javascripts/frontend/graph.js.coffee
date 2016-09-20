class window.MniGraph
  constructor: (el) ->
    @canvas = el
    @value = $(el).data('value')
    @backColor = $(el).data('back-color')
    @scaleColor = $(el).data('scale-color')

    @context = @canvas.getContext('2d')
    @width = @canvas.width
    @centerX = @canvas.width / 2
    @centerY = @canvas.height - @canvas.height*0.25

    @drawBack()
    @drawScale()


  drawBack: ->
    @context.beginPath()
    @context.arc(@centerX, @centerY, 80, 0.9*Math.PI, 0.1*Math.PI, false)
    @context.lineWidth = @width * 0.1
    @context.strokeStyle = @backColor
    @context.stroke()

  drawScale: ->
    @context.beginPath()
    endAngel = (0.9 + 1.1*@value) % 2
    @context.arc(@centerX, @centerY, 80, 0.9*Math.PI, endAngel*Math.PI, false)
    @context.lineWidth = @width * 0.14
    @context.strokeStyle = @scaleColor
    @context.stroke()

