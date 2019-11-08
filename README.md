# easydb-ubhd-3d-viewer-plugin
3D Viewer Plugin der Universitäts Bibliothek Heidelberg

Uses [3D Heritage Online Presenter (3DHOP)](http://vcg.isti.cnr.it/3dhop/index.php).

Prerequisites:
The plugin expects assets in the Nexus (.nxs) format (http://vcg.isti.cnr.it/nexus/). The nexus files could be compressed (.nxz). The Nexus file does not have to be the preferred version of an asset. For example, it is possible to store an additional file version in Nexus format for an asset in ply format.

Alternatively, the plugin is able to display ply files. To make sure that the files don't contain too many faces (causes the browser to crash when 3DHOP displays them), the plugin expects the asset version name "preview_version". It is up to the user to import only suitable ply files.
