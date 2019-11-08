class UBHD3DViewerPlugin extends AssetDetail
	__easUrl: (asset) ->
		eas_url = ''
		isNexus = 0
		for version in asset.values
			# Viewer anbieten, wenn
			# Version im Nexus-Format
			if version.class_extension == 'unknown.nxs' or version.class_extension == 'unknown.nxz'
				if typeof version.versions.original.url != 'undefined'
					eas_url = version.versions.original.url
					isNexus = 1
				else
					console.log('3d format not allowed')
			else
				# Viewer anbieten, wenn
				# Version ply-Format mit Namen "preview_version" 
				if version.class_extension == 'vector3d.ply' and version.name == 'preview_version'
					if typeof version.versions.original.url != 'undefined'
						eas_url = version.versions.original.url
					else
						console.log('3d format not allowed')
			if eas_url == ''
				console.log('no 3d viewer format')
		return Array(eas_url,isNexus)


	getButtonLocaKey: (asset) ->
		eU = this.__easUrl(asset)
		eas_url = eU[0]
		isNexus = eU[1]
		if eas_url == ''
			return

		"ubhd.asset.detail.360degrees"


	createMarkup: ->
		super()
		eU = this.__easUrl(@asset)
		eas_url = eU[0]
		isNexus = eU[1]
		if eas_url == ''
			return

		obj = CUI.dom.element("div", id: "ubhd3d")

		plugin = ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin")
		pluginStaticUrl = plugin.getBaseURL()
		iframe = CUI.dom.element("iframe", {
			id: "ubhd3diframe",
			"frameborder": "0",
			"scrolling": "no",
			"src": pluginStaticUrl+"/3dhopiframe.html?nexus="+isNexus+"&asset="+eas_url
		});
		obj.appendChild(iframe)
		CUI.dom.append(@outerDiv, obj)


ez5.session_ready =>
	AssetBrowser.plugins.registerPlugin(UBHD3DViewerPlugin)
	ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin").loadCss()
