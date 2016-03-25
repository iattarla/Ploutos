<% @categories.each_with_index do |category, index| %>

    $("#C".concat("<%= (index+1).to_s %>")).val("<%= category.to_s %>");
    $("#C".concat("<%= (index+1).to_s %>")).trigger("click");
<% end %>
