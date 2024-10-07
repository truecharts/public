#!/bin/sh
occ_preview_generator_install() {
  echo '## Configuring Preview Generator...'
  install_app previewgenerator

  echo '## Configuring Preview Providers...'
  [ "${NX_PREVIEW_PROVIDERS:?"NX_PREVIEW_PROVIDERS is unset"}" ]

  # Adds Imaginary if enabled
  if [ "${NX_IMAGINARY:-"true"}" = "true" ]; then
    NX_PREVIEW_PROVIDERS="Imaginary ${NX_PREVIEW_PROVIDERS}"
  fi

  set_list 'enabledPreviewProviders' "${NX_PREVIEW_PROVIDERS}" 'system' 'OC\Preview\'

  echo '## Configuring Preview Generation Configuration...'
  occ config:system:set enable_previews --value=true
  occ config:system:set jpeg_quality --value="${NX_JPEG_QUALITY:-60}" --type=integer
  occ config:system:set preview_max_x --value="${NX_PREVIEW_MAX_X:-2048}" --type=integer
  occ config:system:set preview_max_y --value="${NX_PREVIEW_MAX_Y:-2048}" --type=integer
  occ config:system:set preview_max_memory --value="${NX_PREVIEW_MAX_MEMORY:-1024}" --type=integer
  occ config:system:set preview_max_filesize_image --value="${NX_PREVIEW_MAX_FILESIZE_IMAGE:-50}" --type=integer
  occ config:app:set previewgenerator squareSizes --value="${NX_PREVIEW_SQUARE_SIZES:-32 256}"
  occ config:app:set previewgenerator widthSizes --value="${NX_PREVIEW_WIDTH_SIZES:-256 384}"
  occ config:app:set previewgenerator heightSizes --value="${NX_PREVIEW_HEIGHT_SIZES:-256}"
  occ config:app:set preview jpeg_quality --value="${NX_JPEG_QUALITY:-60}"
}

occ_preview_generator_remove() {
  echo '## Removing Preview Generator...'
  remove_app previewgenerator

  echo '## Removing Preview Providers...'
  occ config:system:delete enabledPreviewProviders

  echo '## Removing Preview Generation Configuration...'
  occ config:system:set enable_previews --value=false
  occ config:system:delete jpeg_quality
  occ config:system:delete preview_max_x
  occ config:system:delete preview_max_y
  occ config:system:delete preview_max_memory
  occ config:system:delete preview_max_filesize_image
  occ config:app:delete previewgenerator squareSizes
  occ config:app:delete previewgenerator widthSizes
  occ config:app:delete previewgenerator heightSizes
  occ config:app:delete preview jpeg_quality
}
