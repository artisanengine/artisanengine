ArtisanEngine.slideshow = () ->
	# Set overflow to hidden.
	$( '#window' ).css( 'overflow', 'hidden' )
	
	# Make the first link active.
	$( '#paging a:first' ).addClass( 'active' )

	# Get size of the image, how many images there are, then 
	# determine the size of the image reel.
	imageWidth 		 = $( "#window" ).width()
	imageSum 			 = $( "#reel img" ).size()
	imageReelWidth = imageWidth * imageSum

	# Adjust the image reel to its new size.
	$( "#reel" ).css( 'width', imageReelWidth )

	# Paging and Slider Function
	rotate = () ->
		# Get number of times to slide.
		triggerID = window.active.attr( "rel" ) - 1 

		# Determine the distance the image reel needs to slide.
		reelPosition = triggerID * imageWidth

		# Remove all active classes.
		$( "#paging a" ).removeClass( 'active' )

		# Add active class (window.active is declared in the rotateSwitch function).
		window.active.addClass( 'active' )

		# Slide slide.
		$( "#reel" ).animate( { left: -reelPosition }, 500 )

	setActive = () ->
		window.active = $( '#paging a.active' ).next()
		window.active = $( '#paging a:first' ) if window.active.length is 0 
		rotate()

	# Rotation and Timing Event.
	rotateSwitch = () ->
		window.play = setInterval( setActive, 5000 )

	# Call the rotation.
	rotateSwitch()

	# When hovering over an image:
	$( "#reel a" ).hover( 
		() -> clearInterval( window.play)
		() -> rotateSwitch()
	)

	# When hovering over a link:
	$( "#paging a" ).click( () ->
	    window.active = $( this )
    
	    clearInterval( window.play )
	    rotate()
	    rotateSwitch()
	    return false
	)