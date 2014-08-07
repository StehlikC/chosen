describe "Chosen", ->

  context = {}
  select = null
  container = null
  option = new Template('<option value="#{value}">#{text}</option>')

  fuzzy_context = {}
  fuzzy_select = null
  fuzzy_container = null
  fuzzy_option = new Template('<option value="#{value}">#{text}</option>')

  beforeEach ->
    container = new Element('div')
    select = new Element('select')

    countries.forEach (value) ->
      select.insert( option.evaluate({value: value, text: value}) )
    container.insert(select)
    context.chosen = new Chosen(select)

    fuzzy_container = new Element('div')
    fuzzy_select = new Element('select')

    countries.forEach (value) ->
      fuzzy_select.insert( fuzzy_option.evaluate({value: value, text: value}) )
    fuzzy_container.insert(fuzzy_select)
    fuzzy_context.chosen = new Chosen(fuzzy_select, { search_fuzzy:true })

  sharedBehavior(context)
  sharedFuzzyBehavior(fuzzy_context)
