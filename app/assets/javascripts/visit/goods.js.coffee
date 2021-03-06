$ ->
	$( '#good #images a' ).colorbox({
		rel:				'gallery'
		transition: 'fade' 
		maxWidth:		'100%'
		maxHeight:	'100%'
		title:			() -> $( this ).children( 'img' ).attr( 'title' )
	})

ArtisanEngine.buildOptionSelects = (options) ->
	variants = ArtisanEngine.buildVariantsArray()
	options  = JSON.parse( options )
	
	# Build an option select for each option.
	ArtisanEngine.buildOptionSelect( option, variants ) for option in options
	
	# Apply change event to all option selects.
	$( '.variant_selector' ).change( () ->
		currentValues  = ArtisanEngine.getCurrentValues()
		currentVariant = ArtisanEngine.getCurrentVariant( variants, currentValues )
		
		if currentVariant
			$( '#price' ).html( currentVariant.price )
			$( '.main_variant_selector' ).val( currentVariant.id )
			$( 'input[type=submit]' ).removeAttr( 'disabled' )
		else
			$( '#price' ).html( 'Not available.' )
			$( 'input[type=submit]' ).attr( 'disabled', 'disabled' )
	)
	
	# Initialize original data.
	$( '#price' ).html( variants[0].price ) if variants[0]
	
	# Hide original select.
	$( '.main_variant_selector' ).hide()
	
# Build an array of Variant objects from the original select list.
ArtisanEngine.buildVariantsArray = () ->
	variants = []
	
	$( '.main_variant_selector option' ).each( () ->
		# Retrieve option values into an array and trim them of whitespace.
		option_values = $( this ).text().replace( /-{2}.+/, '' )						# Trim price.
		option_values = option_values.split( " / " )
		option_values = $.map( option_values, (value) -> $.trim( value ) )
		
		# Retrieve trimmed price.
		variant_price = $( this ).text().split( "--" )[1]
		variant_price = $.trim( variant_price )
		
		# Create the Variant object.
		variant = { "id": $( this ).val(), "option_values": option_values, "price": variant_price }

		# Add the Variant object to the array of variants.
		variants.push( variant )
	)
	
	return variants

# Build an option select from an option and variants.
ArtisanEngine.buildOptionSelect = (option, variants) ->
	name 	 = option.name
	values = []
	
	# Create an array of option values based on the option's position.
	for variant in variants
		values.push( variant.option_values[option.order_in_good - 1] )
	
	# Build a select list from the values.
	optionLabel		= "<label for='" + name.toLowerCase() + "'>" + name + "</label>"
	
	optionSelect  = "<select id='" + name.toLowerCase() + "' class='variant_selector'>"
	optionSelect += "<option>" + value + "</option>" for value in _.uniq( values )
	optionSelect += "</select>"
	
	optionDiv			= "<div class='option'>" + optionLabel + optionSelect + "</div>"
	
	# Add the select list to the DOM.
	$('#options').append( optionDiv )

# Get current values from the option selects.
ArtisanEngine.getCurrentValues = () ->
	current_values = []
	
	$( '.variant_selector' ).each( () ->
		current_values.push( $(this).val() )
	)
	
	return current_values

# Get variant based on values from option selects.
ArtisanEngine.getCurrentVariant = (variants, current_values) ->
	for variant in variants
		match = ArtisanEngine.checkVariant( variant, current_values )
		return variant unless match is false

# Check if a variant's option values match an array of option-select values.
ArtisanEngine.checkVariant = (variant, current_values) ->
	all_values_match = true
	
	index = 0
	while index < current_values.length
		all_values_match = false if variant.option_values[index] != current_values[index]
		index++
	
	return all_values_match