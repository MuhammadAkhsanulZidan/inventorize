$(document).ready(function() {
    var storage = window.location.pathname.split('/')[1]; // Extracts the value of :storage from the URL

    $('#search_item').select2({
        placeholder: 'SELECT AN ITEM',
        minimumInputLength: 1, // Minimum characters before triggering a search
        ajax: {
          url: function (params) {
            return '/' + storage + '/search_item'; // Construct the URL with the :storage parameter
          },
          dataType: 'json',
          delay: 250, // Delay in milliseconds before making the AJAX request
          data: function (params) {
            return {
              query: params.term // Search query entered by the user
            };
          },
          processResults: function (data) {
            return {
              results: $.map(data, function (item) {
                return {
                  id: item.id,
                  text: item.name
                };
              })
            };
          }
        }
      });

      $('#add-item-btn').click(function(e) {
        e.preventDefault(); // Prevent the default action of the button
        
        // Get the input values
        var itemID = $('#search_item').val();
        var itemValue = $('#search_item').text();
        var amountValue = $('#amount').val();
        var discountValue = $('#discount_value').val();
        var discountUnitText = $('#discount_unit option:selected').text();
        
        // Create the new row with plain text cells
        var newRow = $('<tr>').attr('id', 'data-row');
        newRow.append($('<td>').text(itemValue)).attr('data-item-id', itemID);
        newRow.append($('<td>').text(amountValue));
        newRow.append($('<td>').text(discountValue + ' ' + discountUnitText));
        newRow.append($('<td>').html('<a class="btn btn-primary">ADD SALE</a>'));
        
        // Insert the new row above the current input row
        $('#input-row').before(newRow);
      });

      // Click event handler for creating sale
  $('#create-sale-btn').click(function(e) {
    e.preventDefault(); // Prevent the default action of the button
    
    // Define an array to store the row data
    var rowsData = [];
    
    // Loop through each dynamically generated row
    $('#data-row').each(function() {
      // Get the input values from the current row
      var itemValue = $(this).find('td:eq(0)').text();
      var amountValue = $(this).find('td:eq(1)').text();
      var discountValue = $(this).find('td:eq(2)').text().split(' ')[0]; // Extract discount value from the text
      var discountUnitText = $(this).find('td:eq(2)').text().split(' ')[1]; // Extract discount unit from the text
      
      // Create a JSON object with the row data
      var rowData = {
        item_value: itemValue,
        amount: amountValue,
        discount_value: discountValue,
        discount_unit: discountUnitText
      };
      
      // Push the row data to the array
      rowsData.push(rowData);
    });
    
    // Convert the array of row data to a JSON string
    var rowsDataJSON = JSON.stringify(rowsData);
    
    // AJAX request to pass rowsDataJSON to the Rails controller
    $.ajax({
      type: 'POST',
      url: '/'+storage+'/sales/create_sale', // Adjust the URL to match your Rails route
      data: { rows_data: rowsDataJSON },
      success: function(response) {
        // Handle the success response
        console.log(response);
      },
      error: function(xhr, status, error) {
        // Handle errors
        console.error(error);
      }
    });
  });


});
