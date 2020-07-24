// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'core-js/stable'
import 'regenerator-runtime/runtime'

require("@rails/ujs").start()
require("turbolinks")
require("@rails/activestorage").start()
require("channels")
require('data-confirm-modal')

import 'bootstrap'
require("@fortawesome/fontawesome-free")
 
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()

	$('select#select_business_type.form-control').ready(function() {
		var business_type_id = $('#select_business_type').val();
		var business_subtypes = $('#select_business_subtypes').val()
	
		// Send the request and update select dropdown
		jQuery.getJSON('/business_types/business_subtype_options',{business_type_id: business_type_id, ajax: 'true'}, function(data){
			// update Business_subtypes list
			$("#select_business_subtypes").empty();
			var row = "";
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
			// sort business_subtypes by name
			data["business_subtypes"].sort((a,b) => (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)); 
			for (var i = 0; i < data["business_subtypes"].length; i++) {
				row = "<option value=\"" + data["business_subtypes"][i].id + "\">" + data["business_subtypes"][i].name + "</option>";
				$(row).appendTo("#select_business_subtypes");
			}
		});
	});
	
})

