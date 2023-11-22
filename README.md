> This Plugin / Repo is being maintained by a community of developers.
There is no warranty given or bug fixing guarantee; especially not by
Programmfabrik GmbH. Please use the github issue tracking to report bugs
and self organize bug fixing. Feel free to directly contact the committing
developers.

# easydb-ubhd-3d-viewer-plugin
3D viewer plugin (Heidelberg University Library)

**At the moment, this plugin is only a prototype!!!**

The plugin works roughly as follows (If one of these conditions is met, the following are no longer checked):

 * If a Nexus file (.nxs or .nxz) is found among the file variants of an asset, the 3DHOP viewer is invoked with this file.
 * If a ply model (.ply) is found among the file variants of an asset and the version name (explicitly named so by the user) is "ply", the 3DHOP viewer is invoked with this file. The check for the version name is done so that very large ply models are not automatically passed to the viewer, which may cause the user's browser to freeze.
 * If a zip file (.zip) is found among the file variants and the version name (explicitly named so by the user) is "gltf", the three.js based viewer is invoked with this file. **The zip variant may not be supported in the future and must be considered deprecated.**
 * If a glb (binary variant of gltf) model is found among the file variants of an asset, the three.js based viewer is invoked with this file.

## Viewer based on [3D Heritage Online Presenter (3DHOP)](http://vcg.isti.cnr.it/3dhop/index.php)

Prerequisites:
The plugin expects assets in the **Nexus (.nxs)** format (http://vcg.isti.cnr.it/nexus/). The nexus files could be compressed (.nxz). The Nexus file does not have to be the preferred version of an asset. For example, it is possible to store an additional file version in Nexus format for an asset in ply format.

Alternatively, the plugin is able to display **ply** files. To make sure that the files don't contain too many faces (causes the browser to crash when 3DHOP displays them), the plugin expects the asset version name "preview_version". It is up to the user to import only suitable ply files.

## Viewer based on [three.js](https://threejs.org/)

Prerequisites:
The plugin expects assets in the **binary form of the glTF format (.glb)** (https://wiki.fileformat.com/3d/glb/). This format combines all files of a glTF object into one file.

Alternatively it is possible to put a **glTF file (.gltf)** (https://en.wikipedia.org/wiki/GlTF) together with other files (texture etc.) into a zip file. To indicate that a zip archive contains a 3D object in GLTF format, the corresponding asset version must have the name "gltf".

## TODOs

At the moment we are working on extending the three.js based viewer (adding controls (e.g. for the different lighting types) as well as being able to save default settings per asset (position of the camera, position of the light source, illuminance levels) and pass them to the viewer.
