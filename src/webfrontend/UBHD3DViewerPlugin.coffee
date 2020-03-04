class UBHD3DViewerPlugin extends AssetDetail
	__easUrl: (asset) ->
		eas_url = ''
		type = ''	
		for version in asset.getSiblingsFromData()
			# Viewer anbieten, wenn
			# Version im Nexus-Format
			if version.class_extension == 'unknown.nxs' or version.class_extension == 'unknown.nxz'
				if typeof version.versions.original.url != 'undefined'
					eas_url = version.versions.original.url
					type = 'nexus'
				else
					console.log('3d format not allowed')
			else
				# Viewer anbieten, wenn
				# Version ply-Format mit Namen "preview_version" 
				if version.class_extension == 'vector3d.ply' and version.name == 'preview_version'
					if typeof version.versions.original.url != 'undefined'
						eas_url = version.versions.original.url
						type = 'ply'
					else
						console.log('3d format not allowed')
				else
					if version.name == 'gltf' and version.class_extension == 'archive.zip'
						if typeof version.versions.original.download_url != 'undefined'
							eas_url = version.versions.original.download_url
							type = 'gltf'
						else
							console.log('3d format not allowed')
					else
						if version.class_extension == 'unknown.glb' and typeof version.versions.original.url != 'undefined'
							eas_url = version.versions.original.url
							type = 'gltf'
			if eas_url == ''
				console.log('no 3d viewer format')
			else
				console.log('3d viewer format found') 
		return Array(eas_url,type)


	getButtonLocaKey: (asset) ->
		eU = this.__easUrl(asset)
		eas_url = eU[0]
		type = eU[1]
		if eas_url == ''
			return

		"ubhd.asset.detail.360degrees"

	startAutomatically: ->
		true


	createMarkup: ->
		super()
		eU = this.__easUrl(@asset)
		eas_url = eU[0]
		type = eU[1]
		if eas_url == ''
			return

		obj = CUI.dom.element("div", id: "ubhd3d")

		plugin = ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin")
		pluginStaticUrl = plugin.getBaseURL()
		if type == 'nexus' or type == 'ply'
			isNexus = 0
			if type == 'nexus'
				isNexus = 1
			iframe = CUI.dom.element("iframe", {
				id: "ubhd3diframe",
				"frameborder": "0",
				"scrolling": "no",
				"src": pluginStaticUrl+"/3dhopiframe.html?nexus="+isNexus+"&asset="+eas_url
			});
		else
			iframe = CUI.dom.element("iframe", {
				id: "threeiframe",
				"frameborder": "0",
				"scrolling": "no",
				"src": pluginStaticUrl+"/threeiframe.html?asset="+eas_url
			});
		obj.appendChild(iframe)
		CUI.dom.append(@outerDiv, obj)


ez5.session_ready =>
	AssetBrowser.plugins.registerPlugin(UBHD3DViewerPlugin)
	ez5.pluginManager.getPlugin("ubhd-3d-viewer-plugin").loadCss()
