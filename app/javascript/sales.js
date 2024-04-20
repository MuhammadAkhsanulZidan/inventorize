$(document).ready(function() {
    
  function updateAmount(){
    var itemPrice = $('#search_item').select2('data')[0].price; // Get the price from select2 data
    var itemQuantity = $('#quantity').val();
    var discountValue = $('#discount_value').val();
    var discountUnit = $('#discount_unit').val();
    var totalPrice = itemPrice*itemQuantity;
    var discountedPrice = (discountUnit == 0) ? totalPrice * (1 - discountValue / 100) : totalPrice - discountValue;
    $('#amount_value').text(Math.round(discountedPrice));
  }

  function updateTotalAmount(){
    var totalAmount = parseInt($('#sub_total_amount').text());
    var shippingCharge = parseInt($('#shipping_charge').val());
    totalAmount = Math.round(totalAmount + shippingCharge);
    $('#total_amount').val(totalAmount);
  }

  var storage = window.location.pathname.split('/')[1]; // Extracts the value of :storage from the URL

  $('#search_item').select2({
    placeholder: 'SELECT AN ITEM',
    minimumInputLength: 1, // Minimum characters before triggering a search
    ajax: {
      url: function (params) {
        return '/' + storage + '/sales/search-item'; // Construct the URL with the :storage parameter
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
              text: item.name,
              price: item.sell_price
            };
          })
        };
      }
    },
  });

  // Event listeners for changes in the select2 dropdown and discount input field
  $('#discount_value, #discount_unit, #quantity, #search_item').on('input', function() {
      updateAmount();
  });

  $('#shipping_charge').on('input', function(){
    updateTotalAmount();
  });

  $('#add-item-btn').click(function(e) {
    e.preventDefault(); // Prevent the default action of the button
    
    // Get the input values
    var itemID = $('#search_item').val();
    var itemValue = $('#search_item').select2('data')[0].text;
    var itemQuantity = $('#quantity').val();
    var discountValue = $('#discount_value').val();
    var discountUnitText = $('#discount_unit option:selected').text();
    
    var amountValue = parseInt($('#amount_value').text());

    // Create the new row with plain text cells
    var newRow = $('<tr>').addClass('data-row');
    newRow.data('item-id', itemID);
    newRow.append($('<td>').text(itemValue));
    newRow.append($('<td>').text(itemQuantity));
    newRow.append($('<td>').text(discountValue + ' ' + discountUnitText));
    newRow.append($('<td>').text(amountValue));
    newRow.append($('<td>').html('<button class="btn btn-danger delete-row">Delete</button>'));

    // Insert the new row above the current input row
    $('#input-row').before(newRow);

    // Event handler to delete the corresponding row when delete button is clicked
    newRow.find('.delete-row').click(function() {
      var subAmount = parseInt($('#sub_total_amount').text());
      removeAmount = parseInt($(this).closest('tr').find('td:eq(3)').text());
      subAmount = subAmount-removeAmount;
      $('#sub_total_amount').text(subAmount);    
      updateTotalAmount();  
      $(this).closest('tr').remove(); // Remove the closest parent row
    });

    var subAmount = parseInt($('#sub_total_amount').text());
    subAmount = subAmount+amountValue;
    $('#sub_total_amount').text(subAmount);    

    updateTotalAmount();

  });

  $('#create-sale-form').submit(function(e) {
    // Define an array to store the row data
    var itemsData = [];
    
    // Loop through each dynamically generated row
    $('.data-row').each(function() {
      var itemID = $(this).data('item-id');
      // Get the input values from the current row
      var quantityValue = $(this).find('td:eq(1)').text();
      var discountValue = $(this).find('td:eq(2)').text().split(' ')[0]; // Extract discount value from the text
      var discountUnitText = $(this).find('td:eq(2)').text().split(' ')[1]; // Extract discount unit from the text
      if(discountUnitText==="%"){
        discountUnitText = 0;
      }
      else{
        discountUnitText = 1;
      }
      var amountValue = $(this).find('td:eq(3)').text();
      
      // Create a JSON object with the row data
      var itemData = {
        item_id: itemID,
        quantity: quantityValue,
        discount_val: discountValue,
        discount_unit: discountUnitText,
        amount: amountValue
      };
      
      // Push the row data to the array
      itemsData.push(itemData);
    });
    
    // Convert the array of row data to a JSON string
    var itemsDataJSON = JSON.stringify(itemsData);
    
    // Set the JSON data as a hidden input field value
    $('<input>').attr({
      type: 'hidden',
      name: 'items_data',
      value: itemsDataJSON
    }).appendTo($(this));
  });
});
