$ () ->

	$('ul.items li').each (index) ->
		$(@).addClass("#{index}")

	slider = $(".items")
	sliderInner = slider.html()
	pic_width = 44
	pics_count = parseInt(($(window).width()/44).toFixed())
	circleCount = parseInt((pics_count/$('ul.items li').length).toFixed())
	activePic = ((pics_count/2).toFixed()) - 1
	# console.log(pics_count, circleCount)

	for j in [0...circleCount]
		slider.append(sliderInner)

	changePicture = ->
		if window.showIndex < $('#photo-bg li').length - 1 then window.showIndex++
		else window.showIndex = 0
		$('#photo-bg li').removeClass('active').eq(window.showIndex).addClass('active')

	prepareBackground = ->
		$('#photo-bg').find('li').eq(0).addClass('active')
		window.showIndex = 0
		setInterval(changePicture, 10000)

	randomPic = ->
		count = $('ul.items li').length
		random = Math.floor(Math.random() * (count - 0 + 1))
		# console.log(random)
		curr = $('ul.items li').eq(random)
		curr.insertAfter($('ul.items li').eq(activePic - 1))
		@

	prepareBackground()
	randomPic()

	$('ul.items li').removeClass('active').eq(activePic).addClass('active')

	$(document).on 'keyup', (event) ->
		if (event.keyCode == 190 or event.keyCode == 39)
			$(".items li").eq(0).animate "margin-left": -pic_width, 300, ->
				p = $(@)	
				p.clone().appendTo(slider).css("margin-left": "0")
				p.remove()
				$('ul.items li').removeClass('active').eq(activePic).addClass('active')
		else if (event.which == 188 or event.which == 37)
			p = $(".items li").eq(-1)
			p.clone().css("margin-left": -pic_width).prependTo(slider).animate "margin-left": 0, 300, ->
				$('ul.items li').removeClass('active').eq(activePic).addClass('active')
			p.remove()
			
	@
