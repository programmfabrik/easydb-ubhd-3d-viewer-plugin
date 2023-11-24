class UBHD3DViewerPlugin extends AssetDetail
	__easUrl: (asset) ->
		#The object that will contain the 3dAsset info.
		assetInfo =
			type: null
			url: null
			extension: null
			defaults: '' 

		if not asset
			return assetInfo

		if asset instanceof Asset
			#If asset is instance of the class Asset then we can get all the data about the versions of the file
			# with getSiblingsFromData()
			versions = asset.getSiblingsFromData()
		else
			#If asset is not instance of Asset then can be data about the asset retrieved by createMarkup()
			versions = Object.values(asset)

		if not versions
			return assetInfo

		#We iterate the versions of the asset searching a valid 3dModel.
		for version in versions
			# Viewer anbieten, wenn
			# Version im Nexus-Format
			if version.class_extension == 'vector3d.nxs' or version.class_extension == 'vector3d.nxz'
				assetInfo.type = 'nexus'
				if typeof version.versions.original?.url != 'undefined'
					assetInfo.url = version.versions.original?.url
					assetInfo.extension = version.versions.original?.extension
				else
					console.log('3d format not allowed')
			else
				# Viewer anbieten, wenn
				# Version ply-Format mit Namen "preview_version" 
				if version.class_extension == 'vector3d.ply' and version.name == 'preview_version'
					assetInfo.type = 'ply'
					if typeof version.versions.original?.url != 'undefined'
						assetInfo.url = version.versions.original?.url
						assetInfo.extension = version.versions.original?.extension
					else
						console.log('3d format not allowed')
				else
					# Viewer anbieten, wenn
					# Version zip-Format mit Namen "gltf"
					if version.name == 'gltf' and version.class_extension == 'archive.zip'
						assetInfo.type = 'gltf'
						if typeof version.versions.original?.download_url != 'undefined'
							assetInfo.url = version.versions.original?.download_url
							assetInfo.extension = version.versions.original?.extension
						else
							console.log('3d format not allowed')
					else
						# Viewer anbieten, wenn
						# Version im glb-Format
						if version.class_extension == 'vector3d.glb'
							assetInfo.type = 'gltf'
							if typeof version.versions.original?.url != 'undefined'
								assetInfo.url = version.versions.original?.url
								assetInfo.extension = version.versions.original?.extension
						else
							# Viewer anbieten, wenn
							# Version zip-webdvd-Format mit Namen "rti"
							if version.name == 'rti' and version.class_extension == 'archive.webdvd.zip'
								assetInfo.type = 'rti'
								if typeof version.versions.directory?.url != 'undefined'
									assetInfo.url = version.versions.directory?.url
									assetInfo.extension = 'rti'
								else
									console.log('3d format rti: missing version directory')
			if version.original_filename == '3D_viewer.json'
				assetInfo.defaults = version.versions.original?.url
		return assetInfo


	getButtonLocaKey: (asset) ->
		assetInfo = @__easUrl(asset)
		if not assetInfo.url and not assetInfo.type
			return

		return "ubhd.asset.detail.360degrees"

	startAutomatically: ->
		true

	#Called by the asset browser to create the html of the viewer.
	createMarkup: ->
		super()
		#We get the info of the asset, url and type
		assetInfo = @__easUrl(@asset)
		if not assetInfo.url and assetInfo.type
			#If we have a type but no url we need to fetch the url from the server using the EAS api
			#this could happen when we get a asset from a linked object standard for example, in that
			#case the server will not send the versions of the asset by default, we have to get it manually.
			ez5.api.eas({
				type: "GET",
				data: {
					ids: JSON.stringify([@asset.value._id]),
					format: "long"
				}
			}).done (assetServerData) =>
				#This call is async so we have to wait the response and then with the data
				# call to __createMarkup
				if assetServerData.error
					return
				@__createMarkup(null, assetServerData)

		#If we have url we can create the html.
		if assetInfo.url
			@__createMarkup(assetInfo)

		return

	#This private method is used to be able to call async the create markup behaviour.
	__createMarkup: (assetInfo, assetServerData) ->
		#If we have serverData we get the asset info using __easUrl()
		if not assetInfo and assetServerData
			assetInfo = @__easUrl(assetServerData)
			if not assetInfo or not assetInfo.url or not assetInfo.type
				return

		viewerDiv = CUI.dom.element("div", id: "ubhd3d")
		plugin = ez5.pluginManager.getPlugin("easydb-ubhd-3d-viewer-plugin")
		pluginStaticUrl = plugin.getBaseURL()
		if assetInfo.type == 'nexus' or assetInfo.type == 'ply'
			# 3DHOP-Viewer
			isNexus = 0
			if assetInfo.type == 'nexus'
				isNexus = 1
			iframe = CUI.dom.element("iframe", {
				id: "ubhd3diframe",
				"frameborder": "0",
				"scrolling": "no",
				"src": pluginStaticUrl+"/3dhopiframe.html?nexus="+isNexus+"&asset="+assetInfo.url
			});
		else
			if assetInfo.type == 'rti'
				# relight-Viewer
				iframe = CUI.dom.element("iframe", {
					id: "rtiiframe",
					"frameborder": "0",
					"scrolling": "no",
					"style": "width: 100%; height: 100%;",
					"src": pluginStaticUrl+"/rtiiframe.html?asset="+assetInfo.url
				});
			else
				# three.js-basierter Viewer
				if assetInfo.defaults
					iframe = CUI.dom.element("iframe", {
						id: "threeiframe",
						"frameborder": "0",
						"scrolling": "no",
						"src": pluginStaticUrl+"/threeiframe.html?asset="+assetInfo.url+"."+assetInfo.extension+"&config="+assetInfo.defaults
					});
				else
					iframe = CUI.dom.element("iframe", {
						id: "threeiframe",
						"frameborder": "0",
						"scrolling": "no",
						"src": pluginStaticUrl+"/threeiframe.html?asset="+assetInfo.url+"."+assetInfo.extension
					});

		viewerDiv.appendChild(iframe)
		CUI.dom.append(@outerDiv, viewerDiv)


ez5.session_ready =>
	AssetBrowser.plugins.registerPlugin(UBHD3DViewerPlugin)
	ez5.pluginManager.getPlugin("easydb-ubhd-3d-viewer-plugin").loadCss()
