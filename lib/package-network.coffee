PackageNetworkView = require './package-network-view'
{CompositeDisposable} = require 'atom'

module.exports = PackageNetwork =
  packageNetworkView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @packageNetworkView = new PackageNetworkView(state.packageNetworkViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @packageNetworkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'package-network:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @packageNetworkView.destroy()

  serialize: ->
    packageNetworkViewState: @packageNetworkView.serialize()

  toggle: ->
    console.log 'PackageNetwork was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
