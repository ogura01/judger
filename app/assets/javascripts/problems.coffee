# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	# mark = require('marked')
	marked.setOptions({
		renderer: new marked.Renderer(),
		gfm: true,
		tables: true,
		breaks: true,
		pedantic: false,
		sanitize: true,
		smartLists: true,
		smartypants: false
	})

	body_element = $('#problem_body_viewer')

	if body_element.length != 0
		text = body_element.text()
		html = marked(text)
		body_element.html(html)
