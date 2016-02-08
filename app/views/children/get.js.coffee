<% if @class == "C1" %>
	$("#C2").empty()
		<% if @form == "categories" %>
			.append("<option value> </option>")
		<% end %>
			.append("<%= escape_javascript(options_from_collection_for_select(@categories, :id, :name)) %>");
	$("#C3").empty();
	$("#C4").empty();
	$("#C5").empty();

<% end %>
<% if @class == "C2" %>
	$("#C3").empty()
		<% if @form == "categories" %>
			.append("<option value> </option>")
		<% end %>
		.append("<%= escape_javascript(options_from_collection_for_select(@categories, :id, :name)) %>");
	$("#C4").empty();
	$("#C5").empty();
<% end %>

<% if @class == "C3" %>
	$("#C4").empty()
		<% if @form == "categories" %>
			.append("<option value> </option>")
		<% end %>
			.append("<%= escape_javascript(options_from_collection_for_select(@categories, :id, :name)) %>");
	$("#C5").empty();
	<% end %>
<% if @class == "C4" %>
$("#C5")
	.empty()
	<% if @form == "categories" %>
		.append("<option value> </option>")
	<% end %>
		.append("<%= escape_javascript(options_from_collection_for_select(@categories, :id, :name)) %>");
<% end %>
