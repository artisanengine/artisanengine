$ ->
	$( '#good .nutrition_popup' ).wrap( '<div class="nutrition_popup_wrapper" />' )
	$( '#good .nutrition_popup_wrapper' ).hide()
	$( '#good a[href="#popup"]' ).colorbox({ 
		inline: true
		href: '.nutrition_popup'
	})