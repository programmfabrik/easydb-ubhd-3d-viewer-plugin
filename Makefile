PLUGIN_NAME = ubhd-3d-viewer-plugin

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(CSS) \
	$(WEB)/ubhd-3d-viewer-plugin.js \
	ubhd-3d-viewer-plugin.config.yml

EXTRA_FILES = \
        $(WEB)/3dhopiframe.html \
        $(WEB)/threeiframe.html \
        $(WEB)/3dhop.css \
        $(WEB)/3dhop_ubhd.css \
        $(WEB)/spidergl.js \
        $(WEB)/corto.js \
        $(WEB)/presenter.js \
        $(WEB)/jquery.js \
        $(WEB)/nexus.js \
        $(WEB)/ply.js \
        $(WEB)/trackball_sphere.js \
        $(WEB)/trackball_turntable.js \
        $(WEB)/trackball_turntable_pan.js \
        $(WEB)/trackball_pantilt.js \
        $(WEB)/init.js \
        $(WEB)/ziploader.min.js \
        $(WEB)/three.js \
        $(WEB)/OrbitControls.js \
        $(WEB)/GLTFLoader.js \


# XXX: unavailable languages
#	$(WEB)/l10n/es-ES.json \
#	$(WEB)/l10n/it-IT.json \

L10N_FILES = l10n/ubhd-3d-viewer-plugin.csv

CSS = $(WEB)/ubhd-3d-viewer-plugin.css

SCSS_FILES = src/webfrontend/ubhd-3d-viewer-plugin.scss

COFFEE_FILES = \
	src/webfrontend/UBHD3DViewerPlugin.coffee

call_scss = sass --scss --no-cache --sourcemap=inline

all: build

include easydb-library/tools/base-plugins.make

build: code css $(EXTRA_FILES)

$(CSS): $(SCSS_FILES)
	mkdir -p $(dir $@)
	cat $(SCSS_FILES) | $(call_scss) > $(CSS)

code: $(JS) $(L10N)

css: $(CSS)

clean: clean-base
