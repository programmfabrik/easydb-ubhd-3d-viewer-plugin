> This Plugin / Repo is being maintained by a community of developers.
There is no warranty given or bug fixing guarantee; especially not by
Programmfabrik GmbH. Please use the github issue tracking to report bugs
and self organize bug fixing. Feel free to directly contact the committing
developers.

# easydb-ubhd-3d-viewer-plugin
3D viewer plugin (Heidelberg University Library)

## Viewer based on [3D Heritage Online Presenter (3DHOP)](http://vcg.isti.cnr.it/3dhop/index.php)

Prerequisites:
The plugin expects assets in the Nexus (.nxs) format (http://vcg.isti.cnr.it/nexus/). The nexus files could be compressed (.nxz). The Nexus file does not have to be the preferred version of an asset. For example, it is possible to store an additional file version in Nexus format for an asset in ply format.

Alternatively, the plugin is able to display ply files. To make sure that the files don't contain too many faces (causes the browser to crash when 3DHOP displays them), the plugin expects the asset version name "preview_version". It is up to the user to import only suitable ply files.

## Viewer based on [three.js](https://threejs.org/)

Prerequisites:
The plugin expects assets in the binary form of the glTF format (.glb) (https://wiki.fileformat.com/3d/glb/). This format combines all files of a glTF object into one file.

Alternatively it is possible to put a glTF file (https://en.wikipedia.org/wiki/GlTF) together with other files (texture etc.) into a zip file. To indicate that a zip archive contains a 3D object in GLTF format, the corresponding asset version must have the name "gltf".
