PLUGIN_NAME = easydb-ubhd-3d-viewer-plugin

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(CSS) \
	$(WEB)/easydb-ubhd-3d-viewer-plugin.js \
	manifest.yml

EXTRA_FILES = \
        $(WEB)/3dhopiframe.html \
        $(WEB)/threeiframe.html \
        $(WEB)/right.png \
        $(WEB)/left.png \
        $(WEB)/wheel.png \
        $(WEB)/close.png \
        $(WEB)/close_on.png \
        $(WEB)/3DHOP/minimal/stylesheet/3dhop.css \
        $(WEB)/3DHOP/minimal/stylesheet/3dhop_panels.css \
        $(WEB)/3dhop_ubhd.css \
        $(WEB)/3DHOP/minimal/js/spidergl.js \
        $(WEB)/3DHOP/minimal/js/corto.js \
        $(WEB)/3DHOP/minimal/js/corto.em.js \
        $(WEB)/3DHOP/minimal/js/presenter.js \
        $(WEB)/3DHOP/minimal/js/jquery.js \
        $(WEB)/3DHOP/minimal/js/nexus.js \
        $(WEB)/3DHOP/minimal/js/ply.js \
        $(WEB)/3DHOP/minimal/js/trackball_sphere.js \
        $(WEB)/3DHOP/minimal/js/trackball_turntable.js \
        $(WEB)/3DHOP/minimal/js/trackball_turntable_pan.js \
        $(WEB)/3DHOP/minimal/js/trackball_pantilt.js \
        $(WEB)/init_3dhop_easydb.js \
        $(WEB)/ubhd-3d-viewer.js \
        $(WEB)/ubhd-3d-viewer.css \
        $(WEB)/rtiiframe.html \
        $(WEB)/relight/js/hammer.min.js \
        $(WEB)/relight/js/relight-core.js \
        $(WEB)/relight/js/relight-shaders.js \
        $(WEB)/relight/js/relight-canvas.js \
        $(WEB)/relight/js/relight-interface.js \
        $(WEB)/relight/css/relight.css \
        $(WEB)/relight/css/skins/dark/home.png \
        $(WEB)/relight/css/skins/dark/zoomin.png \
        $(WEB)/relight/css/skins/dark/zoomout.png \
        $(WEB)/relight/css/skins/dark/rotate.png \
        $(WEB)/relight/css/skins/dark/light_on.png \
        $(WEB)/relight/css/skins/dark/light.png \
        $(WEB)/relight/css/skins/dark/normals.png \
        $(WEB)/relight/css/skins/dark/normals_on.png \
        $(WEB)/relight/css/skins/dark/full.png \
        $(WEB)/relight/css/skins/dark/full_on.png \
        $(WEB)/relight/css/skins/dark/help.png \


# XXX: unavailable languages
#	$(WEB)/l10n/es-ES.json \
#	$(WEB)/l10n/it-IT.json \

L10N_FILES = l10n/easydb-ubhd-3d-viewer-plugin.csv

CSS = $(WEB)/easydb-ubhd-3d-viewer-plugin.css

SCSS_FILES = src/webfrontend/easydb-ubhd-3d-viewer-plugin.scss

COFFEE_FILES = \
	src/webfrontend/UBHD3DViewerPlugin.coffee

all: build

include easydb-library/tools/base-plugins.make

build: code css $(EXTRA_FILES)

code: $(JS) $(L10N)

clean: clean-base
