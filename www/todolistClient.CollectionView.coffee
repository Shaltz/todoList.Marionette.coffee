TodoList = new Marionette.Application

class Task extends Backbone.Model
class Tasks extends Backbone.Collection
	model: Task

class TaskView extends Marionette.ItemView
	template: Handlebars.compile $('#TaskView').html()
	events:
		'click .del' : 'deleteTask'

	deleteTask:->
		this.model.destroy()

class NoTaskView extends Marionette.ItemView
	template: Handlebars.compile $('#noTaskView').html()

class TasksView extends Marionette.CollectionView
	childView: TaskView
	emptyView: NoTaskView

class FormView extends Marionette.ItemView
	template: '#formView'
	events:
		'click button': 'createTask'
	ui:
		nom: '#taskName'

	createTask:->
		@collection.add
			nom: @ui.nom.val()
		@ui.nom.val ""


TodoList.addRegions
	form: '#form'
	liste: '#liste'

TodoList.addInitializer ->
	TodoList.Tasks = new Tasks

	TodoList.form.show new FormView
		collection: TodoList.Tasks

	TodoList.liste.show new TasksView
		collection: TodoList.Tasks

TodoList.start()
