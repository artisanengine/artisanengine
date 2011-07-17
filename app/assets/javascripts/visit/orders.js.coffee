$ ->
	$( '#billing_address' ).hide() if $( '#shipping_is_billing' ).is( ":checked" )
	
	$( '#shipping_is_billing' ).click( () ->
		if $( this ).is( ":checked" ) then $( '#billing_address' ).hide() else $( '#billing_address' ).show()
	)