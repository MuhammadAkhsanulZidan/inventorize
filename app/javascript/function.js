$(document).ready(function() {
    
    function updateAmount(){
        var itemPrice = $('#search_item').select2('data')[0].price;
        var discountValue = $('#discount_value').val();
        var discountUnit = $('#discount_unit').val();
        var discountedPrice = (discountUnit == 0) ? itemPrice * (1 - discountValue / 100) : itemPrice - discountValue;
        $('#amount_value').text(discountedPrice.toFixed(2));
    }

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
        },
      });
    
      // Event listeners for changes in the select2 dropdown and discount input field
    $('#discount_value').on('input', function (e) {
        updateAmount();
    });

      $('#add-item-btn').click(function(e) {
        e.preventDefault(); // Prevent the default action of the button
        
        // Get the input values
        var itemID = $('#search_item').val();
        var itemValue = $('#search_item').select2('data')[0].text;
        var amountValue = $('#amount').val();
        var discountValue = $('#discount_value').val();
        var discountUnitText = $('#discount_unit option:selected').text();
        
        // Create the new row with plain text cells
        var newRow = $('<tr>').addClass('data-row');
        newRow.data('item-id', itemID);
        newRow.append($('<td>').text(itemValue));
        newRow.append($('<td>').text(amountValue));
        newRow.append($('<td>').text(discountValue + ' ' + discountUnitText));
        newRow.append($('<td>').html('<button class="btn btn-danger delete-row">Delete</button>'));

        // Insert the new row above the current input row
        $('#input-row').before(newRow);

        // Event handler to delete the corresponding row when delete button is clicked
        newRow.find('.delete-row').click(function() {
            $(this).closest('tr').remove(); // Remove the closest parent row
        });

      });

      $('#create-sale-form').submit(function(e) {
        // Define an array to store the row data
        var rowsData = [];
        
        // Loop through each dynamically generated row
        $('.data-row').each(function() {
          var itemID = $(this).data('item-id');
          // Get the input values from the current row
          var amountValue = $(this).find('td:eq(1)').text();
          var discountValue = $(this).find('td:eq(2)').text().split(' ')[0]; // Extract discount value from the text
          var discountUnitText = $(this).find('td:eq(2)').text().split(' ')[1]; // Extract discount unit from the text
          
          // Create a JSON object with the row data
          var rowData = {
            item_id: itemID,
            amount: amountValue,
            discount_value: discountValue,
            discount_unit: discountUnitText
          };
          
          // Push the row data to the array
          rowsData.push(rowData);
        });
        
        // Convert the array of row data to a JSON string
        var rowsDataJSON = JSON.stringify(rowsData);
        
        // Set the JSON data as a hidden input field value
        $('<input>').attr({
          type: 'hidden',
          name: 'rows_data',
          value: rowsDataJSON
        }).appendTo($(this));
      });
});
