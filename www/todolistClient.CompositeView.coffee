TodoList = new Marionette.Application

class Task extends Backbone.Model
class Tasks extends Backbone.Collection
	model: Task

class TaskView extends Marionette.ItemView
	className: 'view child'
	template: Handlebars.compile $('#TaskView').html()
	events:
		'click .del' : 'deleteTask'

	deleteTask:->
		this.model.destroy()

class NoTaskView extends Marionette.ItemView
	className: 'view'
	template: '#noTaskView'

class TasksView extends Marionette.CompositeView
	className: 'view composite'
	template: Handlebars.compile $('#formView').html()

	childView: TaskView
	emptyView: NoTaskView

	childViewContainer: '#list'

	ui:
		nom: '#taskName'

	events:
		'click button': 'createTask'

	createTask:->
		@collection.add
			nom: @ui.nom.val()
		@ui.nom.val ""


TodoList.addRegions
	content: '#content'

TodoList.addInitializer ->
	TodoList.Tasks = new Tasks

	TodoList.content.show new TasksView
		collection: TodoList.Tasks

TodoList.start()
