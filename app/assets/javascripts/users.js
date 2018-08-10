$(document).on('turbolinks:load', function(){
  var users = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/profiles/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#users_search').typeahead(null, {
    source: users
  });
})

