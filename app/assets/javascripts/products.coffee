$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products/'

  showOnlyProduct = ->
    $('#form_div').removeClass 'hide'
    $('#form_div').addClass 'hide'
    $('#products').removeClass 'hide'
    $('#products').addClass 'hide'
    $('#home_page').removeClass 'hide'
    $('#home_page').addClass 'hide'
    $('#show_product_div').removeClass 'hide'
    
  showAllProducts = ->
    $('#form_div').removeClass 'hide'
    $('#form_div').addClass 'hide'
    $('#home_page').removeClass 'hide'
    $('#home_page').addClass 'hide'
    $('#show_product_div').removeClass 'hide'
    $('#show_product_div').addClass 'hide'
    $('#products').removeClass 'hide'

  showForm = ->
    $('#form_div').removeClass 'hide'
    $('#products').removeClass 'hide'
    $('#products').addClass 'hide'
    $('#home_page').removeClass 'hide'
    $('#home_page').addClass 'hide'
    $('#show_product_div').removeClass 'hide'
    $('#show_product_div').addClass 'hide'

  showHomePage = ->
    $('#form_div').removeClass 'hide'
    $('#form_div').addClass 'hide'
    $('#products').removeClass 'hide'
    $('#products').addClass 'hide'
    $('#show_product_div').removeClass 'hide'
    $('#show_product_div').addClass 'hide'
    $('#home_page').removeClass 'hide'

  clearForms = ->
    $('#product_name').val('')
    $('#product_description').val('')
    $('#product_price').val('')
    $('.product_name').html ''
    $('.product_description').html ''
    $('.product_price').html ''

  $('.shop_now_button').click (e) ->
    e.preventDefault()
    showAllProducts()


  $('.brand-logo').click (e) ->
    e.preventDefault()
    showHomePage()
    

  $('.new_product_button').click (e) ->
    e.preventDefault()
    clearForms()
    form = $('#form')
    showForm()

    

  $('#back_button').click (e) ->
    e.preventDefault()
    clearForms()
    showAllProducts()
    
  getProducts = ->
    $.ajax
      url: baseUrl
      type: 'GET'
      success: (data) ->
        for product in data.products
          $.ajax
            url: '/product_card'
            type: 'GET'
            data:
              product: product
            success: (data) ->
              $('#products').append data
            error: (data) ->
              console.log data
      error: (data) ->
        console.log data 

  $(document).on 'click', '#buy_button', (e) ->
    e.preventDefault()
    $.ajax
      url: baseUrl + this.dataset.id
      type: 'GET'
      success: (data) ->
        showOnlyProduct()
        product = data.product
        name = product.name
        description = product.description
        price = product.base_price
        showProduct = $('#show_product_div')
        $('.product_name').append(name)
        $('.product_description').append(description)
        $('.product_price').append(price)
        $('#edit_button').attr('data-id', product.id)
        $('#delete_button').attr('data-id', product.id)
      error: (data) ->
        console.log data

  $(document).on 'click', '#delete_button', (e) ->
    e.preventDefault()
    $.ajax
      url: baseUrl + this.dataset.id
      type: 'DELETE'
      success: ->
        confirm 'Are you sure?'
        $('#products').html ''      
        showAllProducts()
        getProducts()
      error: (error) ->
        console.log error
 
  $(document).on 'click', '#edit_button', (e) ->
    e.preventDefault()
    showForm()
    $.ajax
      url: baseUrl + this.dataset.id,
      type: 'GET'
      success: (data) ->
        product = data.product
        form = $('#form')
        form.find('#product_name').val(product.name)
        form.find('#product_description').val(product.description)
        form.find('#product_price').val(product.base_price)
      error: (data) ->
        console.log data 

  $('#form').on 'submit', (e) ->
    e.preventDefault()
    $.ajax
      url: baseUrl
      type: 'POST'
      data: $(this).serializeArray()
      success: (data) ->
        clearForms()
        $('#products').html ''
        showAllProducts()
        getProducts()
      error: (data) ->
        console.log data
    
  getProducts()

