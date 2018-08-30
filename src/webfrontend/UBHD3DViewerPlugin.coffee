class UBHD3DViewerPlugin extends AssetDetail
	getButtonLocaKey: (asset) ->
		console.debug "class extension", asset.value.class_extension
		if asset.value.class_extension != "vector3d.ply"
			return

		huge = asset.value.versions.huge
		console.log(asset.value.versions)

		if huge?.status != "done"
			console.log('no huge')
#			return

		"ubhd.asset.detail.360degrees"


	createMarkup: ->
		# console.debug "creatingMarkup", @
		super()

		obj = CUI.dom.element("div", id: "ubhd3d")

		iframe = CUI.dom.element("iframe", {
			id: "ubhd3diframe",
			"frameborder": "0",
			"scrolling": "no",
			"src": "/api/v1/plugin/static/extension/ubhd-3d-viewer-plugin/3dhopiframe.html?asset="+@asset.value.versions.original.url
		});
		obj.appendChild(iframe)



ez5.session_ready =>
	plugin = ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin")

	AssetBrowser.plugins.registerPlugin(UBHD3DViewerPlugin)
	ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin").loadCss()
