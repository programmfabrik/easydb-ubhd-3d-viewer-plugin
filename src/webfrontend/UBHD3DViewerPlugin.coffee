class UBHD3DViewerPlugin extends AssetDetail
	getButtonLocaKey: (asset) ->
		console.debug "class extension", asset.value.class_extension
		if asset.value.class_extension != "vector3d.ply" and asset.value.class_extension != "unknown.nxz"
			return

		huge = asset.value.versions.huge
		console.log(asset.value.versions)

		if huge?.status != "done"
			console.log('no huge')
#			TODO: use huge.url instead of original.url
#			return

		"ubhd.asset.detail.360degrees"


	createMarkup: ->
		# console.debug "creatingMarkup", @
		super()

		obj = CUI.dom.element("div", id: "ubhd3d")

		plugin = ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin")
		pluginStaticUrl = plugin.getBaseURL()
		iframe = CUI.dom.element("iframe", {
			id: "ubhd3diframe",
			"frameborder": "0",
			"scrolling": "no",
			"src": pluginStaticUrl+"/3dhopiframe.html?asset="+@asset.value.versions.original.url
		});
		obj.appendChild(iframe)
		CUI.dom.append(@outerDiv, obj)


ez5.session_ready =>
	AssetBrowser.plugins.registerPlugin(UBHD3DViewerPlugin)
	ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin").loadCss()
