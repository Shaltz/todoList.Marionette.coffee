monApp = new Marionette.Application

class Tache extends Backbone.Model
class Taches extends Backbone.Collection
	model: Tache

class VueTache extends Marionette.ItemView
	template: Handlebars.compile $('#tache').html()

	events:
		'click button' : 'supprimer'

	supprimer:->
		@model.destroy()

class VueGenerale extends Marionette.CompositeView
	template: Handlebars.compile $('#formulaire').html()
	childView: VueTache
	childViewContainer: '#liste'

	events:
		'click button': 'ajouter'

	ajouter:->
		@collection.add
			nom: @$('#defTache').val()
		@$('#defTache').val ''





monApp.addRegions
	content: '#reserve'

monApp.addInitializer ->
	monApp.taches = new Taches()

	monApp.content.show new VueGenerale
		collection: monApp.taches

monApp.start()
