document.addEventListener("turbolinks:load", () => {
	//  $('[data-toggle="tooltip"]').tooltip();
	//  $('[data-toggle="popover"]').popover();

// Business Forms
	$('select#select_business_type.form-control').ready(function() {
		var business_type_id = $('#select_business_type').val();
		var business_subtypes = $('#select_business_subtypes').val()
		
		// Send the request and update select dropdown
		jQuery.getJSON('/business_types/business_subtype_options',{business_type_id: business_type_id, ajax: 'true'}, function(data){
			// update Business_subtypes list
			$("#select_business_subtypes").empty();
			var row = "";
			if (data["business_subtypes"] !== null) {
				// sort business_subtypes by name
				data["business_subtypes"].sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)); 
				for (var i = 0; i < data["business_subtypes"].length; i++) {
					// mark previously selected items as 'selected'
					if (business_subtypes.includes(data["business_subtypes"][i].id.toString())) {
						row = "<option selected ";
					}
					else {
						row = "<option ";
					}
					row = row + "value=\"" + data["business_subtypes"][i].id + "\">" + data["business_subtypes"][i].name + "</option>";
					$(row).appendTo("#select_business_subtypes");
				}
			}
		});
	});

	// Filter business_subtypes by business_type selected
	$('select#select_business_type.form-control').change(function() {
		var business_type_id = $('#select_business_type').val();
		
		// Send the request and update select dropdown
		jQuery.getJSON('/business_types/business_subtype_options',{business_type_id: business_type_id, ajax: 'true'}, function(data){
			// update Business_subtypes list
			$("#select_business_subtypes").empty();
			var row = "";
			if (data["business_subtypes"] !== null) {
				// sort business_subtypes by name
				data["business_subtypes"].sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)); 
				for (var i = 0; i < data["business_subtypes"].length; i++) {
					row = "<option value=\"" + data["business_subtypes"][i].id + "\">" + data["business_subtypes"][i].name + "</option>";
					$(row).appendTo("#select_business_subtypes");
				}
			}
		});
	});
	
	$('select#select_zones.form-control').ready(function() {
		var zone_id = $('#select_zones').val();
		var business_region = $('#select_region').val()
		
		// Send the request and update select dropdown
		jQuery.getJSON('/zones/zone_region_options',{zone_id: zone_id, ajax: 'true'}, function(data){
			// update business regions list
			$("#select_region").empty();
			var row = "";
			if (data["business_regions"] !== null) {
				// sort business regions by name
				data["business_regions"].sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)); 
				for (var i = 0; i < data["business_regions"].length; i++) {
					// mark previously selected items as 'selected'
					if (business_region == null) {
							row = "<option ";
					} else { 
						if (business_region.includes(data["business_regions"][i].id.toString())) {
							row = "<option selected ";
						}
						else {
							row = "<option ";
						}
					}
					row = row + "value=\"" + data["business_regions"][i].id + "\">" + data["business_regions"][i].name + "</option>";
					$(row).appendTo("#select_region");
				}
			}
		});
	});

	// Filter business_regions by zone selected
	$('select#select_zones.form-control').change(function() {
		var zone_id = $('#select_zones').val();
		
		// Send the request and update select dropdown
		jQuery.getJSON('/zones/zone_region_options',{zone_id: zone_id, ajax: 'true'}, function(data){
			// update business regions list
			$("#select_region").empty();
			var row = "";
			if (data["business_regions"] !== null) {
				// sort business regions by name
				data["business_regions"].sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)); 
				for (var i = 0; i < data["business_regions"].length; i++) {
					row = "<option value=\"" + data["business_regions"][i].id + "\">" + data["business_regions"][i].name + "</option>";
					$(row).appendTo("#select_region");
				}
			}
		});
	});
})