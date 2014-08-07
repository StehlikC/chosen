describe "Chosen", ->

  context = {}
  chosen = null
  select = null
  container = null

  fuzzy_context = {}
  fuzzy_chosen = null
  fuzzy_select = null
  fuzzy_container = null

  beforeEach ->
    container = $('<div/>')
    select = $('<select/>')
    countries.forEach (value) ->
      select.append($('<option/>').val(value).text(value))
    container.append(select)
    context.chosen = chosen = select.chosen().data('chosen')

    fuzzy_container = $('<div/>')
    fuzzy_select = $('<select/>')
    countries.forEach (value) ->
      fuzzy_select.append($('<option/>').val(value).text(value))
    fuzzy_container.append(fuzzy_select)
    fuzzy_context.chosen = fuzzy_chosen = fuzzy_select.chosen({ search_fuzzy:true }).data('chosen')

  sharedBehavior(context)
  sharedFuzzyBehavior(fuzzy_context)
