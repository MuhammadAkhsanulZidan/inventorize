// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//import * as bootstrap from "bootstrap"

$(document).on('turbolinks:load', function() {
    $('#search-item').on('input', function() {
      var query = $(this).val();
      $.ajax({
        type: 'GET',
        url: '/search_item',
        data: { query: query },
        success: function(response) {
          // Handle the response and display the search results
          // For example, you can render the results below the text field
          // Replace 'resultsContainer' with the ID or class of the container where you want to display the results
          $('#resultsContainer').empty(); // Clear previous results
          $.each(response, function(index, item) {
            $('#resultsContainer').append('<div>' + item.name + '</div>'); // Adjust 'name' to match your model attribute
          });
        }
      });
    });
  });
  